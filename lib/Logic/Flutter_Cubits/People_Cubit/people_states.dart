abstract class PeopleStates {}

class PeopleInitState extends PeopleStates {}

class PeopleLoadingState extends PeopleStates {}

class PeopleSuccessState extends PeopleStates {}

class FetchPeoplesMoreDataState extends PeopleStates {}

class PeopleFailedState extends PeopleStates {
  final String error;

  PeopleFailedState({required this.error});
}

class FetchPeoplesLocalState extends PeopleStates {}
