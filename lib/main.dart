import 'package:codestories/features/codestories/presentation/bloc/feedpagebloc/feed_page_bloc.dart';
import 'package:codestories/features/codestories/presentation/bloc/routerbloc/router_bloc.dart';
import 'package:codestories/features/codestories/presentation/bloc/storyplayerpagebloc/storyplayer_page_bloc.dart';
import 'package:codestories/features/codestories/presentation/page/router_page.dart';
import 'package:codestories/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  setupLocator();
  await Hive.initFlutter();
  await Hive.openBox('index');
  await Hive.box('index').clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'CodeStories',
      home: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) => FeedPageBloc()
              ..add(const FeedPageFetchAndPreloadStoriesEvent())),
        BlocProvider(create: (context) => RouterBloc()),
        BlocProvider(create: (context) => locator<StoryPlayerPageBloc>())
      ], child: const RouterPage()),
    );
  }
}
