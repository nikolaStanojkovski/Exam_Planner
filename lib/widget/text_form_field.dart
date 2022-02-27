import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController _controller;
  final String _textHint;
  final EdgeInsets _margins;
  final bool _isPassword;
  final Function(String?)? _validatorFunction;

  const FormTextField(this._controller, this._textHint, this._margins,
      this._isPassword, this._validatorFunction,
      {Key? key, bool obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _margins,
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: _textHint,
        ),
        obscureText: _isPassword,
        validator: (value) =>
            _validatorFunction != null ? _validatorFunction!(value) : null,
      ),
    );
  }
}
