import 'package:flutter/material.dart';

class DateTimeUtils {
  static bool validateDate(List<String> stringParts, String value) {
    List<String> dateParts = stringParts[0].split(".").cast();
    List<String> timeParts = stringParts[1].split(":").cast();
    return !(dateParts.length != 3 ||
        timeParts.length != 2 ||
        int.tryParse(dateParts[0]) == null ||
        dateParts[0].characters.length != 2 ||
        int.parse(dateParts[0]) > 30 ||
        int.parse(dateParts[0]) < 0 ||
        int.tryParse(dateParts[1]) == null ||
        dateParts[1].characters.length != 2 ||
        int.parse(dateParts[1]) > 12 ||
        int.parse(dateParts[1]) < 0 ||
        int.tryParse(dateParts[2]) == null ||
        dateParts[2].characters.length != 4 ||
        int.parse(dateParts[2]) < 2022 ||
        int.tryParse(timeParts[0]) == null ||
        timeParts[0].characters.length != 2 ||
        int.parse(timeParts[0]) > 24 ||
        int.parse(timeParts[0]) < 0 ||
        int.tryParse(timeParts[1]) == null ||
        timeParts[1].characters.length != 2 ||
        int.parse(timeParts[1]) > 60 ||
        int.parse(timeParts[1]) < 0 ||
        DateTime.tryParse("${dateParts[2]}-${dateParts[1]}-${dateParts[0]}") ==
            null);
  }

  static bool validateTime(String value) {
    List<String> stringParts = value.split(":").cast();
    return !(stringParts.length != 2 ||
        int.tryParse(stringParts[0]) == null ||
        stringParts[0].characters.length != 2 ||
        int.parse(stringParts[0]) > 23 ||
        int.parse(stringParts[0]) < 0 ||
        int.tryParse(stringParts[1]) == null ||
        stringParts[1].characters.length != 2 ||
        int.parse(stringParts[1]) > 60 ||
        int.parse(stringParts[1]) < 0);
  }

  static DateTime createDateTime(String dateString) {
    final parts = dateString.split(" ");

    final date = parts[0].split(".");
    final day = int.parse(date[0]);
    final month = int.parse(date[1]);
    final year = int.parse(date[2]);
    final time = parts[1].split(":");
    final hour = int.parse(time[0]);
    final minutes = int.parse(time[1]);

    return DateTime(year, month, day, hour, minutes);
  }
}
