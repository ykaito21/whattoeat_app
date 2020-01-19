import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const BaseButton({
    Key key,
    @required this.onPressed,
    @required this.text,
  })  : assert(onPressed != null),
        assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      ),
      color: Theme.of(context).accentColor,
      textColor: Theme.of(context).primaryColor,
      disabledColor: Theme.of(context).accentColor.withOpacity(0.5),
      disabledTextColor: Theme.of(context).primaryColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
