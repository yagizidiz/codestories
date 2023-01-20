import 'package:codestories/features/codestories/domain/entity/story_entity.dart';
import 'package:codestories/features/codestories/domain/entity/user_entity.dart';

class StoryHolderEntity {
  Map<UserEntity, List<StoryEntity>> storyMap = {};
  List<UserEntity> userList = [];

  StoryHolderEntity();
}
