import 'package:codestories/core/error/failure.dart';
import 'package:codestories/core/usecase/usecase.dart';
import 'package:codestories/features/codestories/data/repositoryimpl/story_repository_impl.dart';
import 'package:codestories/features/codestories/domain/entity/story_package_entity.dart';
import 'package:codestories/features/codestories/domain/entity/user_entity.dart';
import 'package:codestories/features/codestories/domain/repository/story_repository.dart';
import 'package:codestories/locator.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetStoryPackage
    implements UseCase<StoryPackageEntity, GetStoryPackageParams> {
  final StoryRepository storyRepository = locator<StoryRepositoryImpl>();

  @override
  Future<Either<Failure, StoryPackageEntity>> call(
      GetStoryPackageParams getStoryPackageParams) async {
    return storyRepository.getStoryPackage(getStoryPackageParams.userEntity);
  }
}

class GetStoryPackageParams extends Equatable {
  final UserEntity userEntity;

  const GetStoryPackageParams({required this.userEntity});

  @override
  List<Object?> get props => [userEntity];
}
