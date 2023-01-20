import 'package:codestories/features/codestories/domain/entity/user_entity.dart';
import 'package:hive/hive.dart';

abstract class LocalDataSource {
  int getIndex(UserEntity userEntity);

  Map<UserEntity, int> getAllIndexes(List<UserEntity> userList);

  Future<bool> setIndex(UserEntity userEntity, int newIndex);

  Future<bool> setAllIndexesToZero(List<UserEntity> userList);
}

class LocalDataSourceImpl extends LocalDataSource {
  var box = Hive.box('index');

  @override
  int getIndex(UserEntity userEntity) {
    return _getIndex(userEntity);
  }

  @override
  Map<UserEntity, int> getAllIndexes(List<UserEntity> userList) {
    return _getAllIndexes(userList);
  }

  @override
  Future<bool> setIndex(UserEntity userEntity, int newIndex) async {
    return _setIndex(userEntity, newIndex);
  }

  @override
  Future<bool> setAllIndexesToZero(List<UserEntity> userList) async {
    return _setAllIndexesToZero(userList);
  }

  int _getIndex(UserEntity userEntity) {
    int indexOfUser = box.get(userEntity.userId);
    return indexOfUser;
  }

  Map<UserEntity, int> _getAllIndexes(List<UserEntity> userList) {
    Map<UserEntity, int> allIndexesMap = {};
    for (var element in userList) {
      allIndexesMap[element] = box.get(element.userId);
    }
    return allIndexesMap;
  }

  Future<bool> _setIndex(UserEntity userEntity, int newIndex) async {
    await box.put(userEntity.userId, newIndex);
    return true;
  }

  Future<bool> _setAllIndexesToZero(List<UserEntity> userList) async {
    for (var value in userList) {
      await box.put(value.userId, 0);
    }
    return true;
  }
}
