import 'package:celia_movies/Constants/Keys/movie_db_keys.dart';
import 'package:celia_movies/Data/Interfaces/perple_interface.dart';
import 'package:celia_movies/Data/Models/base_model.dart';
import 'package:celia_movies/Data/Remote/Dio_Helpers/custom_error.dart';
import 'package:celia_movies/Data/Remote/Dio_Helpers/custom_exception.dart';
import 'package:celia_movies/Data/Remote/Dio_Helpers/dio_helper.dart';
import 'package:dio/dio.dart';

class PopularPeopleRepository extends IPeopleInterface {
  @override
  Future<BaseModel> fetchAllPopularPeople() async {
    isError = false;

    try {
      String url =
          '/person/popular?api_key=${MovieDBKeys.theMovieDbApi}&language=en-US&page=1';

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
}
