import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../services/database_service.dart';

class SlotScreenProvider {
  AppDatabase _appDatabase;

  set currentDatabase(AppDatabase value) {
    if (_appDatabase != value) {
      _appDatabase = value;
    }
  }

  void dispose() {
    _slotScrollController.dispose();
    _slotScreenTagSubject.close();
  }

// FOR SLOT
  final _slotScrollController = FixedExtentScrollController();
  FixedExtentScrollController get slotScrollController => _slotScrollController;
  final random = Random();

  void slotStart(int length) {
    _slotScrollController.animateToItem(
      _slotScrollController.selectedItem +
          ((length + 30) + random.nextInt(length)),
      duration: Duration(seconds: 3),
      curve: Curves.ease,
    );
  }

// FOR TAGS
  List<Tag> _selectedTags = [];
  List<Tag> get selectedTags => _selectedTags;

  void onPressedTag(Tag tag, bool isSelected) {
    isSelected ? _selectedTags.add(tag) : _selectedTags.remove(tag);
    _slotScreenTagSubject.add(_selectedTags);
  }

  final _slotScreenTagSubject = BehaviorSubject<List<Tag>>.seeded(<Tag>[]);
  Stream<List<Tag>> get streamSlotScreenSelectedTags =>
      _slotScreenTagSubject.stream;
}
