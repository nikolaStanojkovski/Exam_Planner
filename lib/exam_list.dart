import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExamListWidget extends StatelessWidget {
  final List<Map<String, String>>? _elements;

  const ExamListWidget(this._elements, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _elements!.length,
      itemBuilder: (context, index) {
        return Card(
            elevation: 2,
            child: Column(children: [
              Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(_elements![index]['subjectName'].toString(),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 0, 0, 1.0)))),
              Container(
                margin: const EdgeInsets.all(10),
                child: Text(
                    "Date: ${_elements![index]['date'].toString()}, Time ${_elements![index]['time'].toString()}"),
              ),
            ]));
      },
    );
  }
}
