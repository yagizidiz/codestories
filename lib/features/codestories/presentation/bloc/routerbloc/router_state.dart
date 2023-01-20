part of 'router_bloc.dart';

abstract class RouterState extends Equatable {
  const RouterState();
}

class RouterInitial extends RouterState {
  @override
  List<Object> get props => [];
}

class NavigateToStoryScreenState extends RouterState {
  const NavigateToStoryScreenState();

  @override
  List<Object?> get props => [];
}

class NavigateToNavigationBarScreen extends RouterState {
  const NavigateToNavigationBarScreen();

  @override
  List<Object?> get props => [];
//TODO: Implement failure state
}
