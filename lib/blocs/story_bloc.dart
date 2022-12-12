import 'package:codestories/data/story_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:codestories/models/story_model.dart';
import 'package:codestories/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:codestories/locator.dart';
import 'package:hive/hive.dart';

part 'story_event.dart';

part 'story_state.dart';
//Bloc in this project handles the data business logic of loading of the stories and displaying them depending on the events.
class StoryBloc extends Bloc<StoryEvent, StoryState> {
  //Our storyRepo is declared by locator instance
  final StoryRepo storyRepo = locator<StoryRepo>();
//StoryInitialState is the initial state without any useful data
  StoryBloc() : super(const StoryInitialState()) {
    //The event we triggereed just after we inject the bloc, load all the stories and initialize their videocontrollers if the stories are in video format.
    on<StoryIndexPreloadEvent>((event, emit) async {
      Map<String, List<Story>> stories = await storyRepo.getStoryMap();
      stories.forEach((key, value) {
        Hive.box('indexes').put(key, 0);
      });
      //For each story in the stories map if the MediaType is video it initializes the videocontroller.
      await Future.forEach(stories.values, (element) async {
        await Future.forEach(element, (vals) async {
          if (vals.mediaType == MediaType.video) {
            vals.setController();
            await vals.initController();
          }
        });
      });
      debugPrint('storiesloaded');
      emit(const StoriesLoadedState());
    });
    //After our story circles became touchable and functional, click on those opens a story so emits an event for that purpose with needed story objects list etc. in it
    on<StoryOpenedEvent>((event, emit) async {
      //Map of the indexes of all users' stories to make user start from where it stopped.
      Map<String, int> indexMap = await storyRepo.getIndexMap();
      //Map of the stories themselves with story url's controllers etc..
      Map<String, List<Story>> storyMap = await storyRepo.getStoryMap();
      //User list to display stories in the same order and have the value of the user when needed.
      List<User> userList = await storyRepo.getUserList();
      emit(StoryWatchingState(
          user: event.user,
          storyMap: storyMap,
          indexMap: indexMap,
          userList: userList));
    });
    on<StoryClosedEvent>((event, emit) {
      storyRepo.putIndexMap(event.indexMap);
      emit(const StoriesLoadedState());
    });
  }
}
