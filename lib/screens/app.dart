import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wacomi/providers/auth.dart';
import 'package:wacomi/providers/post_list.dart';
import 'package:wacomi/screens/event_list_screen.dart';
import 'package:wacomi/screens/group_list_screen.dart';
import 'package:wacomi/screens/home_screen.dart';
import 'package:wacomi/screens/post_list_screen.dart';
import 'package:wacomi/widgets/app_drawer.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // List<Map<String, Object>> _pages;
  PageController _pageController;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Provider.of<Auth>(context, listen: false).tryAutoLogin();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _onTapBottomNavigation(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProxyProvider<Auth, PostList>(
        //   update: (ctx, auth, _) => PostList(auth.token,
        //       auth.currentUser != null ? auth.currentUser.id : null),
        // ),
      ],
      child: Scaffold(
        drawer: AppDrawer(),
        body: PageView(
          controller: _pageController,
          onPageChanged: _selectPage,
          children: <Widget>[
            HomeScreen(),
            PostListScreen(),
            GroupListScreen(),
            EventListScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onTapBottomNavigation,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.home),
              title: const Text(
                'ホーム',
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.comment),
              title: Text(
                '投稿',
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.group),
              title: const Text(
                'グループ',
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.event),
              title: const Text(
                'イベント',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
