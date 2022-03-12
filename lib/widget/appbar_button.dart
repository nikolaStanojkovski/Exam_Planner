import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  final Function() _onPressedFunction;
  final String _text;

  const AppBarButton(this._onPressedFunction, this._text, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _onPressedFunction(),
      style: TextButton.styleFrom(
        primary: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
      child: Text(_text),
    );
  }
}
