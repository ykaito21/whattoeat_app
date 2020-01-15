import 'package:flutter/material.dart';

import 'ui/global/app_theme.dart';
import 'ui/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'What2Eat',
      theme: appThemes[AppTheme.Light],
      darkTheme: appThemes[AppTheme.Dark],
      home: HomeScreen(),
    );
  }
}
