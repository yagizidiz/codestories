import 'package:codestories/models/story_model.dart';
import 'package:codestories/models/user_model.dart';
import 'package:hive/hive.dart';
import 'dummy_lists.dart';
//Story Repository is the class which contains the needed methods about stories and its used by a locator instance of it in bloc
class StoryRepo {
  //This one gets user profile list
  Future<List<User>> getUserStoryList() async {
    return userProfileList;
  }
//This one gets story map
  Future<Map<String, List<Story>>> getStoryMap() async {
    return userStoryMap;
  }

  var box = Hive.box('indexes');
//this one gets index map from the local database we are using with hive package
  Future<Map<String, int>> getIndexMap() async {
    final Map<String, int> indexMap = {};
    for (var element in box.keys) {
      indexMap[element] = box.get(element);
    }
    return indexMap;
  }
  //this one updates the index map
Future<void> putIndexMap(Map<String,int> indexMap)async{
    await box.putAll(indexMap);
    return;
}
//this one gets user list
  Future<List<User>> getUserList() async {
    return userProfileList;
  }
}
