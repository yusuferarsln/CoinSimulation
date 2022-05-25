import 'package:coin_sim/ui/home/view/home_page.dart';
import 'package:coin_sim/ui/leaderboard/view/leaderboard_view.dart';
import 'package:coin_sim/ui/profile/profile_page.dart';
import 'package:coin_sim/ui/statistics/view/statistic_page.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentIndex = 0;
  final screens = [HomePage(), ProfilePage(), LeaderBoardPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        currentIndex: currentIndex,
        showUnselectedLabels: false,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              label: 'Profile',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: 'LeaderBoard',
              backgroundColor: Colors.red),
        ],
      ),
    );
  }
}
