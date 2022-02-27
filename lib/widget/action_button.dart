import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final BuildContext _context;
  final IconData _icon;
  final void Function(BuildContext) _clickFunction;

  const ActionButton(this._icon, this._clickFunction, this._context,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(_icon), onPressed: () => _clickFunction(_context));
  }
}
