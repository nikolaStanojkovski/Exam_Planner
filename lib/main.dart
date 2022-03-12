import 'package:exam_planner/data/exam_data.dart';
import 'package:exam_planner/screen/authenticate_screen.dart';
import 'package:exam_planner/screen/calendar_screen.dart';
import 'package:exam_planner/screen/create_screen.dart';
import 'package:exam_planner/screen/details_screen.dart';
import 'package:exam_planner/screen/list_screen.dart';
import 'package:exam_planner/screen/main_screen.dart';
import 'package:exam_planner/screen/maps_screen.dart';
import 'package:flutter/material.dart';

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
          MapsExamScreen.routeName: (ctx) => const MapsExamScreen(),
        },
        home: const MainScreen());
  }
}
