import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExamCreateWidget extends StatelessWidget {
  final Function(Object) _addExamFunction;
  final Function _scheduleExam;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectNameController = TextEditingController();
  final TextEditingController _examDateController = TextEditingController();
  final TextEditingController _examTimeController = TextEditingController();

  ExamCreateWidget(this._addExamFunction, this._scheduleExam, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.fromLTRB(30, 1, 15, 30),
                child: Text("Schedule a new exam",
                    style: TextStyle(
                        fontSize: 23, color: Color.fromRGBO(0, 0, 0, 0.9)))),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 5, 30),
              child: TextFormField(
                controller: _subjectNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter the name of the subject',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name of the subject';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 5, 30),
              child: TextFormField(
                controller: _examDateController,
                decoration: const InputDecoration(
                  hintText: 'Enter the date of the exam',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date of the exam';
                  }
                  List<String> stringParts = value.split(".").cast();
                  if (stringParts.length != 3 ||
                      int.tryParse(stringParts[0]) == null || stringParts[0].characters.length != 2 || int.parse(stringParts[0]) > 30  || int.parse(stringParts[0]) < 0 ||
                      int.tryParse(stringParts[1]) == null || stringParts[1].characters.length != 2 || int.parse(stringParts[1]) > 12  || int.parse(stringParts[1]) < 0 ||
                      int.tryParse(stringParts[2]) == null || stringParts[2].characters.length != 4 || int.parse(stringParts[2]) < 2021) {
                    return 'Please enter a valid date of the exam';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 5, 30),
              child: TextFormField(
                controller: _examTimeController,
                decoration: const InputDecoration(
                  hintText: 'Enter the time of the exam',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the time of the exam';
                  }
                  List<String> stringParts = value.split(":").cast();
                  if (stringParts.length != 2 ||
                      int.tryParse(stringParts[0]) == null || stringParts[0].characters.length != 2 || int.parse(stringParts[0]) > 23  || int.parse(stringParts[0]) < 0 ||
                      int.tryParse(stringParts[1]) == null || stringParts[1].characters.length != 2 || int.parse(stringParts[1]) > 60  || int.parse(stringParts[1]) < 0) {
                    return 'Please enter a valid time period';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var newExamSchedule = {
                      'subjectName': _subjectNameController.text,
                      'date': _examDateController.text,
                      'time': _examTimeController.text
                    };

                    _addExamFunction(newExamSchedule);
                    _scheduleExam();
                  }
                },
                child: const Text("Save"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  padding: const EdgeInsets.all(8.0),
                  minimumSize: const Size(150, 50),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: ElevatedButton(
                  onPressed: () {
                    _scheduleExam();
                  },
                  child: const Text("Exit"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    textStyle: const TextStyle(color: Colors.white),
                    padding: const EdgeInsets.all(8.0),
                    minimumSize: const Size(150, 44),
                  ))
            ),
          ],
        ),
      ),
    );
  }
}
