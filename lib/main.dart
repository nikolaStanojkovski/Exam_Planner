import 'package:flutter/material.dart';
import 'package:lab_03/data/exam_data.dart';
import 'package:lab_03/screen/authenticate_screen.dart';
import 'package:lab_03/screen/calendar_screen.dart';
import 'package:lab_03/screen/create_screen.dart';
import 'package:lab_03/screen/details_screen.dart';
import 'package:lab_03/screen/list_screen.dart';
import 'package:lab_03/screen/main_screen.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ExamData.title.toString(),
        routes: {
          AuthenticateScreen.routeName: (ctx) =>
              const AuthenticateScreen(null, null, null),
          CreateExamScreen.routeName: (ctx) => const CreateExamScreen(),
          ListExamScreen.routeName: (ctx) => ListExamScreen(List.empty()),
          DetailsExamScreen.routeName: (ctx) => const DetailsExamScreen(),
          CalendarExamScreen.routeName: (ctx) => const CalendarExamScreen(),
        },
        home: const MainScreen());
  }
}
