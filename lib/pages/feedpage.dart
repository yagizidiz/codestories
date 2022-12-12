import 'package:codestories/data/dummy_lists.dart';
import 'package:codestories/utils/dummyPost.dart';
import 'package:codestories/utils/storiesLoadingCircle.dart';
import 'package:codestories/utils/storyCircle.dart';
import 'package:flutter/material.dart';
// Our only functional page in Tab Bar is the feedpage, it displays dummy posts and two different type of the stories depended on the bool "loaded"
class FeedPage extends StatelessWidget {
  final bool loaded;

  const FeedPage({Key? key, required this.loaded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 110,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: userProfileList.length,
                itemBuilder: (context, index) {
                  if (loaded) {
                    return StoryCircle(user: userProfileList.elementAt(index));
                  } else {
                    return LoadingCircle(
                        user: userProfileList.elementAt(index));
                  }
                }),
          ),
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: const [
                      UserPosts(),
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
