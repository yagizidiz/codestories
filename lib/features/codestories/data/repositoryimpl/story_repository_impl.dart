import 'package:codestories/core/error/failure.dart';
import 'package:codestories/features/codestories/data/datasource/fake_remote_data_source.dart';
import 'package:codestories/features/codestories/data/datasource/local_datasource.dart';
import 'package:codestories/features/codestories/domain/entity/story_entity.dart';
import 'package:codestories/features/codestories/domain/entity/story_holder_entity.dart';
import 'package:codestories/features/codestories/domain/entity/story_package_entity.dart';
import 'package:codestories/features/codestories/domain/entity/user_entity.dart';
import 'package:codestories/features/codestories/domain/repository/story_repository.dart';
import 'package:codestories/locator.dart';
import 'package:dartz/dartz.dart';

class StoryRepositoryImpl extends StoryRepository {
  StoryHolderEntity storyHolderEntity = locator<StoryHolderEntity>();
  FakeRemoteDataSource fakeRemoteDataSource =
      locator<FakeRemoteDataSourceImpl>();
  LocalDataSource localDataSource = locator<LocalDataSourceImpl>();

  @override
  Future<Either<Failure, bool>> preloadStories() {
    return _preloadStories();
  }

  @override
  Either<Failure, StoryPackageEntity> getStoryPackage(UserEntity userEntity) {
    return _getStoryPackage(userEntity);
  }

  @override
  Future<Either<Failure, bool>> updateIndex(
      UserEntity userEntity, bool increment) {
    return _updateIndex(userEntity, increment);
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsersForStoryCircles() {
    return _getUsersForStoryCircles();
  }

  @override
  Either<Failure, Map<UserEntity, int>> getIndexMap() {
    return _getIndexMap();
  }

  Future<Either<Failure, bool>> _preloadStories() async {
    Map<UserEntity, List<StoryEntity>> tempStoryMap =
        await fakeRemoteDataSource.fetchUserStoryMap();
    List<UserEntity> tempUserList = tempStoryMap.keys.toList();
    storyHolderEntity.storyMap = tempStoryMap;
    storyHolderEntity.userList = tempUserList;
    localDataSource.setAllIndexesToZero(tempUserList);
    await Future.forEach(storyHolderEntity.userList, (element) async {
      await Future.forEach(storyHolderEntity.storyMap[element]!, (story) async {
        if (story is VideoStoryEntity) {
          await story.videoPlayerController.initialize();
        }
      });
    });
    return const Right(true);
  }

  Either<Failure, StoryPackageEntity> _getStoryPackage(UserEntity userEntity) {
    Map<UserEntity, StoryEntity> userStoryMap = {};
    Map<UserEntity, int> userIndexMap = {};
    for (var element in storyHolderEntity.userList) {
      userIndexMap[element] = localDataSource.getIndex(element);
    }
    for (var element in storyHolderEntity.userList) {
      userStoryMap[element] = storyHolderEntity.storyMap[element]!
          .elementAt(userIndexMap[element]!);
    }

    return right(StoryPackageEntity(
        currentUser: userEntity,
        storyMap: userStoryMap,
        userList: storyHolderEntity.userList));
  }

  Future<Either<Failure, List<UserEntity>>> _getUsersForStoryCircles() async {
    Map<UserEntity, List<StoryEntity>> userStoryMap =
        await fakeRemoteDataSource.fetchUserStoryMap();
    List<UserEntity> userList = userStoryMap.keys.toList();
    return Right(userList);
  }

  Future<Either<Failure, bool>> _updateIndex(
      UserEntity userEntity, bool increment) async {
    if (increment) {
      int length = storyHolderEntity.storyMap[userEntity]!.length;
      int currentIndex = localDataSource.getIndex(userEntity);
      if (currentIndex < length - 1) {
        await localDataSource.setIndex(userEntity, currentIndex + 1);
      }
    } else {
      int currentIndex = localDataSource.getIndex(userEntity);
      if (currentIndex > 0) {
        await localDataSource.setIndex(userEntity, currentIndex - 1);
      }
    }
    return const Right(true);
  }

  Either<Failure, Map<UserEntity, int>> _getIndexMap() {
    Map<UserEntity, int> userIndexMap = {};
    for (var element in storyHolderEntity.userList) {
      userIndexMap[element] = localDataSource.getIndex(element);
    }
    return right(userIndexMap);
  }
}
