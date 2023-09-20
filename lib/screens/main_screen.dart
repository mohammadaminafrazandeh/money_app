
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:money_app/screens/home_screen.dart';
import 'package:money_app/screens/info_scren.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndext = 0;
  Widget body = const HomeScreen();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          inactiveColor: Colors.black54,
          icons: const [Icons.home, Icons.info],
          activeIndex: currentIndext,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.smoothEdge,
          onTap: (index) {
            if (index == 0) {
              body = const HomeScreen();
            } else {
              body = const InfoScreen();
            }
    
            setState(() {
              currentIndext = index;
            });
          },
        ),
        body: body,
      ),
    );
  }
}
