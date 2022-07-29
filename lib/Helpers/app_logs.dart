import 'dart:developer' as developer;

/// This function print the whole message or response
void logPrint(String message) => developer.log(message);

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
