import 'package:codestories/features/codestories/domain/entity/story_entity.dart';
import 'package:codestories/features/codestories/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

class StoryPackageEntity extends Equatable {
  final Map<UserEntity, StoryEntity> storyMap;
  final UserEntity currentUser;
  final List<UserEntity> userList;

  const StoryPackageEntity(
      {required this.currentUser,
      required this.storyMap,
      required this.userList,});

  @override
  List<Object?> get props => [storyMap, currentUser, userList];
}
