import 'package:celia_movies/Constants/Enums/enums.dart';
import 'package:flutter/material.dart';

class DeviceInfo {
  final Orientation orientation;
  final DeviceType deviceType;
  final double screenHeight;
  final double screenWidth;
  final double widgetHeight;
  final double widgetWidth;

  DeviceInfo(
      {required this.orientation,
      required this.deviceType,
      required this.screenHeight,
      required this.screenWidth,
      required this.widgetHeight,
      required this.widgetWidth});
}
