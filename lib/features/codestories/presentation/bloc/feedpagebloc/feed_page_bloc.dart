import 'package:bloc/bloc.dart';
import 'package:codestories/core/error/failure.dart';
import 'package:codestories/core/usecase/usecase.dart';
import 'package:codestories/features/codestories/domain/entity/user_entity.dart';
import 'package:codestories/features/codestories/domain/usecase/get_users_for_story_circles.dart';
import 'package:codestories/features/codestories/domain/usecase/preload_stories_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'feed_page_event.dart';

part 'feed_page_state.dart';

class FeedPageBloc extends Bloc<FeedPageEvent, FeedPageState> {
  FeedPageBloc() : super(FeedPageInitial()) {
    on<FeedPageFetchAndPreloadStoriesEvent>((event, emit) async {
      Either<Failure, List<UserEntity>> userListResponse =
          await GetUsersForStoryCircles().call(NoParams());

      userListResponse.fold((l) => emit(FeedPageInitial()),
          (r) => emit(FeedPageStoriesNotLoadedState(userList: r)));

      Either<Failure, bool> preloadStoriesResponse =
          await PreloadStories().call(NoParams());

      preloadStoriesResponse.fold((l) => emit(FeedPageInitial()), (r) {
        userListResponse.fold((l) => emit(FeedPageInitial()),
            (r) => emit(FeedPageStoriesLoadedState(userList: r)));
      });
    });
    on<RefreshFeedPageEvent>((event, emit) async {
      Either<Failure, List<UserEntity>> userListResponse =
          await GetUsersForStoryCircles().call(NoParams());
      userListResponse.fold((l) => emit(FeedPageInitial()),
          (r) => emit(FeedPageStoriesNotLoadedState(userList: r)));
    });
  }
}
