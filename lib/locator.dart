import 'package:codestories/data/story_repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
// we only have one repository to handle logic business so register it to locator to prevent multiple object instances creation.
void setupLocator() {
  locator.registerLazySingleton(() => StoryRepo());
}
