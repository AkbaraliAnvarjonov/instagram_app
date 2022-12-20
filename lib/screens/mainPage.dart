import 'package:flutter/material.dart';
import 'package:instagram_app/screens/reelsPage.dart';
import 'package:instagram_app/screens/notificationPage.dart';
import 'package:instagram_app/screens/postsPage.dart';
import 'package:instagram_app/screens/profilePage.dart';
import 'package:instagram_app/screens/searchPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pages = [
  const  PostsPage(),
  const  SearchPage(),
  const  ReelsPage(),
  const  NotificationPage(),
  const  ProfilePage()
  ];
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentPageIndex,
          onTap: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.movie_creation_rounded), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "")
          ]),
    );
  }
}
