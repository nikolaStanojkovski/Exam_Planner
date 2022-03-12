import 'package:google_maps_flutter/google_maps_flutter.dart';

class Exam {
  late String subjectName;
  late String date;
  late String time;
  late LatLng location;

  Exam(this.subjectName, this.date, this.time, this.location);
}
