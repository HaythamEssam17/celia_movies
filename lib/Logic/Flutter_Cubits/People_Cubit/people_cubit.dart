import 'package:celia_movies/Data/Interfaces/perple_interface.dart';
import 'package:celia_movies/Data/Models/person_model.dart';
import 'package:celia_movies/Helpers/app_logs.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/People_Cubit/people_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleCubit extends Cubit<PeopleStates> {
  final IPeopleInterface _iPeopleInterface;

  List<PersonModel> persons = [];

  PeopleCubit(this._iPeopleInterface) : super(PeopleInitState());

  fetchAllPopularPeople() async {
    try {
      emit(PeopleLoadingState());

      var result = await _iPeopleInterface.fetchAllPopularPeople();

      if (_iPeopleInterface.isError) {
        emit(PeopleFailedState(
            error: _iPeopleInterface.errorMsg!.errorMassage!));
        return;
      }

      logPrint('result.data: ${result.results!.first.toJson()}');

      persons = result.results!;

      // persons =
      //     (result.results as List).map((e) => PersonModel.fromJson(e)).toList();

      emit(PeopleSuccessState());
    } catch (e) {
      emit(PeopleFailedState(error: e.toString()));
    }
  }
}
