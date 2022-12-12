import 'package:codestories/blocs/story_bloc.dart';
import 'package:codestories/locator.dart';
import 'package:codestories/rootpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  //Locator initialization, locator package is used to prevent multiple object instances. Instead of creating multiple objects for one purposed repository services etc. We can
  //mimic an approach like functional programming by registering our services to locator package and use them by locator sample.
  setupLocator();
  //Hive is new local database library of flutter which is new most popular one after sqflite, it helps us save data to local storage of the device without concerns of database design etc,
  //it automatically chooses the best way of storing and we are just concerned about our datatypes, in this project it is used for holding the story indexes.
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
      theme: ThemeData.dark(),
      title: 'CodeStories',
      //Bloc package and architecture is used in the project so we inject our bloc to the root of the app then we can use in where we need with this context.
      home: BlocProvider(
        //We triggger an event of StoryIndexPreloadEvent to load all the stories so we can prevent delay while we are loading the stories.
        create: (context) => StoryBloc()..add(const StoryIndexPreloadEvent()),
        child: const RootPage(),
      ),
    );
  }
}
