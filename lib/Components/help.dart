import 'dart:io';

import 'package:duds/Components/home.dart';
import 'package:duds/Components/orderdetails.dart';
import 'package:flutter/material.dart';
import 'package:duds/Components/uploadpreview_screen.dart';


import 'package:duds/Components/rooms.dart';
void main() {
  runApp(HelpPage());
}

class HelpPage extends StatefulWidget {

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  late int currentIndex;
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
    backgroundColor: const Color.fromARGB(255, 255, 100, 64),
      title: const Text('FAQ'),
        leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
        Navigator.pushNamed(context, '/homebar');// Kembali ke halaman sebelumnya
    },
  )),
    body:const Steps(), 
  );

}
class Step {
  Step(
    this.title,
    this.body,
    [this.isExpanded = false]
  );
  String title;
  String body;
  bool isExpanded;
}

List<Step> getSteps() {
  return [
    Step('Step 0: Install Flutter', 'Install Flutter development tools according to the official documentation.'),
    Step('Step 1: Create a project', 'Open your terminal, run `flutter create <project_name>` to create a new project.'),
    Step('Step 2: Run the app', 'Change your terminal directory to the project directory, enter `flutter run`.'),
   Step('Step 2: Run the app', 'Change your terminal directory to the project directory, enter `flutter run`.'),
  ];
}

class Steps extends StatefulWidget {
  const Steps({Key? key}) : super(key: key);
  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  final List<Step> _steps = getSteps();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _renderSteps(),
      ),
    );
  }
  Widget _renderSteps() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _steps[index].isExpanded = !isExpanded;
        });
      },
      children: _steps.map<ExpansionPanel>((Step step) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(step.title),
            );
          },
          body: ListTile(
            title: Text(step.body),
          ),
          isExpanded: step.isExpanded,
        );
      }).toList(),
    );
  }
}