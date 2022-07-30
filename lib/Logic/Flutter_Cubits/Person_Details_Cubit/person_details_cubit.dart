import 'package:celia_movies/Data/Interfaces/perple_interface.dart';
import 'package:celia_movies/Data/Models/person_details_model.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/Person_Details_Cubit/person_details_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonDetailsCubit extends Cubit<PersonDetailsStates> {
  final IPeopleInterface _iPeopleInterface;

  PersonDetailsModel personDetailsModel = PersonDetailsModel();

  PersonDetailsCubit(this._iPeopleInterface) : super(PersonDetailsInitStates());

  getPersonDetailsByID(int personID) async {
    try {
      emit(PersonDetailsLoadingStates());

      var result = await _iPeopleInterface.fetchPersonByID(personID: personID);

      if (_iPeopleInterface.isError) {
        emit(PersonDetailsFailedStates(
            error: _iPeopleInterface.errorMsg!.errorMassage!.toString()));
      } else {
        personDetailsModel = result;

        emit(PersonDetailsSuccessStates());
      }
    } catch (e) {
      emit(PersonDetailsFailedStates(error: e.toString()));
    }
  }
}
