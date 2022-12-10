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

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final StoryRepo storyRepo = locator<StoryRepo>();

  StoryBloc() : super(const StoryInitialState()) {
    on<StoryIndexPreloadEvent>((event, emit) async {
      Map<String, List<Story>> stories = await storyRepo.getStoryMap();
      stories.forEach((key, value) {
        Hive.box('indexes').put(key, 0);
      });
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
    on<StoryOpenedEvent>((event, emit) async {
      Map<String, int> indexMap = await storyRepo.getIndexMap();
      Map<String, List<Story>> storyMap = await storyRepo.getStoryMap();
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
