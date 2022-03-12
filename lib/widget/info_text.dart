import 'package:flutter/cupertino.dart';

class InfoText extends StatelessWidget {
  final String _text;
  final TextStyle _textStyle;

  const InfoText(this._text, this._textStyle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(_text, textAlign: TextAlign.center, style: _textStyle);
  }
}
