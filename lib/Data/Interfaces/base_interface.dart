import 'package:celia_movies/Data/Remote/Dio_Helpers/custom_error.dart';

import '../Models/base_model.dart';

abstract class IBaseInterface {
  BaseModel baseModel = BaseModel();
  CustomError? errorMsg;
  bool isError = false;
}
