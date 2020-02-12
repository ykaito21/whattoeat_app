import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:rxdart/rxdart.dart';

import '../services/database_service.dart';

//todo alert dialog and snackbar and try catch
//todo when delete tag

class WriteMealScreenProvider {
  final MealWithTags currentMealWithTags;
  AppDatabase _appDatabase;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  String _initialName = '';
  String _initialNote = '';
  List<Tag> _initialTags = [];

  TextEditingController get nameController => _nameController;
  TextEditingController get noteController => _noteController;
  FocusNode get nameFocusNode => _nameFocusNode;
  List<Tag> get initialTags => [..._initialTags];

  WriteMealScreenProvider({
    this.currentMealWithTags,
  }) {
    _initialName = currentMealWithTags?.meal?.name ?? '';
    _initialNote = currentMealWithTags?.meal?.note ?? '';
    _initialTags.addAll(currentMealWithTags?.tags ?? []);
    _nameController.text = _initialName;
    _noteController.text = _initialNote;
    _selectedTags = initialTags;
    _writeMealScreenTagSubject.add(initialTags);
  }

  set currentDatabase(AppDatabase value) {
    if (_appDatabase != value) {
      _appDatabase = value;
    }
  }

  void dispose() {
    _nameController.dispose();
    _noteController.dispose();
    _writeMealScreenTagSubject.close();
    _nameFocusNode.dispose();
    _checkUpdateSubject.close();
  }

  bool isNew() => currentMealWithTags == null;

//todo i18n
  bool onPressdButton(BuildContext context, bool isUpdated) =>
      isUpdated ? _updateMealWithTags() : _startEditing(context);

  bool _updateMealWithTags() {
    if (_nameController.text.length >= 1 && _nameController.text.length <= 50) {
      final MealWithTags newMealWithTags = MealWithTags(
        Meal(
          id: currentMealWithTags?.meal?.id,
          name: _nameController.text,
          note: _noteController.text,
        ),
        _writeMealScreenTagSubject.value,
      );
      _appDatabase.insertMealWithTags(newMealWithTags);
      // _nameController.clear();
      // _noteController.clear();
      return true;
    }
    return false;
  }

  bool _startEditing(context) {
    FocusScope.of(context).requestFocus(_nameFocusNode);
    return false;
  }

// For tag
  void onSubmitTag(String tagName) {
    if (tagName.length >= 1 && tagName.length <= 10) {
      final TagsCompanion tag = TagsCompanion(
        name: Value(tagName),
      );
      _appDatabase.tagDao.insertTag(tag);
    }
  }

  void onRemoveTag(Tag tag) => _appDatabase.deleteTag(tag);

  List<Tag> _selectedTags = [];

  void onPressedTag(Tag tag, bool isSelected) {
    isSelected ? _selectedTags.add(tag) : _selectedTags.remove(tag);
    _writeMealScreenTagSubject.add(_selectedTags);
  }

  final BehaviorSubject<List<Tag>> _writeMealScreenTagSubject =
      BehaviorSubject<List<Tag>>.seeded(<Tag>[]);

  // For button
  final BehaviorSubject<bool> _checkUpdateSubject =
      BehaviorSubject<bool>.seeded(false);
  Stream<bool> get isUpdated => _checkUpdateSubject.stream;

  // check equallity of the lists
  bool compareTags(List<Tag> initialTags, List<Tag> currentTags) {
    if (initialTags.length != currentTags.length) return false;
    final sortedInitialTags = initialTags..sort((a, b) => a.id.compareTo(b.id));
    final sortedCurrentTags = currentTags..sort((a, b) => a.id.compareTo(b.id));
    return listEquals(sortedInitialTags, sortedCurrentTags);
  }

//? need to use CombineLatest here?
  Stream<bool> checkUpdate() {
    return CombineLatestStream.combine2<bool, List<Tag>, bool>(
      isUpdated,
      _writeMealScreenTagSubject.stream,
      (bool currentStatus, List<Tag> tags) {
        if (_initialName != _nameController.text ||
            !compareTags(_initialTags, tags) ||
            _initialNote != _noteController.text) return true;
        return false;
      },
    );
  }
}
