import 'package:celia_movies/Data/Remote/Dio_Helpers/dio_helper.dart';
import 'package:celia_movies/Presentations/Screens/HomePages/home_material_app.dart';
import 'package:celia_movies/Services/bloc_observer.dart';
import 'package:celia_movies/Services/multi_bloc_provider_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  GestureBinding.instance?.resamplingEnabled = true;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
  // await DefaultSecuredStorage.getInstance();

  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    DioHelper.init();
  }

  @override
  Widget build(BuildContext context) {
    return const MultiBlocProvidersPage(
      body: HomeMaterialApp(),
    );
  }
}
