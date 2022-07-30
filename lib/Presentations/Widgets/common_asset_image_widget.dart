import 'package:celia_movies/Constants/shared_functions.dart';
import 'package:flutter/material.dart';

Widget commonAssetImageWidget({
  required String imageString,
  required double height,
  required double width,
  Color? imageColor,
  double radius = 0.0,
  BoxFit? fit = BoxFit.contain,
  final Function()? onTapImage,
}) {
  return InkWell(
    onTap: onTapImage,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        'assets/images/$imageString',
        fit: fit,
        color: imageColor,
        height: getWidgetHeight(height),
        width: getWidgetWidth(width),
      ),
    ),
  );
}
