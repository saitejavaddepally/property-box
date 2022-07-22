import 'dart:collection';

import 'package:flutter/material.dart';

class InterestedProvider extends ChangeNotifier {
  InterestedProvider(Map<String, dynamic>? data) {
    if (data != null) {
      mobileController.text = data['phone'].toString().replaceAll("+91", "");
      nameController.text = data['name'];
      locationController.text = data['location'];
    }
  }

  // for nameTextField
  final TextEditingController nameController = TextEditingController();

  String _name = '';
  onNameSubmitted(String value) {
    _name = value;
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter Your Name";
    } else {
      return null;
    }
  }

  // for locationTextField

  final TextEditingController locationController = TextEditingController();

  String _location = '';
  onLocationSubmitted(String value) {
    _location = value;
  }

  String? validateLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please Select Location";
    } else {
      return null;
    }
  }

  // for mobileTextField

  final TextEditingController mobileController = TextEditingController();

  String _mobile = '';
  onMobileSubmitted(String value) {
    _mobile = value;
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty || value.length != 10) {
      return "Enter Correct Mobile Number";
    }
    return null;
  }

  // for buyingDropDown
  final List<String> _buyingDropDown = [
    'Immediate',
    'With in 30 days',
    'With in 3 months',
    'Just an enquiry'
  ];
  String? _buyingChosenValue;

  String? get buyingChosenValue => _buyingChosenValue;

  UnmodifiableListView<String> get buyingDropDown =>
      UnmodifiableListView(_buyingDropDown);

  void onChangedBuying(value) {
    _buyingChosenValue = value;
    notifyListeners();
  }

  // for preferenceTimeDropDown
  final List<String> _preferenceTimeDropDown = [
    'Anytime',
    'Evening after 6',
    'Only weekends'
  ];
  String? _preferenceTimeChosenValue;

  String? get preferenceTimeChosenValue => _preferenceTimeChosenValue;

  UnmodifiableListView<String> get preferenceTimeDropDown =>
      UnmodifiableListView(_preferenceTimeDropDown);

  void onChangedPreferenceTime(value) {
    _preferenceTimeChosenValue = value;
    notifyListeners();
  }

  // for commentsTextField

  final TextEditingController commentsController = TextEditingController();

  String _comments = '';
  onCommentsSubmitted(String value) {
    _comments = value;
  }

  void resetData() {
    nameController.clear();
    mobileController.clear();
    locationController.clear();
    _buyingChosenValue = null;
    _preferenceTimeChosenValue = null;
    commentsController.clear();
    notifyListeners();
  }

  Map<String, dynamic> getAllData() {
    return {
      'name': nameController.text,
      'mobile': mobileController.text,
      'location': locationController.text,
      'buying_time': buyingChosenValue,
      'prefer_time': preferenceTimeChosenValue,
      'comments': commentsController.text
    };
  }
}
