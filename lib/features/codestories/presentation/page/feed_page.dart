import 'package:codestories/features/codestories/presentation/bloc/feedpagebloc/feed_page_bloc.dart';
import 'package:codestories/features/codestories/presentation/widget/post/dummy_instagram_post.dart';
import 'package:codestories/features/codestories/presentation/widget/storycircle/empty_story_circle.dart';
import 'package:codestories/features/codestories/presentation/widget/storycircle/loaded_story_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 110,
            child: BlocBuilder<FeedPageBloc, FeedPageState>(
                builder: (context, state) {
              if (state is FeedPageInitial) {

                return Container();
              } else if (state is FeedPageStoriesNotLoadedState) {
                return ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.userList.length,
                    itemBuilder: (context, index) {
                      return EmptyStoryCircle(
                          userEntity: state.userList.elementAt(index));
                    });
              } else if (state is FeedPageStoriesLoadedState) {
                return ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.userList.length,
                    itemBuilder: (context, index) {
                      return LoadedStoryCircle(
                          userEntity: state.userList.elementAt(index));
                    });
              } else {
                return Container();
              }
            }),
          ),
          Expanded(
            child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: const [
                      DummyInstagramPost(),
                      SizedBox(
                        height: 70,
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
