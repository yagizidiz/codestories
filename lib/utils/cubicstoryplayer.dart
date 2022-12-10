import 'dart:ui';
import 'dart:math' as math;
import 'package:codestories/blocs/story_bloc.dart';
import 'package:codestories/models/story_model.dart';
import 'package:codestories/models/user_model.dart';
import 'package:codestories/utils/storyPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubicPageSwiper extends StatefulWidget {
  final List<User> userList;
  final Map<String, int> currentIndexMap;
  final User currentUser;
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
  PageController? _pageController;
  int? _currentPage;
  double _pageDelta = 0;
  double _page = 0.00;
  Map<String, int>? _indexMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
              onPageChanged: (ind) {
                debugPrint(ind.toString());
              },
              physics: const BouncingScrollPhysics(),
              itemCount: widget.userList.length,
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
                        story: widget.storyMap[
                                widget.userList.elementAt(index).userName]!
                            .elementAt(widget.currentIndexMap[
                                widget.userList.elementAt(index).userName]!),
                        storyCount: widget
                            .storyMap[
                                widget.userList.elementAt(index).userName]!
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

        //debugPrint(_currentPage.toString());
        //debugPrint(_pageDelta.toString());
      });
    });
  }

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
          duration: const Duration(milliseconds: 750), curve: Curves.easeOutQuad);
    }
    setState(() {

    });
  }

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
          duration: const Duration(milliseconds: 750), curve: Curves.easeOutQuad);
    }
    setState(() {});
  }
  void closeStories(){
    final storyBloc = BlocProvider.of<StoryBloc>(context);
    storyBloc.add(StoryClosedEvent(indexMap: _indexMap!));
  }
}
