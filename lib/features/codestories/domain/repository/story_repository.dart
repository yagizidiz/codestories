import 'package:codestories/core/error/failure.dart';
import 'package:codestories/features/codestories/domain/entity/story_package_entity.dart';
import 'package:codestories/features/codestories/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class StoryRepository {
  Future<Either<Failure, bool>> preloadStories();

  Future<Either<Failure, bool>> updateIndex(
      UserEntity userEntity, bool increment);

  Either<Failure, Map<UserEntity, int>> getIndexMap();

  Future<Either<Failure, List<UserEntity>>> getUsersForStoryCircles();

  Either<Failure, StoryPackageEntity> getStoryPackage(UserEntity userEntity);
}
