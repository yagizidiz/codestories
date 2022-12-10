part of 'story_bloc.dart';

@immutable
abstract class StoryState extends Equatable {
  const StoryState();

  @override
  List<Object> get props => [];
}

class StoryInitialState extends StoryState {
  const StoryInitialState();
}

class StoriesLoadedState extends StoryState {
  const StoriesLoadedState();
}

class StoryWatchingState extends StoryState {
  final Map<String, List<Story>> storyMap;
  final User user;
  final Map<String, int> indexMap;
  final List<User> userList;

  const StoryWatchingState(
      {required this.user,
      required this.storyMap,
      required this.indexMap,
      required this.userList});
}

class StoryLoadingState extends StoryState {
  const StoryLoadingState();
}