import 'package:codestories/core/constant/enum.dart';
import 'package:codestories/core/extension/context_extension.dart';
import 'package:codestories/features/codestories/domain/entity/story_entity.dart';
import 'package:codestories/features/codestories/presentation/bloc/storyplayerpagebloc/storyplayer_page_bloc.dart';
import 'package:codestories/locator.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageStoryPlayer extends StatefulWidget {
  final PlayerState playerState;
  final ImageStoryEntity imageStoryEntity;
  final VoidCallback nextCall;
  final VoidCallback prevCall;
  final StoryPlayerPageBloc storyPlayerPageBloc =
      locator<StoryPlayerPageBloc>();

  ImageStoryPlayer(
      {Key? key,
      required this.imageStoryEntity,
      required this.playerState,
      required this.nextCall,
      required this.prevCall})
      : super(key: key);

  @override
  State<ImageStoryPlayer> createState() => _ImageStoryPlayerState();
}

class _ImageStoryPlayerState extends State<ImageStoryPlayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _animationController.reset();
    if (widget.playerState == PlayerState.play) {
      _animationController.forward();
    }
    setState(() {});
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.imageStoryEntity.storyIndex <
            widget.imageStoryEntity.storyCount - 1) {
          widget.storyPlayerPageBloc.add(NextStoryOpenedByUserEvent(
              userEntity: widget.imageStoryEntity.userEntity));
        } else {
          widget.nextCall();
        }
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ImageStoryPlayer oldWidget) {
    if (widget.playerState == PlayerState.play) {
      if (oldWidget.imageStoryEntity != widget.imageStoryEntity) {
        _animationController.duration = const Duration(seconds: 5);
        _animationController.reset();
      }
      _animationController.forward();
      setState(() {});
      _animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (widget.imageStoryEntity.storyIndex <
              widget.imageStoryEntity.storyCount - 1) {
            widget.storyPlayerPageBloc.add(NextStoryOpenedByUserEvent(
                userEntity: widget.imageStoryEntity.userEntity));
          } else {
            widget.nextCall();
          }
          setState(() {});
        }
      });
    } else if (widget.playerState == PlayerState.stop) {
      _animationController.stop();
    } else if (widget.playerState == PlayerState.reset) {
      _animationController.reset();
    } else {}
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onDoubleTap: () {
        _animationController.stop();
        widget.storyPlayerPageBloc.add(const StoryClosedEvent());
      },
      onTapDown: (_) {
        _animationController.stop();
        setState(() {});
      },
      onTapUp: (details) {
        if (details.globalPosition.dx < context.dynamicWidth(1) / 3) {
          if (widget.imageStoryEntity.storyIndex > 0) {
            widget.storyPlayerPageBloc.add(PreviousStoryOpenedByUserEvent(
                userEntity: widget.imageStoryEntity.userEntity));
          } else {
            widget.prevCall();
          }
          _animationController.forward();
        } else if (details.globalPosition.dx >
            context.dynamicWidth(1) * 2 / 3) {
          if (widget.imageStoryEntity.storyIndex <
              widget.imageStoryEntity.storyCount - 1) {
            widget.storyPlayerPageBloc.add(NextStoryOpenedByUserEvent(
                userEntity: widget.imageStoryEntity.userEntity));
          } else {
            widget.nextCall();
          }
          _animationController.forward();
        } else {
          _animationController.forward();
          setState(() {});
        }
      },
      child: Stack(
        children: [
          Positioned(
              top: 10,
              child: SizedBox(
                height: 2,
                width: context.dynamicWidth(1),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.imageStoryEntity.storyCount,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: const EdgeInsets.fromLTRB(1.5, 0, 1.5, 0),
                          width: context.dynamicWidth(
                              1 / widget.imageStoryEntity.storyCount),
                          child: widget.imageStoryEntity.storyIndex == index
                              ? AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (BuildContext ctx, Widget? child) {
                                    return LinearProgressIndicator(
                                      backgroundColor:
                                          Colors.white.withOpacity(0.5),
                                      color: Colors.white,
                                      value: _animationController.value,
                                    );
                                  })
                              : LinearProgressIndicator(
                                  backgroundColor:
                                      Colors.white.withOpacity(0.5),
                                  color: Colors.white,
                                  value:
                                      widget.imageStoryEntity.storyIndex > index
                                          ? 1.0
                                          : 0.0));
                    }),
              )),
          Center(
              child: CachedNetworkImage(
                  imageUrl: widget.imageStoryEntity.mediaUrl))
        ],
      ),
    );
  }
}
