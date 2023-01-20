import 'package:codestories/features/codestories/presentation/bloc/routerbloc/router_bloc.dart';
import 'package:codestories/features/codestories/presentation/bloc/storyplayerpagebloc/storyplayer_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:codestories/features/codestories/domain/entity/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO: Blocprovider must be implemented to fetch the story view page
class LoadedStoryCircle extends StatelessWidget {
  final UserEntity userEntity;

  const LoadedStoryCircle({Key? key, required this.userEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routerBloc = BlocProvider.of<RouterBloc>(context);
    final storyPlayerPageBloc = BlocProvider.of<StoryPlayerPageBloc>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              routerBloc.add(const StoryOpenedEvent());
              storyPlayerPageBloc
                  .add(StoryOpenedByUserEvent(userEntity: userEntity));
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
                          image: NetworkImage(userEntity.profilePictureUrl),
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
            userEntity.userId,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
