import 'package:codestories/blocs/story_bloc.dart';
import 'package:codestories/pages/dummypages.dart';
import 'package:codestories/pages/feedpage.dart';
import 'package:codestories/tabbar.dart';
import 'package:codestories/utils/cubicstoryplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryBloc, StoryState>(builder: (context, state) {
      if (state is StoryInitialState) {
        return const TabbarPage(
          title: 'Codegram',
          children: [
            FeedPage(
              loaded: false,
            ),
            ReelsPage(),
            SearchPage(),
            ShopPage(),
            AccountPage(),
          ],
        );
      }
      if (state is StoriesLoadedState) {
        return const TabbarPage(
          title: 'Codegram',
          children: [
            FeedPage(
              loaded: true,
            ),
            ReelsPage(),
            SearchPage(),
            ShopPage(),
            AccountPage(),
          ],
        );
      } else if (state is StoryWatchingState) {
        return CubicPageSwiper(
            currentUser: state.user,
            storyMap: state.storyMap,
            currentIndexMap: state.indexMap,
            userList: state.userList);
      } else if (state is StoryLoadingState) {
        return const CircularProgressIndicator();
      }
      return Container();
    });
  }
}
