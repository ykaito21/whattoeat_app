import 'package:flutter/material.dart';
import 'package:whattoeat_app/src/ui/screens/slot_screen.dart';

class WriteMealScreen extends StatelessWidget {
  const WriteMealScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('back'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(
                MaterialPageRoute(
                  builder: (context) => SlotScreen(),
                ),
              );
            },
            child: Text('forward'),
          ),
        ],
      ),
    );
  }
}
