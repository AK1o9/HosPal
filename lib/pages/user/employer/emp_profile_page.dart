// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../widgets/text_poppins_widget.dart';

class EmployerProfilePage extends StatefulWidget {
  const EmployerProfilePage({Key? key}) : super(key: key);

  @override
  State<EmployerProfilePage> createState() => _EmployerProfileState();
}

class _EmployerProfileState extends State<EmployerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: space18),
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          y20,
          PoppinsTextWidget(
              text: "Profile", size: 64, isBold: true, color: midOrange),
          Divider(
            height: space40,
          ),
        ],
      )),
    );
  }
}
