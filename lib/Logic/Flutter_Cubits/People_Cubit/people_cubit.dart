import 'package:celia_movies/Data/Interfaces/perple_interface.dart';
import 'package:celia_movies/Data/Models/person_model.dart';
import 'package:celia_movies/Helpers/app_logs.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/People_Cubit/people_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleCubit extends Cubit<PeopleStates> {
  final IPeopleInterface _iPeopleInterface;

  List<PersonModel> persons = [];

  PeopleCubit(this._iPeopleInterface) : super(PeopleInitState());

  int _totalRecords = 0;
  int get getTotalRecords => _totalRecords;

  int page = 0;
  late ScrollController scrollController;
  double currentScrollOffset = 0;

  bool hasNextPage = false;
  bool isLoadingMoreTransactions = false;

  /// Refresh Functions
  Future onRefresh() async {
    page = 0;
    persons.clear();
    fetchAllPopularPeople();
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      logPrint('loading more people 111');
      if (state is! FetchPeoplesMoreDataState && hasNextPage) {
        logPrint('loading more people 222');
        isLoadingMoreTransactions = true;
        fetchPopularPagingPeople();
      }
    } else {
      isLoadingMoreTransactions = false;
    }
  }

  fetchAllPopularPeople() async {
    try {
      page = 1;
      emit(PeopleLoadingState());

      var result = await _iPeopleInterface.fetchAllPopularPeople(page: page);

      if (_iPeopleInterface.isError) {
        emit(PeopleFailedState(
            error: _iPeopleInterface.errorMsg!.errorMassage!));
        return;
      }

      _totalRecords = result.totalPages!;
      logPrint('_totalRecords: $_totalRecords');

      hasNextPage = _totalRecords > page ? true : false;

      persons = result.results!;

      emit(PeopleSuccessState());
    } catch (e) {
      emit(PeopleFailedState(error: e.toString()));
    }
  }

  void fetchPopularPagingPeople() async {
    page = page + 1;
    logPrint('more page: $page');
    try {
      emit(FetchPeoplesMoreDataState());

      var result = await _iPeopleInterface.fetchAllPopularPeople(page: page);

      if (_iPeopleInterface.isError) {
        emit(PeopleFailedState(
            error: _iPeopleInterface.errorMsg!.errorMassage!));
        return;
      }
      logPrint('result.data: ${result.results!.first.toJson()}');

      if (_totalRecords == 0) {
        _totalRecords = result.totalPages!;
      }

      hasNextPage = result.totalPages! > page ? true : false;

      for (var i in result.results!) {
        if (persons.length < result.totalPages!) {
          persons.add(i);
        }
      }

      emit(PeopleSuccessState());
    } catch (e) {
      emit(PeopleFailedState(error: e.toString()));
    }
  }
}
