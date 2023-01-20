part of 'storyplayer_page_bloc.dart';

abstract class StoryPlayerPageState extends Equatable {
  const StoryPlayerPageState();
}

class StoryPlayerPageInitial extends StoryPlayerPageState {
  @override
  List<Object> get props => [];
}

class StoryPlayerPagePlayingState extends StoryPlayerPageState {
  final StoryPackageEntity storyPackageEntity;

  const StoryPlayerPagePlayingState({required this.storyPackageEntity});

  @override
  List<Object?> get props => [storyPackageEntity];
}

class StoryPlayerPageRefreshState extends StoryPlayerPageState {
  const StoryPlayerPageRefreshState();

  @override
  List<Object?> get props => [];
}

class StoryPlayerPageNotPlayingState extends StoryPlayerPageState {
  const StoryPlayerPageNotPlayingState();

  @override
  List<Object?> get props => [];
}

class StoryPlayerFailureState extends StoryPlayerPageState {
  const StoryPlayerFailureState();

  @override
  List<Object?> get props => [];
}
