import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/providers/app_provider.dart';
import 'ui/global/app_theme.dart';
import 'ui/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => AppProvider(),
          //todo oprtional?
          dispose: (_, appProvider) => appProvider.dispose,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'What2Eat',
        theme: appThemes[AppTheme.Light],
        darkTheme: appThemes[AppTheme.Dark],
        home: HomeScreen(),
      ),
    );
  }
}
