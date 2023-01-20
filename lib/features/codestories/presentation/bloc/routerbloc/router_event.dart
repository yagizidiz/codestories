part of 'router_bloc.dart';

abstract class RouterEvent extends Equatable {
  const RouterEvent();
}

class StoryOpenedEvent extends RouterEvent {
  const StoryOpenedEvent();

  @override
  List<Object?> get props => [];
}

class StoryDismissed extends RouterEvent {
  const StoryDismissed();

  @override
  List<Object?> get props => [];
}
