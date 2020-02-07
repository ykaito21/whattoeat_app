import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/providers/meals_screen_provider.dart';
import 'meals_screen.dart';

class MealsScreenWrapper extends StatelessWidget {
  const MealsScreenWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProxyProvider<AppProvider, MealsScreenProvider>(
      create: (context) => MealsScreenProvider(),
      update: (context, appProvider, mealsScreenProvider) =>
          mealsScreenProvider..currentDatabase = appProvider.appDatabase,
      dispose: (context, mealsScreenProvider) => mealsScreenProvider.dispose(),
      child: MealsScreen(),
    );
  }
}
