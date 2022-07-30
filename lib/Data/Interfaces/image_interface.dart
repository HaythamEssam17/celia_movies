import 'package:celia_movies/Data/Interfaces/base_interface.dart';
import 'package:celia_movies/Data/Models/image_model.dart';

abstract class IImageInterface extends IBaseInterface {
  /// Fetch all Images
  Future<ImageModel> fetchAllImages({required int personID});
}
