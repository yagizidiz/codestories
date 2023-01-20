import 'package:codestories/core/error/failure.dart';
import 'package:codestories/core/usecase/usecase.dart';
import 'package:codestories/features/codestories/data/repositoryimpl/story_repository_impl.dart';
import 'package:codestories/features/codestories/domain/repository/story_repository.dart';
import 'package:codestories/locator.dart';
import 'package:dartz/dartz.dart';

class PreloadStories implements UseCase<bool, NoParams> {
  final StoryRepository storyRepository = locator<StoryRepositoryImpl>();

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await storyRepository.preloadStories();
  }
}