import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/services/database_service.dart';

class AppProvider {
  final AppDatabase _appDatabase = AppDatabase();
  AppDatabase get appDatabase => _appDatabase;

  void dispose() {}

  Stream<List<MealWithTags>> streamMealWithTags({
    @required Stream<List<Tag>> tags,
    Stream<List<String>> keywords,
  }) {
    final Stream<List<MealWithTags>> allMealWithTags =
        _appDatabase.streamAllMealWithTags();
    if (keywords == null) {
      return CombineLatestStream.combine2<List<MealWithTags>, List<Tag>,
          List<MealWithTags>>(
        allMealWithTags,
        tags,
        (List<MealWithTags> allMealWithTags, List<Tag> tags) {
          if (tags.isEmpty) return allMealWithTags;
          List<MealWithTags> mealWithTagsList = [];
          for (var mealWithTags in allMealWithTags) {
            if (tags.any((tag) => mealWithTags.tags.contains(tag))) {
              mealWithTagsList.add(mealWithTags);
            }
          }
          return mealWithTagsList;
        },
      );
    } else {
      return CombineLatestStream.combine3<List<MealWithTags>, List<Tag>,
          List<String>, List<MealWithTags>>(
        allMealWithTags,
        tags,
        keywords,
        (List<MealWithTags> allMealWithTags, List<Tag> tags,
            List<String> keywords) {
          if (tags.isEmpty &&
              (keywords.isEmpty || keywords?.first.isEmpty ?? true))
            return allMealWithTags;
          List<MealWithTags> mealWithTagsList = [];
          if (tags.isNotEmpty &&
              (keywords.isEmpty || keywords?.first.isEmpty ?? true)) {
            mealWithTagsList.clear();
            for (var mealWithTags in allMealWithTags) {
              if (tags.any((tag) => mealWithTags.tags.contains(tag))) {
                mealWithTagsList.add(mealWithTags);
              }
            }
          }
          if (tags.isEmpty &&
              (keywords.isNotEmpty && keywords?.first.isNotEmpty ?? false)) {
            mealWithTagsList.clear();
            for (var mealWithTags in allMealWithTags) {
              if (keywords.any(
                      (keyword) => mealWithTags.meal.name.contains(keyword)) ||
                  keywords.any(
                      (keyword) => mealWithTags.meal.note.contains(keyword))) {
                mealWithTagsList.add(mealWithTags);
              }
            }
          }
          if (tags.isNotEmpty &&
              (keywords.isNotEmpty && keywords?.first.isNotEmpty ?? false)) {
            mealWithTagsList.clear();
            for (var mealWithTags in allMealWithTags) {
              if (tags.any((tag) => mealWithTags.tags.contains(tag)) &&
                      keywords.any((keyword) =>
                          mealWithTags.meal.name.contains(keyword)) ||
                  keywords.any(
                      (keyword) => mealWithTags.meal.note.contains(keyword))) {
                mealWithTagsList.add(mealWithTags);
              }
            }
          }
          return mealWithTagsList;
        },
      );
    }
  }

  Stream<List<Tag>> streamTags() {
    return _appDatabase.tagDao.streamAllTags();
  }

  deleteMealWithTags(MealWithTags mealWithTags) {
    _appDatabase.deleteMealWithTags(mealWithTags);
  }
}
