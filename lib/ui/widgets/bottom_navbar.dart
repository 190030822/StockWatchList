import 'package:flutter/material.dart';
import 'package:stock_watchlist/ui/screens/home_screen.dart';
import 'package:stock_watchlist/ui/screens/watchlist_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const WatchListScreeen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home"
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: "watchlist"
            ),
        ],
      ),
    );
  }
}