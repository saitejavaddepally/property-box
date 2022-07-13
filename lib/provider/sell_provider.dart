import 'dart:collection';

import 'package:flutter/material.dart';

class SellScreenProvider extends ChangeNotifier {
  // for currentLocation dropDown
  final List<String> _currentLocationDropDown = ['Current location', 'abcde'];
  String? _currentLocationChosenValue = 'Current location';

  String? get currentLocationChosenValue => _currentLocationChosenValue;

  UnmodifiableListView<String> get currentLocationDropDown =>
      UnmodifiableListView(_currentLocationDropDown);

  void onChangedCurrentLocation(value) {
    _currentLocationChosenValue = value;
    notifyListeners();
  }

  // for possession dropDown
  final List<String> _possessionDropDown = ['Possession', 'abcde'];
  String? _possessionChosenValue = 'Possession';

  String? get possessionChosenValue => _possessionChosenValue;

  UnmodifiableListView<String> get possessionDropDown =>
      UnmodifiableListView(_possessionDropDown);

  void onChangedPossession(value) {
    _possessionChosenValue = value;
    notifyListeners();
  }

  // for sort dropDown
  final List<String> _sortDropDown = ['Sort', 'abcde'];
  String? _sortChosenValue = 'Sort';

  String? get sortChosenValue => _sortChosenValue;

  UnmodifiableListView<String> get sortDropDown =>
      UnmodifiableListView(_sortDropDown);

  void onChangedSort(value) {
    _sortChosenValue = value;
    notifyListeners();
  }
}

class PageNumberProvider extends ChangeNotifier {
  int page = 0;
  void onPageNumberChanged(pageNumber, reason) {
    page = pageNumber;
    notifyListeners();
  }
}
