import 'package:flutter/material.dart';
import 'package:stock_watchlist/ui/screens/home_screen.dart';
import 'package:stock_watchlist/ui/screens/watchlist_screen.dart';
import 'package:stock_watchlist/ui/widgets/bottom_navbar.dart';

class AppRouter {

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case '/' : return MaterialPageRoute(builder: (context) => const BottomNavBar());
      case '/home' : return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/watchlist' : return MaterialPageRoute(builder: ((context) => const WatchListScreeen()));
      default: return MaterialPageRoute(builder: (context) => const BottomNavBar());
    }
  }
}