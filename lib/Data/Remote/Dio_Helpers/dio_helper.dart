import 'package:celia_movies/Constants/Enums/enums.dart';
import 'package:celia_movies/Data/Remote/Dio_Helpers/custom_exception.dart';
import 'package:celia_movies/Data/Remote/Dio_Helpers/dio_exception.dart';
import 'package:celia_movies/Helpers/app_logs.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  /// Initializing dio baseUrl
  static init() {
    try {
      dio = Dio(
        BaseOptions(
          baseUrl: 'https://realesta.emalleg.net/api',
          headers: {'Accept': 'application/json'},
          receiveDataWhenStatusError: true,
        ),
      );
    } on DioError catch (exception) {
      /// Get custom massage for the exception
      final errorMessage = DioExceptions.fromDioError(exception).errorType;

      /// throw custom exception
      throw CustomException(errorMessage, 'error.png');
    } catch (e) {
      throw CustomException(CustomStatusCodeErrorType.unExcepted, 'error.png');
    }
  }

  ///use this method to get data from api
  static Future<Response> getDate({required String url}) async {
    try {
      return await dio.get(url);
    } on DioError catch (exception) {
      /// Get custom massage for the exception
      logPrint(
          "here is the error from dio get data ${exception.response!.data["message"]} ");
      final errorType = DioExceptions.fromDioError(exception).errorType;
      final errorMessage = DioExceptions.fromDioError(exception).errorMassage;

      /// throw custom exception
      throw CustomException(errorType, 'error.png', errorMassage: errorMessage);
    } catch (e) {
      throw CustomException(CustomStatusCodeErrorType.unExcepted, 'error.png');
    }
  }
}
