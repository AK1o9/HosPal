import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hospal/constants/style.dart';
import 'package:hospal/widgets/text_poppins_widget.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
            child: Container(
      color: darkBlue,
      child: Column(
        children: [
          PoppinsTextWidget(text: 'WIP', size: 90, color: dark),
          PoppinsTextWidget(text: 'WIP', size: 90, color: dark),
          PoppinsTextWidget(text: 'WIP', size: 90, color: dark),
          PoppinsTextWidget(text: 'WIP', size: 90, color: dark),
          PoppinsTextWidget(text: 'WIP', size: 90, color: dark),
          PoppinsTextWidget(text: 'WIP', size: 90, color: dark),
          PoppinsTextWidget(text: 'WIP', size: 90, color: dark),
        ],
      ),
    )));
  }
}
