import 'package:flutter/material.dart';
import 'package:property_box/provider/property_buying_score_provider.dart';
import 'package:provider/provider.dart';

import '../components/custom_button.dart';
import '../components/custom_label.dart';
import '../components/custom_text_field.dart';
import '../components/custom_title.dart';
import '../theme/colors.dart';

class PropertyBuyingScore extends StatefulWidget {
  const PropertyBuyingScore({Key? key}) : super(key: key);

  @override
  State<PropertyBuyingScore> createState() => _PropertyBuyingScoreState();
}

class _PropertyBuyingScoreState extends State<PropertyBuyingScore> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PropertyBuyingScoreProvider(),
        builder: (context, child) {
          final _pr =
              Provider.of<PropertyBuyingScoreProvider>(context, listen: false);
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(right: 25, bottom: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Flexible(
                  child: CustomButton(
                    text: 'Reset',
                    onClick: _pr.resetAllData,
                    color: CustomColors.dark,
                    width: 89,
                    height: 40,
                    shadowColor: Colors.white.withOpacity(0.3),
                  ).use(),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: CustomButton(
                    text: 'Calculate',
                    onClick: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    width: 121,
                    shadowColor: Colors.white.withOpacity(0.7),
                    color: CustomColors.lightBlue,
                    height: 40,
                  ).use(),
                ),
              ]),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Flexible(
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: const Icon(
                                      Icons.keyboard_backspace_rounded)),
                              const SizedBox(width: 20),
                              const Flexible(
                                  child: CustomTitle(
                                      text: 'Property Buying score'))
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Flexible(
                          child: Row(
                            children: [
                              const Expanded(child: CustomLabel(text: 'DOB :')),
                              Expanded(
                                child: CustomTextField(
                                    controller: _pr.dobController,
                                    readOnly: true,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    validator: _pr.validateDate),
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                  onTap: () {
                                    _pr.selectDate(context);
                                  },
                                  child: const Icon(Icons.calendar_month))
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Flexible(
                            child: CustomLabel(text: 'Profession :')),

                        Flexible(
                          child: Consumer<PropertyBuyingScoreProvider>(
                            builder: (context, value, child) => Row(
                              children: [
                                TextButton(
                                    onPressed: value.onEmployeeClick,
                                    child: Text('Employee',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: (value.employee)
                                              ? HexColor('131415')
                                              : Colors.white.withOpacity(0.8),
                                        )),
                                    style: TextButton.styleFrom(
                                      backgroundColor: (value.employee)
                                          ? CustomColors.lightBlue
                                          : Colors.white.withOpacity(0.1),
                                      minimumSize: const Size(85, 30),
                                    )),
                                const SizedBox(width: 5),
                                TextButton(
                                    onPressed: value.onFreelancerClick,
                                    child: Text('Freelancer',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: (value.freelancer)
                                              ? HexColor('131415')
                                              : Colors.white.withOpacity(0.8),
                                        )),
                                    style: TextButton.styleFrom(
                                      backgroundColor: (value.freelancer)
                                          ? CustomColors.lightBlue
                                          : Colors.white.withOpacity(0.1),
                                      minimumSize: const Size(90, 30),
                                    )),
                                const SizedBox(width: 5),
                                TextButton(
                                    onPressed: value.onBusinessClick,
                                    child: Text('Business',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: (value.business)
                                              ? HexColor('131415')
                                              : Colors.white.withOpacity(0.8),
                                        )),
                                    style: TextButton.styleFrom(
                                      backgroundColor: (value.business)
                                          ? CustomColors.lightBlue
                                          : Colors.white.withOpacity(0.1),
                                      minimumSize: const Size(85, 30),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        // const SizedBox(height: 5),
                        // Flexible(
                        //   child: Row(
                        //     children: [
                        //       const Expanded(
                        //           child: CustomLabel(text: 'Profession :')),
                        //       Expanded(
                        //           child: CustomTextField(
                        //         controller: _pr.professionController,
                        //         onChanged: _pr.onSubmittedProfession,
                        //         validator: _pr.validateProfession,
                        //       )),
                        //       const SizedBox(width: 28)
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(height: 5),
                        Flexible(
                          child: Row(
                            children: [
                              const CustomLabel(text: 'Monthly Income :'),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: CustomTextField(
                                controller: _pr.monthlyIncomeController,
                                onChanged: _pr.onSubmittedMonthlyIncome,
                                validator: _pr.validateMonthlyIncome,
                                keyboardType: TextInputType.number,
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              )),
                              const SizedBox(width: 10),
                              const CustomLabel(text: 'INR')
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Flexible(
                          child: Row(
                            children: [
                              const CustomLabel(
                                  text: 'Monthly EMI(Existing) :'),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: CustomTextField(
                                controller: _pr.monthlyEmiController,
                                onChanged: _pr.onSubmittedMonthlyEmi,
                                validator: _pr.validateMonthlyEmi,
                                keyboardType: TextInputType.number,
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              )),
                              const SizedBox(width: 10),
                              const CustomLabel(text: 'INR')
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Flexible(
                          child: Row(
                            children: [
                              const CustomLabel(
                                  text: 'Extra income per month :'),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: CustomTextField(
                                controller: _pr.extraIncomeController,
                                onChanged: _pr.onSubmittedExtraIncome,
                                validator: _pr.validateExtraIncome,
                                keyboardType: TextInputType.number,
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              )),
                              const SizedBox(width: 10),
                              const CustomLabel(text: 'INR')
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Flexible(
                          child: Row(
                            children: [
                              const CustomLabel(text: 'Down payment :'),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: CustomTextField(
                                controller: _pr.downPaymentController,
                                onChanged: _pr.onSubmittedDownPayment,
                                validator: _pr.validateDownPayment,
                                keyboardType: TextInputType.number,
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              )),
                              const SizedBox(width: 10),
                              const CustomLabel(text: 'INR')
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Divider(color: CustomColors.lightBlue, thickness: 2),
                        const SizedBox(height: 10),
                        Consumer<PropertyBuyingScoreProvider>(
                          builder: (context, value, child) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Flexible(
                                      child: CustomLabel(
                                          text: 'Do you have co-borrower :'),
                                    ),
                                    Row(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              value.onYesClickCoBorrower(
                                                  context);
                                            },
                                            child: Text('Yes',
                                                style: TextStyle(
                                                  color: (value.coBorrower)
                                                      ? HexColor('131415')
                                                      : Colors.white
                                                          .withOpacity(0.8),
                                                )),
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  (value.coBorrower)
                                                      ? CustomColors.lightBlue
                                                      : Colors.white
                                                          .withOpacity(0.1),
                                              minimumSize: const Size(41, 30),
                                            )),
                                        TextButton(
                                            onPressed:
                                                value.onNoClickCoBorrower,
                                            child: Text('No',
                                                style: TextStyle(
                                                  color: (value.coBorrower)
                                                      ? Colors.white
                                                          .withOpacity(0.8)
                                                      : HexColor('131415'),
                                                )),
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  (value.coBorrower)
                                                      ? Colors.white
                                                          .withOpacity(0.1)
                                                      : CustomColors.lightBlue,
                                              minimumSize: const Size(37, 30),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Divider(
                                  color: CustomColors.lightBlue, thickness: 2),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Flexible(
                                      child: CustomLabel(
                                          text:
                                              'Income tax filed for last 3 years :'),
                                    ),
                                    Row(
                                      children: [
                                        TextButton(
                                            onPressed:
                                                value.onYesClickIncomeTax,
                                            child: Text('Yes',
                                                style: TextStyle(
                                                  color: (value.incomeTax)
                                                      ? HexColor('131415')
                                                      : Colors.white
                                                          .withOpacity(0.8),
                                                )),
                                            style: TextButton.styleFrom(
                                              backgroundColor: (value.incomeTax)
                                                  ? CustomColors.lightBlue
                                                  : Colors.white
                                                      .withOpacity(0.1),
                                              minimumSize: const Size(41, 30),
                                            )),
                                        TextButton(
                                            onPressed: value.onNoClickIncomeTax,
                                            child: Text('No',
                                                style: TextStyle(
                                                  color: (value.incomeTax)
                                                      ? Colors.white
                                                          .withOpacity(0.8)
                                                      : HexColor('131415'),
                                                )),
                                            style: TextButton.styleFrom(
                                              backgroundColor: (value.incomeTax)
                                                  ? Colors.white
                                                      .withOpacity(0.1)
                                                  : CustomColors.lightBlue,
                                              minimumSize: const Size(37, 30),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Flexible(
                                      child: CustomLabel(
                                          text:
                                              'Any loan/credit card defaults :'),
                                    ),
                                    Row(
                                      children: [
                                        TextButton(
                                            onPressed: value.onYesClickLoan,
                                            child: Text('Yes',
                                                style: TextStyle(
                                                  color: (value.loan)
                                                      ? HexColor('131415')
                                                      : Colors.white
                                                          .withOpacity(0.8),
                                                )),
                                            style: TextButton.styleFrom(
                                              backgroundColor: (value.loan)
                                                  ? CustomColors.lightBlue
                                                  : Colors.white
                                                      .withOpacity(0.1),
                                              minimumSize: const Size(41, 30),
                                            )),
                                        TextButton(
                                            onPressed: value.onNoClickLoan,
                                            child: Text('No',
                                                style: TextStyle(
                                                  color: (value.loan)
                                                      ? Colors.white
                                                          .withOpacity(0.8)
                                                      : HexColor('131415'),
                                                )),
                                            style: TextButton.styleFrom(
                                              backgroundColor: (value.loan)
                                                  ? Colors.white
                                                      .withOpacity(0.1)
                                                  : CustomColors.lightBlue,
                                              minimumSize: const Size(37, 30),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          );
        });
  }
}

class CustomDialog extends StatelessWidget {
  CustomDialog({Key? key}) : super(key: key);

  String? monthlyIncome;
  String? existingEMI;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CustomColors.dark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Text('Co-borrower monthly income : '),
                  Expanded(child: CustomTextField(
                    onChanged: (value) {
                      monthlyIncome = value;
                    },
                  )),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("Co-borrower existing EMI's : "),
                  Expanded(child: CustomTextField(
                    onChanged: (value) {
                      existingEMI = value;
                    },
                  )),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      child: const Text('Submit',
                          style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        if (monthlyIncome != null &&
                            monthlyIncome!.trim().isNotEmpty &&
                            existingEMI != null &&
                            existingEMI!.trim().isNotEmpty) {
                          Navigator.pop(context,
                              [monthlyIncome!.trim(), existingEMI!.trim()]);
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: CustomColors.lightBlue)),
                  const SizedBox(width: 20),
                  TextButton(
                      child: Text('Cancel',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.1))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
