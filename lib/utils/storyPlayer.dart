import 'package:cached_network_image/cached_network_image.dart';
import 'package:codestories/models/story_model.dart';
import 'package:codestories/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StoryPlayer extends StatefulWidget {
  final int storyCount;
  final int storyIndex;
  final User user;
  final Story story;
  final bool isPlaying;
  final Function(int) nextCall;
  final Function(int) prevCall;
  final int pageIndex;
  final VoidCallback closeCall;

  const StoryPlayer(
      {Key? key,
      required this.user,
      required this.story,
      required this.storyCount,
      required this.storyIndex,
      required this.isPlaying,
      required this.prevCall,
      required this.nextCall,
      required this.pageIndex,
      required this.closeCall})
      : super(key: key);

  @override
  State<StoryPlayer> createState() => _StoryPlayerState();
}

class _StoryPlayerState extends State<StoryPlayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    debugPrint('initstate');
    if (widget.story.mediaType == MediaType.video) {
      if (widget.story.videoController!.value.isInitialized) {
        widget.story.videoController!.seekTo(Duration.zero);
        _animationController = AnimationController(
            vsync: this,
            duration: widget.story.videoController!.value.duration);
        _animationController.reset();
        widget.story.videoController!.seekTo(Duration.zero);

        if (widget.isPlaying) {
          widget.story.videoController!.play();
          _animationController.forward();
        } else {
          widget.story.videoController!.pause();
          _animationController.stop();
        }
        setState(() {});
      }
    } else {
      _animationController = AnimationController(
          vsync: this, duration: const Duration(seconds: 5));
      _animationController.forward();
      setState(() {});
    }
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.story.mediaType == MediaType.video) {
          widget.nextCall(widget.pageIndex);
//          widget.story.videoController!.pause();
          widget.story.videoController!.seekTo(Duration.zero);
          _animationController.reset();
          _animationController.forward();
        } else {
          widget.nextCall(widget.pageIndex);
          _animationController.reset();
          _animationController.forward();
        }
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(old) {
    super.didUpdateWidget(old);
    if (widget.isPlaying) {
      _animationController.reset();
      if (widget.story.mediaType == MediaType.image) {
        _animationController.duration == const Duration(seconds: 5);
      } else if (widget.story.mediaType == MediaType.video) {
        _animationController.duration =
            widget.story.videoController!.value.duration;
        widget.story.videoController!.seekTo(Duration.zero);
        widget.story.videoController!.play();
      }
      _animationController.forward();
    } else {
      _animationController.reset();
      _animationController.stop();
      if (widget.story.mediaType == MediaType.video) {
        widget.story.videoController!.seekTo(Duration.zero);
        widget.story.videoController!.pause();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onDoubleTap: widget.closeCall,
        onTapDown: (det) {
          if (widget.story.mediaType == MediaType.video) {
            widget.story.videoController!.pause();
          }
          _animationController.stop();
        },
        onTapUp: (details) {
          if (widget.story.mediaType == MediaType.video) {
            widget.story.videoController!.play();
          }
          _animationController.forward();
          if (details.globalPosition.dx <
              MediaQuery.of(context).size.width / 3) {
            widget.prevCall(widget.pageIndex);
            setState(() {});
          } else if (details.globalPosition.dx >
              MediaQuery.of(context).size.width * 2 / 3) {
            widget.nextCall(widget.pageIndex);
            setState(() {});
          }
        },
        child: Stack(
          children: [
            Positioned(
                top: 10,
                child: SizedBox(
                  height: 2,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.storyCount,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.fromLTRB(1.5, 0, 1.5, 0),
                            width: MediaQuery.of(context).size.width /
                                widget.storyCount,
                            child: widget.storyIndex == index
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
                                        widget.storyIndex > index ? 1.0 : 0.0));
                      }),
                )),
            Center(
              child: widget.story.mediaType == MediaType.video
                  ? AspectRatio(
                      aspectRatio:
                          widget.story.videoController!.value.aspectRatio,
                      child: VideoPlayer(widget.story.videoController!),
                    )
                  : CachedNetworkImage(imageUrl: widget.story.mediaUrl),
            )
          ],
        ),
      ),
    );
  }
}
