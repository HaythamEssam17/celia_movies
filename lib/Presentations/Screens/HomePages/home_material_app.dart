import 'package:celia_movies/Helpers/Responsive_UI/ui_components.dart';
import 'package:celia_movies/Helpers/Routes/route_generator.dart';
import 'package:celia_movies/Helpers/shared_texts.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/Connectivity_Cubit/connectivity_cubit.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/Connectivity_Cubit/connectivity_states.dart';
import 'package:celia_movies/Presentations/Screens/Slpash_Screens/splash_screen_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMaterialApp extends StatelessWidget {
  const HomeMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectivityCubit, ConnectivityState>(
      listener: (connectivityCxt, connectivityState) {},
      builder: (connectivityCxt, connectivityState) {
        return MaterialApp(
          onGenerateRoute: RouteGenerator.generateRoute,
          title: 'Celia Movies',
          debugShowCheckedModeBanner: false,

          /// widget that calculate width and height and type of current device
          home: InfoComponents(
            builder: (infoComponentsContext, deviceInfo) {
              SharedText.screenHeight = deviceInfo.screenHeight;
              SharedText.screenWidth = deviceInfo.screenWidth;
              SharedText.deviceInfo = deviceInfo;

              return const SplashScreenHomePage();
            },
          ),
        );
      },
    );
  }
}
