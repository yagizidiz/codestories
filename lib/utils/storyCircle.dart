import 'package:codestories/blocs/story_bloc.dart';
import 'package:flutter/material.dart';
import 'package:codestories/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoryCircle extends StatelessWidget {
  final User user;

  const StoryCircle({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storyBloc = BlocProvider.of<StoryBloc>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              storyBloc.add(StoryOpenedEvent(user: user));
            },
            child: Container(
              width: 68,
              height: 68,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff9b2282), Color(0xffeea863)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(user.profilePictureUrl),
                          fit: BoxFit.cover)),
                  width: 60,
                  height: 60,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          width: 40,
          child: Text(
            user.userName,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
