import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:property_box/components/custom_text_field.dart';
import 'package:property_box/route_generator.dart';

import '../../components/custom_title.dart';
import '../../theme/colors.dart';

class Project extends StatefulWidget {
  const Project({Key? key}) : super(key: key);

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.keyboard_backspace_rounded)),
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, RouteName.addProject);
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: CustomColors.lightBlue)),
                  child: const Text(
                    "Categories",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        letterSpacing: 0.4),
                  )),
            )
          ]),
          const SizedBox(height: 25),
          const CustomTextField(
            hint: "Search by company, project or location",
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 12),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomTitle(text: 'Villa'),
              MoreButton(onTap: () {})
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: CustomImage(onTap: () {
                Navigator.pushNamed(context, RouteName.projectExplorer);
              })),
              const SizedBox(width: 15),
              Expanded(child: CustomImage(onTap: () {
                Navigator.pushNamed(context, RouteName.projectExplorer);
              }))
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomTitle(text: 'Hi - rise Flats'),
              MoreButton(onTap: () {})
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: CustomImage(onTap: () {
                Navigator.pushNamed(context, RouteName.projectExplorer);
              })),
              const SizedBox(width: 15),
              Expanded(child: CustomImage(onTap: () {
                Navigator.pushNamed(context, RouteName.projectExplorer);
              }))
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomTitle(text: 'HMDA'),
              MoreButton(onTap: () {})
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: CustomImage(onTap: () {
                Navigator.pushNamed(context, RouteName.projectExplorer);
              })),
              const SizedBox(width: 15),
              Expanded(child: CustomImage(onTap: () {
                Navigator.pushNamed(context, RouteName.projectExplorer);
              }))
            ],
          ),
        ]),
      )),
    ));
  }
}

class CustomImage extends StatelessWidget {
  final double height;
  final void Function() onTap;
  const CustomImage({required this.onTap, this.height = 100, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Neumorphic(
        padding: const EdgeInsets.all(3),
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
            color: CustomColors.dark,
            shadowLightColor: Colors.white.withOpacity(0.3)),
        child: Container(
          height: height,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Image.asset("assets/project.png", fit: BoxFit.fill),
        ),
      ),
    );
  }
}

class MoreButton extends StatelessWidget {
  final void Function() onTap;
  const MoreButton({required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text('more',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 0.4,
              color: CustomColors.lightBlue)),
    );
  }
}
