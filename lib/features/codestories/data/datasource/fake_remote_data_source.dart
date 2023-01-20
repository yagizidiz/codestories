import 'package:codestories/features/codestories/data/datasource/mock/mock_data.dart';
import 'package:codestories/features/codestories/domain/entity/story_entity.dart';
import 'package:codestories/features/codestories/domain/entity/user_entity.dart';
import 'package:video_player/video_player.dart';

abstract class FakeRemoteDataSource {
  Future<Map<UserEntity, List<StoryEntity>>> fetchUserStoryMap();
}

class FakeRemoteDataSourceImpl extends FakeRemoteDataSource {
  @override
  Future<Map<UserEntity, List<StoryEntity>>> fetchUserStoryMap() {
    return _fetchUserStoryMap();
  }

  Future<Map<UserEntity, List<StoryEntity>>> _fetchUserStoryMap() async {
    Map<UserEntity, List<StoryEntity>> userStoryMap = {};
    for (var element in userProfileAndStoryInformations["userstorylist"]!) {
      List<StoryEntity> tempStoryList = [];
      UserEntity userEntity = UserEntity(
          userId: (element["user"]! as Map)["username"],
          profilePictureUrl: (element["user"]! as Map)["profilepictureurl"]);
      for (var value in (element["stories"] as List)) {
        if ((value as Map)["mediatype"] == "video") {
          tempStoryList.add(VideoStoryEntity(
              userEntity: userEntity,
              storyIndex: (element["stories"] as List).indexOf(value),
              storyCount: (element["stories"] as List).length,
              videoPlayerController:
                  VideoPlayerController.network(value["mediaurl"])));
        } else if (value["mediatype"] == "image") {
          tempStoryList.add(ImageStoryEntity(
              userEntity: userEntity,
              storyIndex: (element["stories"] as List).indexOf(value),
              storyCount: (element["stories"] as List).length,
              mediaUrl: value["mediaurl"]));
        }
      }
      userStoryMap[userEntity] = tempStoryList;
    }
    return userStoryMap;
  }
}
