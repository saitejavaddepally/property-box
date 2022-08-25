import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:property_box/provider/firestore_data_provider.dart';

import '../../components/custom_container.dart';
import '../../components/custom_title.dart';
import '../../theme/colors.dart';
import '../project_explorer.dart';

class Project extends StatefulWidget {
  const Project({Key? key}) : super(key: key);

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  bool isProjectsLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> getAndReturnProjects() async {
    List allProjects = await FirestoreDataProvider.getAllProjects();
    List<dynamic> villas = [];
    List<dynamic> hiRise = [];
    List<dynamic> hmda = [];

    for (int i = 0; i < allProjects.length; i++) {
      if (allProjects[i]['projectCategory'] == 'hmda') {
        hmda.add(allProjects[i]);
      } else if (allProjects[i]['projectCategory'] == 'villas') {
        villas.add(allProjects[i]);
      } else {
        hiRise.add(allProjects[i]);
      }
    }

    return {
      "hmda": hmda,
      "villas": villas,
      "hiRise": hiRise,
    };
  }

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
                //Navigator.pushNamed(context, RouteName.addProject);
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
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
          FutureBuilder(
              future: getAndReturnProjects(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const SpinKitCircle(
                      color: Colors.white,
                      size: 30,
                    ),
                  );
                }
                Map<String, dynamic> data =
                    snapshot.data as Map<String, dynamic>;

                List hmdaProjects = data['hmda'];
                List villaProjects = data['villas'];
                List hiRiseProjects = data['hiRise'];

                return Column(
                  children: [
                    const SizedBox(height: 25),
                    TextField(
                      cursorColor: Colors.white.withOpacity(0.1),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: "Search by company, project or location",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.3)),
                        fillColor: Colors.white.withOpacity(0.1),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTitle(text: 'hmda'.toUpperCase()),
                        MoreButton(onTap: () {})
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomGridView(projects: hmdaProjects),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTitle(text: 'hiRise'.toUpperCase()),
                        MoreButton(onTap: () {})
                      ],
                    ),
                    CustomGridView(projects: hiRiseProjects),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTitle(text: 'Villas'.toUpperCase()),
                        MoreButton(onTap: () {})
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomGridView(projects: villaProjects),
                  ],
                );
              }),
        ]),
      )),
    ));
  }
}

class CustomImage extends StatelessWidget {
  final void Function() onTap;
  final String image;
  final double height;

  const CustomImage(
      {required this.onTap, required this.image, this.height = 120, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        child: SizedBox(
          height: height,
          child: Image.network(image, fit: BoxFit.fill),
          width: MediaQuery.of(context).size.width,
        ),
        width: 100,
      ).use(),
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

class CustomGridView extends StatelessWidget {
  final List projects;

  const CustomGridView({Key? key, required this.projects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      shrinkWrap: true,
      childAspectRatio: 3 / 2.2,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        for (int i = 0; i < projects.length; i++)
          CustomImage(
            image: projects[i]['images'][0],
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProjectExplorer(projectDetails: projects[i])));
            },
          ),
      ],
    );
  }
}
