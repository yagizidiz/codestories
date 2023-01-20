import 'package:codestories/core/constant/enum.dart';
import 'package:codestories/core/extension/context_extension.dart';
import 'package:codestories/features/codestories/domain/entity/story_entity.dart';
import 'package:codestories/features/codestories/presentation/bloc/storyplayerpagebloc/storyplayer_page_bloc.dart';
import 'package:codestories/locator.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoStoryPlayer extends StatefulWidget {
  final PlayerState playerState;
  final VideoStoryEntity videoStoryEntity;
  final VoidCallback nextCall;
  final VoidCallback prevCall;
  final StoryPlayerPageBloc storyPlayerPageBloc =
      locator<StoryPlayerPageBloc>();

  VideoStoryPlayer(
      {Key? key,
      required this.videoStoryEntity,
      required this.playerState,
      required this.nextCall,
      required this.prevCall})
      : super(key: key);

  @override
  State<VideoStoryPlayer> createState() => _VideoStoryPlayerState();
}

class _VideoStoryPlayerState extends State<VideoStoryPlayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: widget.videoStoryEntity.videoPlayerController.value.duration);
    _animationController.reset();
    if (widget.playerState == PlayerState.play) {
      widget.videoStoryEntity.videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {});
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.videoStoryEntity.videoPlayerController.pause();
        widget.videoStoryEntity.videoPlayerController.seekTo(Duration.zero);
        if (widget.videoStoryEntity.storyIndex <
            widget.videoStoryEntity.storyCount - 1) {
          widget.storyPlayerPageBloc.add(NextStoryOpenedByUserEvent(
              userEntity: widget.videoStoryEntity.userEntity));
        } else {
          widget.nextCall();
        }
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant VideoStoryPlayer oldWidget) {
    if (widget.playerState == PlayerState.play) {
      if (oldWidget.videoStoryEntity != widget.videoStoryEntity) {
        _animationController.duration =
            widget.videoStoryEntity.videoPlayerController.value.duration;
        _animationController.reset();
      }
      widget.videoStoryEntity.videoPlayerController.play();
      _animationController.forward();
      setState(() {});
      _animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.videoStoryEntity.videoPlayerController.pause();
          widget.videoStoryEntity.videoPlayerController.seekTo(Duration.zero);
          if (widget.videoStoryEntity.storyIndex <
              widget.videoStoryEntity.storyCount - 1) {
            widget.storyPlayerPageBloc.add(NextStoryOpenedByUserEvent(
                userEntity: widget.videoStoryEntity.userEntity));
          } else {
            widget.nextCall();
          }
          setState(() {});
        }
      });
    } else if (widget.playerState == PlayerState.stop) {
      _animationController.stop();
      widget.videoStoryEntity.videoPlayerController.pause();
    } else if (widget.playerState == PlayerState.reset) {
      _animationController.reset();
      widget.videoStoryEntity.videoPlayerController.pause();
      widget.videoStoryEntity.videoPlayerController.seekTo(Duration.zero);
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
        widget.videoStoryEntity.videoPlayerController.pause();
        _animationController.stop();
        widget.storyPlayerPageBloc.add(const StoryClosedEvent());
      },
      onTapDown: (_) {
        widget.videoStoryEntity.videoPlayerController.pause();
        _animationController.stop();
        setState(() {});
      },
      onTapUp: (details) {
        debugPrint(widget.videoStoryEntity.storyIndex.toString());
        if (details.globalPosition.dx < context.dynamicWidth(1) / 3) {
          if (widget.videoStoryEntity.storyIndex > 0) {
            widget.storyPlayerPageBloc.add(PreviousStoryOpenedByUserEvent(
                userEntity: widget.videoStoryEntity.userEntity));
          } else {
            widget.prevCall();
          }
          widget.videoStoryEntity.videoPlayerController.play();
          _animationController.forward();
        } else if (details.globalPosition.dx >
            context.dynamicWidth(1) * 2 / 3) {
          if (widget.videoStoryEntity.storyIndex <
              widget.videoStoryEntity.storyCount - 1) {
            widget.storyPlayerPageBloc.add(NextStoryOpenedByUserEvent(
                userEntity: widget.videoStoryEntity.userEntity));
          } else {
            widget.nextCall();
          }
          widget.videoStoryEntity.videoPlayerController.play();
          _animationController.forward();
        } else {
          widget.videoStoryEntity.videoPlayerController.play();
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
                    itemCount: widget.videoStoryEntity.storyCount,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: const EdgeInsets.fromLTRB(1.5, 0, 1.5, 0),
                          width: context.dynamicWidth(
                              1 / widget.videoStoryEntity.storyCount),
                          child: widget.videoStoryEntity.storyIndex == index
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
                                      widget.videoStoryEntity.storyIndex > index
                                          ? 1.0
                                          : 0.0));
                    }),
              )),
          Center(
            child: AspectRatio(
                aspectRatio: widget
                    .videoStoryEntity.videoPlayerController.value.aspectRatio,
                child:
                    VideoPlayer(widget.videoStoryEntity.videoPlayerController)),
          )
        ],
      ),
    );
  }
}
