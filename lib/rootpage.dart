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
    //RootPage returns different values depending on the state of our bloc.
    return BlocBuilder<StoryBloc, StoryState>(builder: (context, state) {
      //If our stories are not being watched or loaded yet initial state displays a feed page with dummy posts and stories with no functionality.
      if (state is StoryInitialState) {
        return const TabbarPage(
          title: 'Codegram',
          children: [
            FeedPage(
              //loaded bool makes story Circles dummy here
              loaded: false,
            ),
            ReelsPage(),
            SearchPage(),
            ShopPage(),
            AccountPage(),
          ],
        );
      }
      //After we open the app an event to load and initialize stories in videcontrollers is triggered, when this event finishes it's work this state is emitted.
      //It let us display the new feed page with clickable story circles linked to loaded story player page view.
      if (state is StoriesLoadedState) {
        return const TabbarPage(
          title: 'Codegram',
          children: [
            FeedPage(
              //loaded boool makes story circles clickable and functional
              loaded: true,
            ),
            ReelsPage(),
            SearchPage(),
            ShopPage(),
            AccountPage(),
          ],
        );
        //When a story is clicked, this state is being emitted, It directly displays the cubic story page with loaded stories inside it.
        //story data is inside state object as attributes.
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
