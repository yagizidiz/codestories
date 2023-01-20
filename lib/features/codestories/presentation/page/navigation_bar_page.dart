import 'package:codestories/features/codestories/presentation/page/dummypage/dummy_pages.dart';
import 'package:codestories/features/codestories/presentation/page/feed_page.dart';
import 'package:flutter/material.dart';

//TODO: Stateful Widget can be updated to bloc implementation
class NavigationBarPage extends StatefulWidget {
  final List<Widget> children = const [
    FeedPage(),
    ReelsPage(),
    SearchPage(),
    ShopPage(),
    AccountPage()
  ];

  const NavigationBarPage({Key? key}) : super(key: key);

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int _currentIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('CodeStories'),
      ),
      body: widget.children.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        fixedColor: const Color(0xffdf4f69),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _navigateBottomBar,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(icon: Icon(Icons.video_call), label: 'reels'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'shop'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'account')
        ],
      ),
    );
  }
}
