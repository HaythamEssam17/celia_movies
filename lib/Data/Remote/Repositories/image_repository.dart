import 'package:celia_movies/Constants/Keys/movie_db_keys.dart';
import 'package:celia_movies/Data/Interfaces/image_interface.dart';
import 'package:celia_movies/Data/Models/image_model.dart';
import 'package:celia_movies/Data/Remote/Dio_Helpers/custom_error.dart';
import 'package:celia_movies/Data/Remote/Dio_Helpers/custom_exception.dart';
import 'package:celia_movies/Data/Remote/Dio_Helpers/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ImageRepository extends IImageInterface {
  @override
  Future<ImageModel> fetchAllImages({required int personID}) async {
    isError = false;
    ImageModel model = ImageModel();

    try {
      debugPrint('personID: $personID');
      String url =
          '/person/$personID/images?api_key=${MovieDBKeys.theMovieDbApiKey}';

      Response response = await DioHelper.getDate(
        url: url,
      );
      if (response.statusCode == 200) {
        /// parsing response to user model
        model = ImageModel.fromJson(response.data);
        return model;
      } else {
        return model;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg = CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath);
      return model;
    }
  }
}
