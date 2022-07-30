import 'package:celia_movies/Constants/Keys/movie_db_keys.dart';
import 'package:celia_movies/Data/Interfaces/perple_interface.dart';
import 'package:celia_movies/Data/Models/base_model.dart';
import 'package:celia_movies/Data/Models/person_details_model.dart';
import 'package:celia_movies/Data/Remote/Dio_Helpers/custom_error.dart';
import 'package:celia_movies/Data/Remote/Dio_Helpers/custom_exception.dart';
import 'package:celia_movies/Data/Remote/Dio_Helpers/dio_helper.dart';
import 'package:celia_movies/Helpers/app_logs.dart';
import 'package:dio/dio.dart';

class PopularPeopleRepository extends IPeopleInterface {
  @override
  Future<BaseModel> fetchAllPopularPeople({int? page}) async {
    isError = false;

    try {
      logPrint('repo page: $page');
      String url =
          '/person/popular?api_key=${MovieDBKeys.theMovieDbApiKey}&language=en-US&page=$page';

      Response response = await DioHelper.getDate(
        url: url,
      );
      if (response.statusCode == 200) {
        /// parsing response to user model
        baseModel = BaseModel.fromJson(response.data);
        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg = CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath);
      return baseModel;
    }
  }

  @override
  Future<PersonDetailsModel> fetchPersonByID({required int personID}) async {
    isError = false;
    PersonDetailsModel model = PersonDetailsModel();

    try {
      String url =
          '/person/$personID?api_key=${MovieDBKeys.theMovieDbApiKey}&language=en-US';

      Response response = await DioHelper.getDate(
        url: url,
      );
      if (response.statusCode == 200) {
        /// parsing response to user model
        model = PersonDetailsModel.fromJson(response.data);
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
