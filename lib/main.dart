import 'package:codestories/blocs/story_bloc.dart';
import 'package:codestories/locator.dart';
import 'package:codestories/rootpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  setupLocator();
  await Hive.initFlutter();
  await Hive.openBox('indexes');
  await Hive.box('indexes').clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData.dark(),
      title: 'CodeStories',
      home: BlocProvider(
        create: (context) => StoryBloc()..add(const StoryIndexPreloadEvent()),
        child: const RootPage(),
      ),
    );
  }
}
