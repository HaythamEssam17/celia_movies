import 'package:celia_movies/Presentations/Screens/HomePages/home_page.dart';
import 'package:celia_movies/Presentations/Screens/Slpash_Screens/splash_screen_home_page.dart';
import 'package:flutter/material.dart';

import 'route_names.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RouteNames.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreenHomePage());
      case RouteNames.homePageRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                body: SafeArea(child: Text('presentation.Route Error'))));
    }
  }
}
