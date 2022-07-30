import 'dart:async';

import 'package:celia_movies/Data/Remote/Dio_Helpers/custom_exception.dart';
import 'package:celia_movies/Data/Remote/Dio_Helpers/dio_helper.dart';
import 'package:celia_movies/Helpers/app_logs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'connectivity_states.dart';

/// connectivity Controller
class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(AppInitialInternetState());

  static ConnectivityCubit get(context) => BlocProvider.of(context);

  String connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  String get getConnectionStatus => connectionStatus;

  /// cancel the listen to the internet
  void cancelSubscription() {
    connectivitySubscription.cancel();
    emit(CancelSubscriptionInternet());
  }

  /// start the listen to the internet status
  void initConnection() {
    initConnectivity();
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    emit(InternetLoading());
  }

  /// check the internet status have a wifi connection or data connection
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
      emit(GetInternetConnected());
    } on PlatformException catch (e) {
      debugPrint('error with result : ${e.toString()}');
      emit(ErrorInternet(e.toString()));
    }
    return _updateConnectionStatus(result);
  }

  /// determent the internet status (wifi - mobile data - no connection)
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    emit(InternetLoading());
    debugPrint('Connection status is : ${result.toString()}');
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        connectionStatus = result.toString();
        logPrint('connectionStatus: $connectionStatus');

        if (connectionStatus == ConnectivityResult.none.toString()) {
          emit(NoWifiOrDataInternetConnected());
        } else {
          checkConnection();
        }
        break;
      default:
        connectionStatus = 'Failed to get connectivity.';
        emit(InternetDisconnected());
        break;
    }
  }

  /// check the connection between the wifi and internet
  Future<void> checkConnection() async {
    try {
      Response response = await DioHelper.dio.get('https://www.google.com');
      if (response.statusCode == 200) {
        emit(InternetConnected());
      } else {
        emit(InternetDisconnected());
      }
      // ignore: nullable_type_in_catch_clause
    } on CustomException catch (e) {
      connectionStatus = 'Failed to get connectivity.';

      emit(InternetDisconnected());
      debugPrint('catch DioError google ${e.toString()}');
    } catch (e) {
      connectionStatus = 'Failed to get connectivity.';

      emit(InternetDisconnected());
      debugPrint('catch DioError google ${e.toString()}');
    }
  }
}
