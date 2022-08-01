import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_box/components/custom_neumorphic_button.dart';
import 'package:property_box/components/custom_text_field.dart';
import 'package:property_box/components/neumorphic_image_buttom.dart';
import 'package:property_box/provider/firestore_data_provider.dart';
import 'package:property_box/provider/interested_provider.dart';
import 'package:property_box/services/loction_service.dart';
import 'package:property_box/ui/sign_up.dart';
import 'package:provider/provider.dart';

import '../components/custom_selector.dart';
import '../components/custom_title.dart';
import '../components/home_container.dart';
import '../theme/colors.dart';

class Interested extends StatefulWidget {
  final Map<String, dynamic> data;
  const Interested({required this.data, Key? key}) : super(key: key);

  @override
  State<Interested> createState() => _InterestedState();
}

class _InterestedState extends State<Interested> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
        future: FirestoreDataProvider().getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: CustomTitle(text: "Something Went Wrong"));
          } else if (snapshot.hasData) {
            return ChangeNotifierProvider(
              create: (context) => InterestedProvider(snapshot.data),
              builder: (context, child) => Scaffold(
                backgroundColor: CustomColors.dark,
                body: SafeArea(
                  child: ModalProgressHUD(
                    inAsyncCall: isLoading,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: Consumer<InterestedProvider>(
                            builder: (context, value, child) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      NeumorphicImageButton(
                                          image: 'assets/close.png',
                                          onTap: () => Navigator.pop(context)),
                                    ]),
                                const SizedBox(height: 15),
                                CustomRow(
                                    label: 'Name :',
                                    child: CustomTextField(
                                        controller: value.nameController,
                                        onChanged: value.onNameSubmitted,
                                        validator: value.validateName,
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10))),
                                const SizedBox(height: 10),
                                CustomRow(
                                  label: 'Mobile :',
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(children: [
                                      const Text(
                                        "(+91)",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Expanded(
                                        child: CustomTextField(
                                            controller: value.mobileController,
                                            onChanged: value.onMobileSubmitted,
                                            validator: value.validateMobile,
                                            fillColor:
                                                Colors.white.withOpacity(0.01),
                                            keyboardType: TextInputType.phone,
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10)),
                                      ),
                                    ]),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomRow(
                                    label: 'Location :',
                                    child: CustomTextField(
                                        controller: value.locationController,
                                        validator: value.validateLocation,
                                        readOnly: true,
                                        onTap: () async {
                                          final result = await showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) =>
                                                  const CustomMapDialog());

                                          if (result == 1) {
                                            setState(() => isLoading = true);
                                            final res = await GetUserLocation
                                                .getCurrentLocation();
                                            setState(() => isLoading = false);
                                            if (res != null && res.isNotEmpty) {
                                              value.locationController.text =
                                                  res;
                                            }
                                          }
                                          if (result == 2) {
                                            final res = await GetUserLocation
                                                .getMapLocation(context);
                                            if (res != null && res.isNotEmpty) {
                                              value.locationController.text =
                                                  res;
                                            }
                                          }
                                        },
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10))),
                                const SizedBox(height: 10),
                                CustomRow(
                                    label: 'Buying time :',
                                    child: CustomSelector(
                                            color:
                                                Colors.white.withOpacity(0.05),
                                            dropDownItems: value.buyingDropDown,
                                            isDense: true,
                                            onChanged: value.onChangedBuying,
                                            chosenValue:
                                                value.buyingChosenValue)
                                        .use()),
                                const SizedBox(height: 10),
                                CustomRow(
                                    label: 'Preference time for call :',
                                    child: CustomSelector(
                                            color:
                                                Colors.white.withOpacity(0.05),
                                            dropDownItems:
                                                value.preferenceTimeDropDown,
                                            isDense: true,
                                            onChanged:
                                                value.onChangedPreferenceTime,
                                            chosenValue:
                                                value.preferenceTimeChosenValue)
                                        .use()),
                                const SizedBox(height: 20),
                                const Text(
                                  'Any Comments :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      letterSpacing: -0.15,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  maxLines: 4,
                                  controller: value.commentsController,
                                  onChanged: value.onCommentsSubmitted,
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomNeumorphicButtom(
                                        onTap: () {
                                          Provider.of<InterestedProvider>(
                                                  context,
                                                  listen: false)
                                              .resetData();
                                        },
                                        borderRadius: 30,
                                        buttonText: 'Reset',
                                        buttonColor: CustomColors.dark,
                                        textColor:
                                            Colors.white.withOpacity(0.54),
                                        shadowColor:
                                            Colors.white.withOpacity(0.4)),
                                    const SizedBox(width: 10),
                                    CustomNeumorphicButtom(
                                        onTap: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            final data =
                                                Provider.of<InterestedProvider>(
                                                        context,
                                                        listen: false)
                                                    .getAllData();
                                            await EasyLoading.show(
                                                maskType:
                                                    EasyLoadingMaskType.black,
                                                indicator: const Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text('Please Wait...'),
                                                ));
                                            await FirestoreDataProvider()
                                                .saveLead(
                                                    widget.data['plotOwnerUid'],
                                                    data..addAll(widget.data));
                                            EasyLoading.showSuccess(
                                                "Lead Created Successfully",
                                                duration:
                                                    const Duration(seconds: 3));
                                            Navigator.pop(context);
                                          }
                                        },
                                        borderRadius: 30,
                                        buttonText: 'Submit',
                                        buttonColor: CustomColors.lightBlue,
                                        shadowColor:
                                            Colors.white.withOpacity(0.4))
                                  ],
                                ),
                                const SizedBox(height: 30),
                                HomeContainer(
                                    isFirstText: false,
                                    isSecondText: true,
                                    text2:
                                        'Hire property box authorized agent our agent will work with you to get best property and close the deal.',
                                    image: "assets/refer.png",
                                    isGradient: true,
                                    gradient: LinearGradient(colors: [
                                      const Color(0xFF59FFFF),
                                      const Color(0xFFB4E4FF).withOpacity(0.20)
                                    ]),
                                    textColor: const Color(0xFF1B1B1B)
                                        .withOpacity(0.87),
                                    buttonWidth: 112,
                                    buttonText: "Hire Agent",
                                    buttonTextColor: Colors.white,
                                    isNeu: false,
                                    buttonColor: const Color(0xFF1B1B1B),
                                    onButtonClick: () {}),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class CustomRow extends StatelessWidget {
  final String label;
  final Widget child;
  const CustomRow({required this.label, required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: -0.15,
                color: Colors.white),
          ),
        ),
        Expanded(
          flex: 3,
          child: child,
        ),
      ],
    );
  }
}
