import 'package:celia_movies/Data/Interfaces/base_interface.dart';
import 'package:celia_movies/Data/Models/base_model.dart';
import 'package:celia_movies/Data/Models/person_details_model.dart';

abstract class IPeopleInterface extends IBaseInterface {
  /// Fetch all popular peoples
  Future<BaseModel> fetchAllPopularPeople({int? page});

  /// Fetch people by id
  Future<PersonDetailsModel> fetchPersonByID({required int personID});
}
