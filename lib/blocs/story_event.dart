part of 'story_bloc.dart';
//Story Bloc Events
@immutable
abstract class StoryEvent extends Equatable {
  const StoryEvent();
//Overriding the equation operation with equatable package to have a value type approach
  @override
  List<Object> get props => [];
}

class StoryIndexPreloadEvent extends StoryEvent {
  const StoryIndexPreloadEvent();
}

class StoryOpenedEvent extends StoryEvent {
  final User user;

  const StoryOpenedEvent({required this.user});
}

class StoryClosedEvent extends StoryEvent {
  final Map<String, int> indexMap;
  const StoryClosedEvent({required this.indexMap});
}

