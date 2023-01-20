import 'package:codestories/core/error/failure.dart';
import 'package:codestories/core/usecase/usecase.dart';
import 'package:codestories/features/codestories/data/repositoryimpl/story_repository_impl.dart';
import 'package:codestories/features/codestories/domain/entity/user_entity.dart';
import 'package:codestories/features/codestories/domain/repository/story_repository.dart';
import 'package:codestories/locator.dart';
import 'package:dartz/dartz.dart';

class GetUsersForStoryCircles implements UseCase<List<UserEntity>, NoParams> {
  final StoryRepository storyRepository = locator<StoryRepositoryImpl>();

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) async {
    return await storyRepository.getUsersForStoryCircles();
  }
}
