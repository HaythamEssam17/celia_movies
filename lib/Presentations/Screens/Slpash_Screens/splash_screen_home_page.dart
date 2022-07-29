import 'dart:async';

import 'package:celia_movies/Constants/app_constants.dart';
import 'package:celia_movies/Constants/shared_functions.dart';
import 'package:celia_movies/Helpers/Routes/route_names.dart';
import 'package:flutter/material.dart';

class SplashScreenHomePage extends StatefulWidget {
  const SplashScreenHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenHomePageState();
}

class _SplashScreenHomePageState extends State<SplashScreenHomePage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  Animation<double>? scaleAnimation;

  goToHomePage() {
    Timer(const Duration(milliseconds: 2500),
        () => Navigator.pushReplacementNamed(context, RouteNames.splashRoute));
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..addListener(() {
        setState(() {});
      });

    controller.forward();
    goToHomePage();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.whiteColor,
      body: Container(
        color: Colors.transparent,
        width: getWidgetWidth(238),
        height: getWidgetHeight(12),
        child: ClipRRect(
          borderRadius:
              BorderRadius.all(Radius.circular(AppConstants.cardBorderRadius)),
          child: LinearProgressIndicator(
            value: controller.value,
            semanticsLabel: 'Linear progress indicator',
            backgroundColor: AppConstants.lightWhiteColor,
            color: AppConstants.mainColor,
          ),
        ),
      ),
    );
  }
}
