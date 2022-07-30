import 'package:celia_movies/Data/Interfaces/base_interface.dart';
import 'package:celia_movies/Data/Models/base_model.dart';

abstract class IPeopleInterface extends IBaseInterface {
  /// Fetch all popular peoples
  Future<BaseModel> fetchAllPopularPeople();
}
