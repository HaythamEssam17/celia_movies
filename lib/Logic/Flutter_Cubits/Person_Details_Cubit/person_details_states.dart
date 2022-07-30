abstract class PersonDetailsStates {}

class PersonDetailsInitStates extends PersonDetailsStates {}

class PersonDetailsLoadingStates extends PersonDetailsStates {}

class PersonDetailsSuccessStates extends PersonDetailsStates {}

class PersonDetailsFailedStates extends PersonDetailsStates {
  final String error;

  PersonDetailsFailedStates({required this.error});
}
