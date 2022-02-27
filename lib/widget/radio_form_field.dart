import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_03/model/role.dart';

class FormRadioField extends StatelessWidget {
  final Role? _roleController;
  final Role _value;
  final String _title;
  final Function(Object?) _stateFunction;

  const FormRadioField(this._roleController, this._value, this._title, this._stateFunction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_title),
      leading: Radio(
        value: _value,
        onChanged: (var value) {
          _stateFunction(value);
        },
        groupValue: _roleController,
      ),
    );
  }

}