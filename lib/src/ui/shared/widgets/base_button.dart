import 'package:flutter/material.dart';
import '../../global/extensions.dart';
import '../../global/style_list.dart';

class BaseButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const BaseButton({
    Key key,
    @required this.onPressed,
    @required this.text,
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: context.accentColor,
      textColor: context.primaryColor,
      disabledColor: context.accentColor.withOpacity(0.5),
      disabledTextColor: context.primaryColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        // side: BorderSide(
        //   color: context.accentColor,
        // ),
      ),
      child: Text(
        text,
        style: StyleList.buttonTextStyle,
      ),
    );
  }
}
