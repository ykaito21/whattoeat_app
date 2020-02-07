import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/services/database_service.dart';
import '../../core/providers/write_meal_screen_provider.dart';
import 'write_meal_screen.dart';

class WriteMealScreenWrapper extends StatelessWidget {
  final MealWithTags mealWithTags;
  const WriteMealScreenWrapper({
    Key key,
    this.mealWithTags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProxyProvider<AppProvider, WriteMealScreenProvider>(
      create: (context) =>
          WriteMealScreenProvider(currentMealWithTags: mealWithTags),
      update: (context, appProvider, writeMealScreenProvider) =>
          writeMealScreenProvider..currentDatabase = appProvider.appDatabase,
      dispose: (context, writeMealScreenProvider) =>
          writeMealScreenProvider.dispose(),
      child: WriteMealScreen(),
    );
  }
}
