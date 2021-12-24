import 'package:flutter/material.dart';
import 'package:lab_03/exam_create.dart';
import 'package:lab_03/exam_data.dart';
import 'package:lab_03/exam_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Exam Planner',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ));
  }

  @override
  State<StatefulWidget> createState() => MyHomePage();
}

class MyHomePage extends State<MyApp> {
  final List<Map<String, String>> _elements = ExamData.examScheduleMap;
  final String? _title = 'Exam Planner';
  bool _createExamClick = false;

  void _addNewExam(var newExam) {
    setState(() {
      _elements.add(newExam);
    });
  }

  void _scheduleExam() {
    setState(() {
      _createExamClick = !_createExamClick;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title.toString(),
        home: Scaffold(
          appBar: AppBar(
            title: Text(_title.toString()),
            actions: [
              IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _scheduleExam()),
            ],
          ),
          body: _createExamClick
              ? ExamCreateWidget(_addNewExam, _scheduleExam)
              : ExamListWidget(_elements),
        ));
  }
}
