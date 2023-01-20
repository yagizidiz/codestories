import 'package:codestories/features/codestories/presentation/bloc/routerbloc/router_bloc.dart';
import 'package:codestories/features/codestories/presentation/bloc/storyplayerpagebloc/storyplayer_page_bloc.dart';
import 'package:codestories/features/codestories/presentation/page/navigation_bar_page.dart';
import 'package:codestories/features/codestories/presentation/page/storyplayer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO: Implement router page with bloc listener
class RouterPage extends StatelessWidget {
  const RouterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RouterBloc routerBloc = BlocProvider.of<RouterBloc>(context);
    return BlocBuilder<RouterBloc, RouterState>(
        builder: (context, routerState) {
      if (routerState is RouterInitial) {
        return const NavigationBarPage();
      } else if (routerState is NavigateToNavigationBarScreen) {
        return const NavigationBarPage();
      } else if (routerState is NavigateToStoryScreenState) {
        return BlocBuilder<StoryPlayerPageBloc, StoryPlayerPageState>(
            builder: (context, state) {
          if (state is StoryPlayerPageRefreshState) {
            return Container();
          }
          if (state is StoryPlayerPagePlayingState) {
            return StoryPlayerPage(
                storyPackageEntity: state.storyPackageEntity);
          } else if (state is StoryPlayerPageNotPlayingState) {
            routerBloc.add(const StoryDismissed());
            return Container();
          } else {
            return Container();
          }
        });
      } else {
        return Container();
      }
    });
  }
}
