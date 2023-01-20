part of 'storyplayer_page_bloc.dart';

abstract class StoryPlayerPageEvent extends Equatable {
  const StoryPlayerPageEvent();
}

class StoryOpenedByUserEvent extends StoryPlayerPageEvent {
  final UserEntity userEntity;

  const StoryOpenedByUserEvent({required this.userEntity});

  @override
  List<Object?> get props => [userEntity];
}

class StoryClosedEvent extends StoryPlayerPageEvent {
  const StoryClosedEvent();

  @override
  List<Object?> get props => [];
}

class NextStoryOpenedByUserEvent extends StoryPlayerPageEvent {
  final UserEntity userEntity;
  const NextStoryOpenedByUserEvent({required this.userEntity});

  @override
  List<Object?> get props => [userEntity];
}

class PreviousStoryOpenedByUserEvent extends StoryPlayerPageEvent {
  final UserEntity userEntity;
  const PreviousStoryOpenedByUserEvent({required this.userEntity});

  @override
  List<Object?> get props => [userEntity];
}
