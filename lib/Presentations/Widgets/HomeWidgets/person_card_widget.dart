import 'package:celia_movies/Constants/Keys/movie_db_keys.dart';
import 'package:celia_movies/Constants/app_constants.dart';
import 'package:celia_movies/Helpers/Routes/route_arguments.dart';
import 'package:celia_movies/Helpers/Routes/route_names.dart';
import 'package:celia_movies/Helpers/shared_texts.dart';
import 'package:celia_movies/Presentations/Widgets/common_cached_image_widget.dart';
import 'package:celia_movies/Presentations/Widgets/common_title_text.dart';
import 'package:flutter/material.dart';

import '../../../Data/Models/person_model.dart';

class PersonCardWidget extends StatelessWidget {
  final PersonModel personModel;

  const PersonCardWidget({Key? key, required this.personModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.personDetailsHomePageRoute,
            arguments: RouteArguments(personID: personModel.id!));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppConstants.secondMainColor,
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: commonCachedImageWidget(
                  context, MovieDBKeys.imagePathUrl + personModel.profilePath!,
                  fit: BoxFit.fill, width: SharedText.screenWidth),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CommonTitleText(
                  textKey: personModel.name!,
                  textColor: AppConstants.whiteColor,
                  textWeight: FontWeight.w500,
                  textFontSize: AppConstants.mediumFontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
