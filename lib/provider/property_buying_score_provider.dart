import 'package:flutter/material.dart';

import '../ui/property_buying_score.dart';

class PropertyBuyingScoreProvider extends ChangeNotifier {
  // for dobTextField
  final TextEditingController dobController = TextEditingController();

  String? validateDate(String? size) {
    if (size == null || size.trim().isEmpty) {
      return 'Date Required';
    } else {
      return null;
    }
  }

  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(DateTime.now().year - 70),
        lastDate: DateTime(DateTime.now().year + 70));
    if (picked != null) {
      selectedDate = picked;
      dobController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  bool _employee = false;
  bool _freelancer = true;
  bool _business = false;

  bool get employee => _employee;
  bool get freelancer => _freelancer;
  bool get business => _business;

  void onEmployeeClick() {
    if (_employee == false) {
      _employee = true;
      _freelancer = false;
      _business = false;
      notifyListeners();
    }
  }

  void onFreelancerClick() {
    if (_freelancer == false) {
      _employee = false;
      _freelancer = true;
      _business = false;
      notifyListeners();
    }
  }

  void onBusinessClick() {
    if (_business == false) {
      _employee = false;
      _freelancer = false;
      _business = true;
      notifyListeners();
    }
  }

  // // for professionTextField
  // final TextEditingController professionController = TextEditingController();
  // String _profession = '';

  // onSubmittedProfession(value) {
  //   _profession = value;
  // }

  // String? validateProfession(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return "Profession Required";
  //   } else {
  //     return null;
  //   }
  // }

  // for monthlyIncomeTextField
  final TextEditingController monthlyIncomeController = TextEditingController();
  String _monthlyIncome = '';

  onSubmittedMonthlyIncome(value) {
    _monthlyIncome = value;
  }

  String? validateMonthlyIncome(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Monthly Income Required";
    } else {
      return null;
    }
  }

  // for monthlyEmiTextField
  final TextEditingController monthlyEmiController = TextEditingController();
  String _monthlyEmi = '';

  onSubmittedMonthlyEmi(value) {
    _monthlyEmi = value;
  }

  String? validateMonthlyEmi(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Monthly Emi Required";
    } else {
      return null;
    }
  }

  // for extraIncomeTextField
  final TextEditingController extraIncomeController = TextEditingController();
  String _extraIncome = '';

  onSubmittedExtraIncome(value) {
    _extraIncome = value;
  }

  String? validateExtraIncome(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Extra Income Required";
    } else {
      return null;
    }
  }

  // for downPaymentTextField
  final TextEditingController downPaymentController = TextEditingController();
  String _downPayment = '';

  onSubmittedDownPayment(value) {
    _downPayment = value;
  }

  String? validateDownPayment(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Down Payment Required";
    } else {
      return null;
    }
  }

  // incomeTaxButtom
  bool _incomeTax = true;

  bool get incomeTax => _incomeTax;

  onYesClickIncomeTax() {
    if (_incomeTax == false) {
      _incomeTax = true;
      notifyListeners();
    }
  }

  onNoClickIncomeTax() {
    if (_incomeTax == true) {
      _incomeTax = false;
      notifyListeners();
    }
  }

// loanButtom
  bool _loan = false;

  bool get loan => _loan;

  onYesClickLoan() {
    if (_loan == false) {
      _loan = true;
      notifyListeners();
    }
  }

  onNoClickLoan() {
    if (_loan == true) {
      _loan = false;
      notifyListeners();
    }
  }

// coBorrowerButtom
  bool _coBorrower = false;
  String? _coBorrowerIncome;
  String? _coBorrowerEMI;
  bool get coBorrower => _coBorrower;

  onYesClickCoBorrower(BuildContext context) async {
    if (_coBorrower == false) {
      final list = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => CustomDialog());

      if (list != null) {
        _coBorrowerIncome = list[0];
        _coBorrowerEMI = list[1];
        _coBorrower = true;
        notifyListeners();
      }
    }
  }

  onNoClickCoBorrower() {
    if (_coBorrower == true) {
      _coBorrowerIncome = null;
      _coBorrowerEMI = null;
      _coBorrower = false;
      notifyListeners();
    }
  }

  void resetAllData() {
    dobController.clear();
    monthlyIncomeController.clear();
    monthlyEmiController.clear();
    extraIncomeController.clear();
    downPaymentController.clear();
    _coBorrower = false;
    _incomeTax = false;
    _loan = false;
    _coBorrowerIncome = null;
    _coBorrowerEMI = null;
    notifyListeners();
  }
}
