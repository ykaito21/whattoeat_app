import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../services/database_service.dart';

class MealsScreenProvider {
  AppDatabase _appDatabase;

  set currentDatabase(AppDatabase value) {
    if (_appDatabase != value) {
      _appDatabase = value;
    }
  }

  void dispose() {
    _mealsScreenTagSubject.close();
    _searchController.dispose();
    _searchSubject.close();
  }

  // For tag
  List<Tag> _selectedTags = [];
  List<Tag> get selectedTags => _selectedTags;

  void onPressedTag(Tag tag, bool isSelected) {
    isSelected ? _selectedTags.add(tag) : _selectedTags.remove(tag);
    _mealsScreenTagSubject.add(_selectedTags);
  }

  final BehaviorSubject<List<Tag>> _mealsScreenTagSubject =
      BehaviorSubject<List<Tag>>.seeded(<Tag>[]);
  Stream<List<Tag>> get streamMealsScreenSelectedTags =>
      _mealsScreenTagSubject.stream;

  // For keywords
  //* keywords search doesn't work well in japanese
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  final BehaviorSubject<List<String>> _searchSubject =
      BehaviorSubject<List<String>>.seeded(<String>[]);
  // List<String> get searchedKeywords => _searchSubject.value;
  Stream<List<String>> get streamSearchKeywords => _searchSubject.stream;
  //* could be this
  // final BehaviorSubject<String> _searchSubject =
  //     BehaviorSubject<String>.seeded('');
  // Stream<List<String>> get streamSearchKeywords =>
  //     _searchSubject.stream.map<List<String>>((event) {
  //       final List<String> keywords = event.split(' ');
  //       keywords.removeWhere((keyword) => keyword.isEmpty);
  //       return keywords;
  //     });
  // Function get changeKeywords => _searchSubject.add;

  void searchInput(String input) {
    final List<String> keywords = input.split(' ');
    keywords.removeWhere((keyword) => keyword.isEmpty);
    _searchSubject.add(keywords);
    print(keywords);
  }

  void clearKeywords() {
    // to avoid exception
    Future.delayed(Duration(milliseconds: 50)).then(
      (_) {
        _searchController.clear();
        // _searchSubject.add('');
        _searchSubject.add(<String>[]);
      },
    );
  }

  // can be stream
  bool toggleIcon() => _searchController.text == '';
}
