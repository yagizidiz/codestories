import 'package:codestories/features/codestories/data/datasource/fake_remote_data_source.dart';
import 'package:codestories/features/codestories/data/datasource/local_datasource.dart';
import 'package:codestories/features/codestories/data/repositoryimpl/story_repository_impl.dart';
import 'package:codestories/features/codestories/domain/entity/story_holder_entity.dart';
import 'package:codestories/features/codestories/presentation/bloc/storyplayerpagebloc/storyplayer_page_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => StoryRepositoryImpl());
  locator.registerLazySingleton(() => FakeRemoteDataSourceImpl());
  locator.registerLazySingleton(() => LocalDataSourceImpl());
  locator.registerSingleton(StoryHolderEntity());
  locator.registerSingleton(StoryPlayerPageBloc());
}
