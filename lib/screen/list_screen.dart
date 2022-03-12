import 'package:exam_planner/model/exam.dart';
import 'package:exam_planner/screen/details_screen.dart';
import 'package:exam_planner/util/notification_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListExamScreen extends StatelessWidget {
  static const routeName = '/exam/list';
  final List<Exam> _elements;

  const ListExamScreen(this._elements, {Key? key}) : super(key: key);

  void _examDetails(BuildContext context, Exam exam) {
    Navigator.of(context)
        .pushNamed(DetailsExamScreen.routeName, arguments: exam);
  }

  @override
  Widget build(BuildContext context) {
    NotificationApi.init();
    NotificationApi.scheduleTimeNotifications(_elements);

    return ListView.builder(
      itemCount: _elements.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _examDetails(context, _elements[index]),
          child: Card(
              elevation: 2,
              child: Column(children: [
                Container(
                    margin: const EdgeInsets.all(10),
                    child: Text(_elements[index].subjectName.toString(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 0, 0, 1.0)))),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                      "Date: ${_elements[index].date.toString()}, Duration ${_elements[index].time.toString()}"),
                ),
              ])),
        );
      },
    );
  }
}
