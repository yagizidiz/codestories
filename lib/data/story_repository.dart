import 'package:codestories/models/story_model.dart';
import 'package:codestories/models/user_model.dart';
import 'package:hive/hive.dart';
import 'dummy_lists.dart';

class StoryRepo {
  Future<List<User>> getUserStoryList() async {
    return userProfileList;
  }

  Future<Map<String, List<Story>>> getStoryMap() async {
    return userStoryMap;
  }

  var box = Hive.box('indexes');

  Future<Map<String, int>> getIndexMap() async {
    final Map<String, int> indexMap = {};
    for (var element in box.keys) {
      indexMap[element] = box.get(element);
    }
    return indexMap;
  }
Future<void> putIndexMap(Map<String,int> indexMap)async{
    await box.putAll(indexMap);
    return;
}

  Future<List<User>> getUserList() async {
    return userProfileList;
  }
}
