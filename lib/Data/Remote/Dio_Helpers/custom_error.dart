import 'package:celia_movies/Constants/Enums/enums.dart';

class CustomError {
  CustomStatusCodeErrorType type;
  String? errorMassage;
  String? imgPath;

  CustomError(
      {this.type = CustomStatusCodeErrorType.init,
      this.errorMassage,
      this.imgPath});

  @override
  String toString() {
    return 'SomeThing Wrong Happen: \n$type';
  }
}
