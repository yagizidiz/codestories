import 'dart:ui';
import 'dart:math' as math;
import 'package:codestories/core/constant/enum.dart';
import 'package:codestories/core/extension/context_extension.dart';
import 'package:codestories/features/codestories/domain/entity/story_package_entity.dart';
import 'package:codestories/features/codestories/presentation/widget/storyplayer/storyplayer_chooser.dart';
import 'package:flutter/material.dart';

class StoryPlayerPage extends StatefulWidget {
  final StoryPackageEntity storyPackageEntity;

  const StoryPlayerPage({Key? key, required this.storyPackageEntity})
      : super(key: key);

  @override
  State<StoryPlayerPage> createState() => _StoryPlayerPageState();
}

class _StoryPlayerPageState extends State<StoryPlayerPage> {
  PageController? _pageController;
  int? _currentPage;
  double _pageDelta = 0;
  double _page = 0.0;

  void _initPageController() {
    _pageController?.dispose();
    _pageController = PageController(
        viewportFraction: 1,
        keepPage: true,
        initialPage: widget.storyPackageEntity.userList
            .indexOf(widget.storyPackageEntity.currentUser));
    _pageController!.addListener(() {
      setState(() {
        _currentPage = _pageController!.page!.floor();
        _pageDelta = _pageController!.page! - _currentPage!;
      });
    });
  }

  void nextPage() {
    debugPrint(
        "seaeasdfasfdsadfaskdjfbnlajksfnaşlsfnlkajdsnfakdsnfalsjfdnalksdnf*******************************");
    if (_pageController!.page!.floor().toInt() <
        widget.storyPackageEntity.userList.length - 1) {
      _pageController!.animateToPage(_pageController!.page!.floor().toInt() + 1,
          duration: const Duration(milliseconds: 750),
          curve: Curves.easeOutQuad);
    }
  }

  void previousPage() {
    if (_pageController!.page!.floor().toInt() > 0) {
      _pageController!.animateToPage(_pageController!.page!.floor().toInt() - 1,
          duration: const Duration(milliseconds: 750),
          curve: Curves.easeOutQuad);
    }
  }

  @override
  void initState() {
    _initPageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
              height: context.dynamicHeight(1),
              width: context.dynamicWidth(1),
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
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.storyPackageEntity.userList.length,
                  itemBuilder: (context, index) {
                    if (_pageController!.position.hasContentDimensions &&
                        _pageController!.position.hasPixels) {
                      _page = _pageController!.page!;
                    } else {
                      _page = 1.00;
                      return StoryPlayerChooser(
                        storyEntity: widget.storyPackageEntity.storyMap[widget
                            .storyPackageEntity.userList
                            .elementAt(index)]!,
                        playerState: PlayerState.play,
                        nextCall: nextPage,
                        prevCall: previousPage,
                      );
                    }
                    if (_page == index.toDouble()) {
                      return StoryPlayerChooser(
                        storyEntity: widget.storyPackageEntity.storyMap[widget
                            .storyPackageEntity.userList
                            .elementAt(index)]!,
                        playerState: PlayerState.play,
                        nextCall: nextPage,
                        prevCall: previousPage,
                      );
                    } else if (_page > index.toDouble()) {
                      if (_page < index.toDouble() + 1.0) {
                        return Transform(
                          alignment: Alignment.centerRight,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.0015)
                            ..rotateY(math.pi / 2 * (_pageDelta)),
                          child: StoryPlayerChooser(
                            storyEntity: widget.storyPackageEntity.storyMap[
                                widget.storyPackageEntity.userList
                                    .elementAt(index)]!,
                            playerState: PlayerState.stop,
                            nextCall: nextPage,
                            prevCall: previousPage,
                          ),
                        );
                      } else {
                        return Transform(
                          alignment: Alignment.centerRight,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.0015)
                            ..rotateY(math.pi / 2 * (_pageDelta)),
                          child: StoryPlayerChooser(
                            storyEntity: widget.storyPackageEntity.storyMap[
                                widget.storyPackageEntity.userList
                                    .elementAt(index)]!,
                            playerState: PlayerState.reset,
                            nextCall: nextPage,
                            prevCall: previousPage,
                          ),
                        );
                      }
                    } else if (_page < index.toDouble()) {
                      if (_page > index.toDouble() - 1.0) {
                        return Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.0015)
                            ..rotateY(-math.pi / 2 * (1 - _pageDelta)),
                          child: StoryPlayerChooser(
                            storyEntity: widget.storyPackageEntity.storyMap[
                                widget.storyPackageEntity.userList
                                    .elementAt(index)]!,
                            playerState: PlayerState.stop,
                            nextCall: nextPage,
                            prevCall: previousPage,
                          ),
                        );
                      } else {
                        return Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.0015)
                            ..rotateY(-math.pi / 2 * (1 - _pageDelta)),
                          child: StoryPlayerChooser(
                            storyEntity: widget.storyPackageEntity.storyMap[
                                widget.storyPackageEntity.userList
                                    .elementAt(index)]!,
                            playerState: PlayerState.reset,
                            nextCall: nextPage,
                            prevCall: previousPage,
                          ),
                        );
                      }
                    } else {
                      return Container();
                    }
                  }))),
    );
  }
}
