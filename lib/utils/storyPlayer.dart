import 'package:cached_network_image/cached_network_image.dart';
import 'package:codestories/models/story_model.dart';
import 'package:codestories/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


//Our Storyplayer specialized on displaying two types of stories in a cubic page view,
class StoryPlayer extends StatefulWidget {
  //storyCount hold the value of story number to display the progress bar for each package
  final int storyCount;
  //storyIndex holds the index in the storyCount so our progress bar will animated on that index and rest will be completed or empty.
  final int storyIndex;
  //User object for owner of the stories and story package,
  final User user;
  //Story object for the story that will get displayed.
  final Story story;
  //isPlaying bool to stop playing stories if they are not the current page in pageview
  final bool isPlaying;
  //Callback function to handle transitions to next story in the parental pageview
  final Function(int) nextCall;
  //Callback function to handle transitions to previous story in the parental pageview
  final Function(int) prevCall;
  //StoryPlayers index in the pageview to use in callback functions.
  final int pageIndex;
  //Callback function to close stories
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
//To use animation our state uses SingleTickerProviderStateMixin classes features.
class _StoryPlayerState extends State<StoryPlayer>
    with SingleTickerProviderStateMixin {
  //animation controller declaration, it helps us in our story progress bar's animation.
  late AnimationController _animationController;

  @override
  void initState() {
    //If the widget's story's media type is video, widget creates an animation controller with the same duration with the video, else duration is 5 seconds for images.
    if (widget.story.mediaType == MediaType.video) {
      if (widget.story.videoController!.value.isInitialized) {
        widget.story.videoController!.seekTo(Duration.zero);
        _animationController = AnimationController(
            vsync: this,
            duration: widget.story.videoController!.value.duration);
        _animationController.reset();
        widget.story.videoController!.seekTo(Duration.zero);
//if widget is playing , animation and video controllers are starting to play here
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
    //status listener is attached to animation controller so it triggers the callback function which goes to the next story if there is one.
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
  //almost same configurations with the init state but widget's build function is triggered in pageview without initstate is being triggered, this part updates widget after pageview
  //rebuilds the widget without needed information updated.
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
//dispose disposes the animation controller
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        //opaque behavior makes gesture detector to use all screen.
        behavior: HitTestBehavior.opaque,
        //double tap triggers close event with callback function
        onDoubleTap: widget.closeCall,
        //tapdowns and tapups to handle stop&play events and next previous story calls
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
        //the player itself controlled with controllers and taps starts here, stack is both for story player and progress bar
        child: Stack(
          children: [
            Positioned(
                top: 10,
                child: SizedBox(
                  height: 2,
                  width: MediaQuery.of(context).size.width,
                  //progress bars are rendered here according to the attributes in widget
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
            //Players for image and video stories
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
