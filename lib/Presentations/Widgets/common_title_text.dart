import 'package:flutter/material.dart';

import '../../Constants/app_constants.dart';

class CommonTitleText extends StatelessWidget {
  final String textKey;
  final Color? textColor;
  final FontWeight textWeight;
  final double textFontSize;
  final TextAlign textAlignment;
  final int lines;
  final TextOverflow textOverflow;

  const CommonTitleText({
    Key? key,
    required this.textKey,
    this.textColor,
    this.textWeight = FontWeight.normal,
    this.textFontSize = AppConstants.normalFontSize,
    this.textAlignment = TextAlign.center,
    this.lines = 1,
    this.textOverflow = TextOverflow.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textKey,
      key: key,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.headline4?.copyWith(
            color: textColor ?? AppConstants.mainColor,
            fontSize: textFontSize,
            fontWeight: textWeight,
            overflow: textOverflow,
          ),
      textAlign: textAlignment,
      maxLines: lines,
    );
  }
}
