import 'package:celia_movies/Constants/Enums/enums.dart';

class CustomException implements Exception {
  CustomStatusCodeErrorType type;
  String errorMassage;
  String imgPath;

  CustomException(this.type, this.imgPath, {this.errorMassage = ""});

  @override
  String toString() {
    return 'SomeThing Wrong Happen: \n$type';
  }
}