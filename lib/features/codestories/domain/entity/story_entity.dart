import 'package:codestories/features/codestories/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

class StoryEntity extends Equatable {
  final UserEntity userEntity;
  final int storyIndex;
  final int storyCount;

  const StoryEntity({
    required this.userEntity,
    required this.storyIndex,
    required this.storyCount,
  });

  @override
  List<Object?> get props => [userEntity, storyIndex, storyCount];
}

class VideoStoryEntity extends StoryEntity {
  final VideoPlayerController videoPlayerController;

  const VideoStoryEntity(
      {required super.userEntity,
      required super.storyIndex,
      required super.storyCount,
      required this.videoPlayerController});

  @override
  List<Object?> get props =>
      [userEntity, storyIndex, storyCount, videoPlayerController];
}

class ImageStoryEntity extends StoryEntity {
  final String mediaUrl;

  const ImageStoryEntity(
      {required super.userEntity,
      required super.storyIndex,
      required super.storyCount,
      required this.mediaUrl});

  @override
  List<Object?> get props => [userEntity, storyIndex, storyCount, mediaUrl];
}
