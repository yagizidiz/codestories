import 'package:bloc/bloc.dart';
import 'package:codestories/core/error/failure.dart';
import 'package:codestories/features/codestories/domain/entity/story_package_entity.dart';
import 'package:codestories/features/codestories/domain/entity/user_entity.dart';
import 'package:codestories/features/codestories/domain/usecase/get_story_package_usecase.dart';
import 'package:codestories/features/codestories/domain/usecase/update_index_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'storyplayer_page_event.dart';

part 'storyplayer_page_state.dart';

class StoryPlayerPageBloc
    extends Bloc<StoryPlayerPageEvent, StoryPlayerPageState> {
  StoryPlayerPageBloc() : super(StoryPlayerPageInitial()) {
    on<StoryOpenedByUserEvent>((event, emit) async {
      emit(StoryPlayerPageRefreshState());
      Either<Failure, StoryPackageEntity> getStoryPackageResult =
          await GetStoryPackage()
              .call(GetStoryPackageParams(userEntity: event.userEntity));
      getStoryPackageResult.fold((l) => emit(const StoryPlayerFailureState()),
          (r) => emit(StoryPlayerPagePlayingState(storyPackageEntity: r)));
    });
    on<StoryClosedEvent>((event, emit) {
      emit(const StoryPlayerPageNotPlayingState());
    });
    on<NextStoryOpenedByUserEvent>((event, emit) async {
      emit(const StoryPlayerPageRefreshState());
      Either<Failure, bool> updateIndexIncrementResult = await UpdateIndex()
          .call(
              UpdateIndexParams(userEntity: event.userEntity, increment: true));
      updateIndexIncrementResult.fold(
          (l) => emit(const StoryPlayerFailureState()), (r) => null);
      Either<Failure, StoryPackageEntity> getStoryPackageResult =
          await GetStoryPackage()
              .call(GetStoryPackageParams(userEntity: event.userEntity));
      getStoryPackageResult.fold((l) => emit(const StoryPlayerFailureState()),
          (r) => emit(StoryPlayerPagePlayingState(storyPackageEntity: r)));
    });
    on<PreviousStoryOpenedByUserEvent>((event, emit) async {
      emit(const StoryPlayerPageRefreshState());
      Either<Failure, bool> updateIndexDecrementResult = await UpdateIndex()
          .call(UpdateIndexParams(
              userEntity: event.userEntity, increment: false));
      updateIndexDecrementResult.fold(
          (l) => emit(const StoryPlayerFailureState()), (r) => null);
      Either<Failure, StoryPackageEntity> getStoryPackageResult =
          await GetStoryPackage()
              .call(GetStoryPackageParams(userEntity: event.userEntity));
      getStoryPackageResult.fold((l) => emit(const StoryPlayerFailureState()),
          (r) => emit(StoryPlayerPagePlayingState(storyPackageEntity: r)));
    });
  }
}
