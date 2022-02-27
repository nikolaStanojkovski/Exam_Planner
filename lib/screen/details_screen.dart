import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_03/model/exam.dart';

class DetailsExamScreen extends StatefulWidget {
  static const routeName = '/exam/details';

  const DetailsExamScreen({Key? key}) : super(key: key);

  @override
  State<DetailsExamScreen> createState() => _DetailsExamScreenState();
}

class _DetailsExamScreenState extends State<DetailsExamScreen> {
  late Exam _selectedExam;

  @override
  Widget build(BuildContext context) {
    _selectedExam = ModalRoute.of(context)!.settings.arguments as Exam;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam Details"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _selectedExam.subjectName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 0, 0, 1.0)),
                      ),
                    ],
                  ),
                ),
                Text(
                  _selectedExam.date,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1.0)),
                ),
                Text(
                  _selectedExam.time,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, color: Color.fromRGBO(0, 0, 0, 1.0)),
                ),
              ]),
        ),
      ),
    );
  }
}
