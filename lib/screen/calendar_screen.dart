import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_03/utils/date_utils.dart';
import 'package:lab_03/model/exam.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarExamScreen extends StatelessWidget {
  static const routeName = '/exam/calendar';

  const CalendarExamScreen({Key? key}) : super(key: key);

  List<Appointment> _createAppointments(List<Exam> exams) {
    List<Appointment> meetings = <Appointment>[];
    for (var element in exams) {
      final DateTime startTime = DateTimeUtils.createDateTime(element.date);

      final duration = element.time.split(":");
      final DateTime endTime = startTime.add(Duration(
          hours: int.parse(duration[0]), minutes: int.parse(duration[1])));

      meetings.add(Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: element.subjectName,
          color: Colors.blue));
    }

    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    final exams = ModalRoute.of(context)!.settings.arguments as List<Exam>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam Schedule"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SfCalendar(
          view: CalendarView.schedule,
          firstDayOfWeek: 6,
          dataSource: MeetingDataSource(_createAppointments(exams)),
        ),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
