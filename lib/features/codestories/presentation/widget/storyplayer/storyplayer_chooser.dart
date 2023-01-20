import 'package:codestories/core/constant/enum.dart';
import 'package:codestories/features/codestories/domain/entity/story_entity.dart';
import 'package:codestories/features/codestories/presentation/widget/storyplayer/image_storyplayer.dart';
import 'package:codestories/features/codestories/presentation/widget/storyplayer/video_storyplayer.dart';
import 'package:flutter/material.dart';

class StoryPlayerChooser extends StatelessWidget {
  final StoryEntity storyEntity;
  final PlayerState playerState;
  final VoidCallback nextCall;
  final VoidCallback prevCall;

  const StoryPlayerChooser(
      {Key? key,
      required this.storyEntity,
      required this.playerState,
      required this.prevCall,
      required this.nextCall})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    if (storyEntity is VideoStoryEntity) {
      return VideoStoryPlayer(
        videoStoryEntity: storyEntity as VideoStoryEntity,
        playerState: playerState,
        nextCall: nextCall,
        prevCall: prevCall,
      );
    } else if (storyEntity is ImageStoryEntity) {
      return ImageStoryPlayer(
        imageStoryEntity: storyEntity as ImageStoryEntity,
        playerState: playerState,
        nextCall: nextCall,
        prevCall: prevCall,
      );
    } else {
      return Container();
    }
  }
}
