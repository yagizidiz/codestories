part of 'feed_page_bloc.dart';

abstract class FeedPageEvent extends Equatable {
  const FeedPageEvent();
}

class FeedPageFetchAndPreloadStoriesEvent extends FeedPageEvent {
  const FeedPageFetchAndPreloadStoriesEvent();

  @override
  List<Object?> get props => [];
}

//TODO: temporary solution
class RefreshFeedPageEvent extends FeedPageEvent {
  @override
  List<Object?> get props => [];
}
