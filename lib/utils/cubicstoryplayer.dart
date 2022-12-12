import 'dart:ui';
import 'dart:math' as math;
import 'package:codestories/blocs/story_bloc.dart';
import 'package:codestories/models/story_model.dart';
import 'package:codestories/models/user_model.dart';
import 'package:codestories/utils/storyPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Cubic Page Swiper is actually a page view with necessary features added to make it a cubic story viewer.

//The cubic page Swiper and StoryPlayer is made by stateful widgets instead of a global business logic library like bloc, because it is considered as the most feasible solution
//of using animations together with bloc etc, only videcontrollers of video stories are initialized before to prevent users to wait to watch but animation controllers etc handled inside
//the stateful widgets.
class CubicPageSwiper extends StatefulWidget {
  //userlist of all users
  final List<User> userList;

  //index map saved to the local database using hive
  final Map<String, int> currentIndexMap;

  //current user which the user of app clicked on the story of that
  final User currentUser;

  //List of stories as a map matching with users
  final Map<String, List<Story>> storyMap;

  const CubicPageSwiper({
    Key? key,
    required this.currentUser,
    required this.storyMap,
    required this.currentIndexMap,
    required this.userList,
  }) : super(key: key);

  @override
  State<CubicPageSwiper> createState() => _CubicPageSwiperState();
}

class _CubicPageSwiperState extends State<CubicPageSwiper> {
  //pageview controller
  PageController? _pageController;

  //current page on pageview
  int? _currentPage;

  //page angles for all pages
  double _pageDelta = 0;

  //current page to be shown to the user of the application, even before content dimensions are set
  double _page = 0.00;

  //map of the index to be updated inside the storyview
  Map<String, int>? _indexMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          //page view builder builds page view with some configurations and eventually pages are transforms, which are transformed by an angle valuable being multiplied with 90 degrees of angle
          //so the previous and, next stories are rotated according to controller's page value.
          child: PageView.builder(
              clipBehavior: Clip.hardEdge,
              scrollBehavior: ScrollConfiguration.of(context).copyWith(
                  scrollbars: false,
                  overscroll: false,
                  dragDevices: {
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.touch
                  }),
              scrollDirection: Axis.horizontal,
              reverse: false,
              controller: _pageController,
              pageSnapping: true,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.userList.length,
              //there are three different returns of itembuilder, if the page is the one which is viewed by the user at the moment, or else if the page is one of the next pages of it or
              // one of the previous pages of it so there are one storyplayer which is playing at the moment and two transforms which are just holds with initialized videocontrollers
              // but doesnt play, transform configurations are made depending on the positions of the pages and updated with the page controllers value
              itemBuilder: (context, index) {
                if (_pageController!.position.hasContentDimensions &&
                    _pageController!.position.hasPixels) {
                  _page = _pageController!.page!;
                } else {
                  _page =
                      widget.userList.indexOf(widget.currentUser).toDouble();
                }
                if (_page == index.toDouble()) {
                  return StoryPlayer(
                      closeCall: closeStories,
                      pageIndex: index,
                      nextCall: nextStory,
                      prevCall: prevStory,
                      isPlaying: true,
                      user: widget.userList.elementAt(index),
                      story: widget
                          .storyMap[widget.userList.elementAt(index).userName]!
                          .elementAt(widget.currentIndexMap[
                              widget.userList.elementAt(index).userName]!),
                      storyCount: widget
                          .storyMap[widget.userList.elementAt(index).userName]!
                          .length,
                      storyIndex: _indexMap![
                          widget.userList.elementAt(index).userName]!);
                } else if (_page > index.toDouble()) {
                  return Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.0015)
                      ..rotateY(math.pi / 2 * (_pageDelta)),
                    child: StoryPlayer(
                        closeCall: closeStories,
                        pageIndex: index,
                        nextCall: nextStory,
                        prevCall: prevStory,
                        isPlaying: false,
                        user: widget.userList.elementAt(index),
                        story: widget.storyMap[
                                widget.userList.elementAt(index).userName]!
                            .elementAt(widget.currentIndexMap[
                                widget.userList.elementAt(index).userName]!),
                        storyCount: widget
                            .storyMap[
                                widget.userList.elementAt(index).userName]!
                            .length,
                        storyIndex: _indexMap![
                            widget.userList.elementAt(index).userName]!),
                  );
                } else if (_page < index.toDouble()) {
                  return Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.0015)
                      ..rotateY(-math.pi / 2 * (1 - _pageDelta)),
                    child: StoryPlayer(
                        closeCall: closeStories,
                        pageIndex: index,
                        nextCall: nextStory,
                        prevCall: prevStory,
                        isPlaying: false,
                        user: widget.userList.elementAt(index),
                        story: widget.storyMap[
                                widget.userList.elementAt(index).userName]!
                            .elementAt(widget.currentIndexMap[
                                widget.userList.elementAt(index).userName]!),
                        storyCount: widget
                            .storyMap[
                                widget.userList.elementAt(index).userName]!
                            .length,
                        storyIndex: _indexMap![
                            widget.userList.elementAt(index).userName]!),
                  );
                } else {
                  return Container();
                }
              }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _indexMap = widget.currentIndexMap;
    _initPageController();
  }

//page controller initialization method to use in initstate above, it initializes the page controller with given widget values than sets the state
  void _initPageController() {
    _pageController?.dispose();
    _pageController = PageController(
        viewportFraction: 1,
        keepPage: true,
        initialPage:
            widget.storyMap.keys.toList().indexOf(widget.currentUser.userName));
    _pageController!.addListener(() {
      setState(() {
        _currentPage = _pageController!.page!.floor();
        _pageDelta = _pageController!.page! - _currentPage!;
        debugPrint(_pageController!.page!.toString());
      });
    });
  }

//next story method which changes the story to a new story or a new story group depending on the index
  void nextStory(int index) {
    debugPrint("Sağa Bastı");
    debugPrint(index.toString());

    if (_indexMap![widget.userList.elementAt(index).userName]! !=
        widget.storyMap[widget.userList.elementAt(index).userName]!.length -
            1) {
      _indexMap!.update(
          widget.userList.elementAt(index).userName,
          (value) =>
              _indexMap![widget.userList.elementAt(index).userName]! + 1);
      setState(() {});
    } else if (index < widget.storyMap.length - 1) {
      _pageController!.animateToPage(index + 1,
          duration: const Duration(milliseconds: 750),
          curve: Curves.easeOutQuad);
    }
    setState(() {});
  }

//previous story method which changes the story to a new story or a new story group depending on the index
  void prevStory(int index) {
    debugPrint("Sola Bastı");
    if (_indexMap![widget.userList.elementAt(index).userName]! != 0) {
      _indexMap!.update(
          widget.userList.elementAt(index).userName,
          (value) =>
              _indexMap![widget.userList.elementAt(index).userName]! - 1);
      setState(() {});
    } else if (index > 0) {
      _pageController!.animateToPage(index - 1,
          duration: const Duration(milliseconds: 750),
          curve: Curves.easeOutQuad);
    }
    setState(() {});
  }

//the method to close stories by saving the indexes of where user left watching the story packages at
  void closeStories() {
    final storyBloc = BlocProvider.of<StoryBloc>(context);
    storyBloc.add(StoryClosedEvent(indexMap: _indexMap!));
  }
}
