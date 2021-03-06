import 'package:exam_planner/model/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/exam.dart';

class ExamData {
  static String title = 'Exam Planner';
  static List<User> users = [];
  static List<Exam> examScheduleMap = [
    Exam('Computer sound and music', '12.02.2022 13:30', '01:00',
        const LatLng(42.004227, 21.409944)),
    Exam('Mobile information systems', '12.03.2022 14:45', '00:30',
        const LatLng(42.004227, 21.409944)),
    Exam('Mobile platforms and programming', '12.04.2022 16:15', '01:30',
        const LatLng(42.004227, 21.409944)),
    Exam('Team project', '11.11.2022 11:15', '01:30',
        const LatLng(42.004227, 21.409944)),
    Exam('Advanced web design', '13.01.2022 08:30', '02:20',
        const LatLng(42.004227, 21.409944)),
    Exam('Advanced programming', '15.01.2022 07:55', '01:30',
        const LatLng(42.004227, 21.409944)),
    Exam('Web programming', '16.02.2022 20:45', '01:00',
        const LatLng(42.004227, 21.409944)),
    Exam('Design and architecture', '17.02.2022 15:00', '03:30',
        const LatLng(41.993905, 21.424251)),
    Exam('Object oriented programming', '24.05.2022 19:40', '01:30',
        const LatLng(41.993905, 21.424251)),
    Exam('Object oriented design', '22.02.2022 10:05', '01:45',
        const LatLng(41.993905, 21.424251)),
    Exam('Structured programming', '16.04.2022 13:35', '02:45',
        const LatLng(41.993905, 21.424251)),
    Exam('Digitisation', '28.01.2022 17:35', '01:25',
        const LatLng(41.993905, 21.424251)),
    Exam('Discrete mathematics', '17.11.2022 12:15', '00:45',
        const LatLng(41.993905, 21.424251)),
    Exam('Probability and statistics', '15.09.2022 18:00', '04:30',
        const LatLng(42.004227, 21.409944)),
  ];
}
