import 'package:codestories/core/error/failure.dart';
import 'package:codestories/core/usecase/usecase.dart';
import 'package:codestories/features/codestories/data/repositoryimpl/story_repository_impl.dart';
import 'package:codestories/features/codestories/domain/entity/user_entity.dart';
import 'package:codestories/features/codestories/domain/repository/story_repository.dart';
import 'package:codestories/locator.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateIndex implements UseCase<bool, UpdateIndexParams> {
  final StoryRepository storyRepository = locator<StoryRepositoryImpl>();

  @override
  Future<Either<Failure, bool>> call(UpdateIndexParams params) {
    return storyRepository.updateIndex(params.userEntity, params.increment);
  }
}

class UpdateIndexParams extends Equatable {
  final UserEntity userEntity;
  final bool increment;

  const UpdateIndexParams({required this.userEntity, required this.increment});

  @override
  List<Object?> get props => [userEntity, increment];
}
