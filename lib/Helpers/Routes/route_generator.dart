import 'package:celia_movies/Helpers/Routes/route_arguments.dart';
import 'package:celia_movies/Presentations/Screens/HomePages/home_page.dart';
import 'package:celia_movies/Presentations/Screens/Person_Screens/image_view_page.dart';
import 'package:celia_movies/Presentations/Screens/Person_Screens/person_details_home_page.dart';
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
      case RouteNames.personDetailsHomePageRoute:
        return MaterialPageRoute(
            builder: (_) =>
                PersonDetailsHomePage(routeArguments: args as RouteArguments));
      case RouteNames.imageViewPageRoute:
        return MaterialPageRoute(
            builder: (_) =>
                ImageViewPage(routeArguments: args as RouteArguments));

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                body: SafeArea(child: Text('presentation.Route Error'))));
    }
  }
}
