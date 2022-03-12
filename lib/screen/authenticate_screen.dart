import 'package:exam_planner/model/role.dart';
import 'package:exam_planner/model/user.dart';
import 'package:exam_planner/widget/form/button_form_field.dart';
import 'package:exam_planner/widget/form/form_field.dart';
import 'package:exam_planner/widget/form/radio_form_field.dart';
import 'package:exam_planner/widget/form/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthenticateScreen extends StatefulWidget {
  static const routeName = '/authenticate';

  final bool Function(User user)? _loginFunction;
  final bool Function(User user)? _registerFunction;
  final Function? _navigateFunction;

  const AuthenticateScreen(
      this._loginFunction, this._registerFunction, this._navigateFunction,
      {Key? key})
      : super(key: key);

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  final _formKey = GlobalKey<FormState>();

  Role? _roleController;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _validateInput(String? username, String? password, Role? role) {
    if (username == null || username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter the username'),
        duration: Duration(seconds: 1),
      ));
      return false;
    }
    if (role == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please choose a role'),
        duration: Duration(seconds: 1),
      ));
      return false;
    }
    if (password == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter the password'),
        duration: Duration(seconds: 1),
      ));
      return false;
    }
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password too short'),
        duration: Duration(seconds: 1),
      ));
      return false;
    }
    return true;
  }

  void _loginUser() {
    if (_validateInput(
        _usernameController.text, _passwordController.text, _roleController)) {
      var user = User(
          _usernameController.text, _passwordController.text, _roleController!);
      bool value = widget._loginFunction!(user);
      if (value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Welcome, ${user.username}"),
          duration: const Duration(seconds: 4),
        ));
        widget._navigateFunction!();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid credentials"),
          duration: Duration(seconds: 1),
        ));
      }
    }
  }

  void _registerUser() {
    if (_validateInput(
        _usernameController.text, _passwordController.text, _roleController)) {
      var user = User(
          _usernameController.text, _passwordController.text, _roleController!);
      bool value = widget._registerFunction!(user);
      if (value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Registration Successful"),
          duration: Duration(seconds: 1),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("There is already a user with the same username"),
          duration: Duration(seconds: 1),
        ));
      }
    }
  }

  void _setRoleValue(var value) {
    setState(() {
      _roleController = value as Role?;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Authentication"),
      ),
      body: FormControl(_formKey, [
        FormTextField(_usernameController, 'Enter the username',
            const EdgeInsets.fromLTRB(30, 10, 5, 30), false, null),
        FormTextField(_passwordController, 'Enter the password',
            const EdgeInsets.fromLTRB(30, 5, 5, 30), true, null),
        Column(
          children: <Widget>[
            FormRadioField(
                _roleController, Role.student, "Student", _setRoleValue),
            FormRadioField(
                _roleController, Role.teacher, "Teacher", _setRoleValue),
          ],
        ),
        ButtonFormField(const EdgeInsets.fromLTRB(0, 30, 0, 0), _loginUser,
            "Login", Colors.black, Colors.white),
        ButtonFormField(const EdgeInsets.fromLTRB(0, 10, 0, 0), _registerUser,
            "Register", Colors.blue, Colors.white),
      ]),
    );
  }
}
