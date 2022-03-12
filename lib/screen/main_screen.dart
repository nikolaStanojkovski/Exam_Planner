import 'package:exam_planner/data/exam_data.dart';
import 'package:exam_planner/model/exam.dart';
import 'package:exam_planner/model/role.dart';
import 'package:exam_planner/model/user.dart';
import 'package:exam_planner/util/notification_api.dart';
import 'package:exam_planner/widget/action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'authenticate_screen.dart';
import 'calendar_screen.dart';
import 'create_screen.dart';
import 'list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final String _title = ExamData.title;
  var _isLogged = false;
  final List<Exam> _elements = ExamData.examScheduleMap;
  final List<User> _users = ExamData.users;
  User? _currentUser;

  void _addNewExam(var exam) {
    setState(() {
      _elements.add(exam);
    });
    NotificationApi.scheduleNotification(exam);
  }

  bool _login(User user) {
    if (_users.any((element) =>
        element.username == user.username &&
        element.password == user.password &&
        element.role == user.role)) {
      _currentUser = user;
      return true;
    }
    return false;
  }

  bool _register(User user) {
    if (!_users.any((element) =>
        element.username == user.username &&
        element.password == user.password &&
        element.role == user.role)) {
      setState(() {
        _users.add(user);
      });
      return true;
    }
    return false;
  }

  void _navigateOut() {
    setState(() {
      _isLogged = true;
    });
  }

  void _logout(BuildContext context) {
    setState(() {
      _currentUser = null;
      _isLogged = false;
    });
    NotificationApi.cancelNotifications();
  }

  void _scheduleExam(BuildContext context) {
    Navigator.of(context).pushNamed(CreateExamScreen.routeName,
        arguments: [_addNewExam, context]);
  }

  void _openCalendar(BuildContext context) {
    Navigator.of(context)
        .pushNamed(CalendarExamScreen.routeName, arguments: _elements);
  }

  List<Widget>? _actionButtons(BuildContext context) {
    List<Widget>? buttons = [];
    if (_currentUser!.role == Role.teacher) {
      buttons.add(ActionButton(Icons.add, _scheduleExam, context));
    }
    buttons.add(
        ActionButton(Icons.calendar_today_rounded, _openCalendar, context));
    buttons.add(ActionButton(Icons.logout, _logout, context));

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return _isLogged
        ? Scaffold(
            appBar: AppBar(
                title: Text(_title.toString()),
                actions: _actionButtons(context)),
            body: ListExamScreen(_elements))
        : AuthenticateScreen(_login, _register, _navigateOut);
  }
}
