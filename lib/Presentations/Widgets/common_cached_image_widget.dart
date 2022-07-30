import 'package:cached_network_image/cached_network_image.dart';
import 'package:celia_movies/Constants/shared_functions.dart';
import 'package:celia_movies/Presentations/Widgets/common_asset_image_widget.dart';
import 'package:flutter/material.dart';

import '../../Constants/app_constants.dart';

Widget commonCachedImageWidget(
  BuildContext context,
  String imageUrl, {
  double radius = 10.0,
  BoxFit fit = BoxFit.contain,
  double? height,
  double? width,
  bool? isProfileImage = false,
}) {
  double imageHeight = getWidgetHeight(height!);
  double imageWidth = getWidgetWidth(width!);

  return CachedNetworkImage(
    imageUrl: imageUrl,
    imageBuilder: (context, imageProvider) => Container(
      height: imageHeight,
      width: imageWidth,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        image: DecorationImage(
          image: imageProvider,
          fit: fit,
        ),
      ),
    ),
    placeholder: (context, img) => Container(
      height: imageHeight,
      width: imageWidth,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        image: DecorationImage(
          image: const AssetImage("assets/images/loading.gif"),
          fit: fit,
        ),
      ),
    ),
    errorWidget: (context, url, error) => commonAssetImageWidget(
      imageString: 'logo.png',
      fit: BoxFit.contain,
      radius: radius,
      height: height,
      imageColor: AppConstants.mainColor,
      width: width,
    ),
  );
}
