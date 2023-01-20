part of 'feed_page_bloc.dart';

abstract class FeedPageState extends Equatable {
  const FeedPageState();
}

class FeedPageInitial extends FeedPageState {
  @override
  List<Object> get props => [];
}

class FeedPageStoriesNotLoadedState extends FeedPageState {
  final List<UserEntity> userList;

  const FeedPageStoriesNotLoadedState({required this.userList});

  @override
  List<Object?> get props => [userList];
}

class FeedPageStoriesLoadedState extends FeedPageState {
  final List<UserEntity> userList;

  const FeedPageStoriesLoadedState({required this.userList});

  @override
  List<Object?> get props => [userList];
//TODO: Implement failure state
}
