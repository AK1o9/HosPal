// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hospal/widgets/custom_button_widget.dart';

import '../../../api/user_auth.dart';
import '../../../constants/style.dart';
import '../../../widgets/text_poppins_widget.dart';

class EmployerProfilePage extends StatefulWidget {
  const EmployerProfilePage({Key? key}) : super(key: key);

  @override
  State<EmployerProfilePage> createState() => _EmployerProfileState();
}

class _EmployerProfileState extends State<EmployerProfilePage> {
  Future<void> signOut() async {
    await UserAuth().signOut();
  }

  Widget _signOut() {
    return CustomButtonWidget(
      label: 'Log out',
      onTap: signOut,
      color: midOrange,
      icon: Icons.logout_rounded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: space18),
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          y20,
          Padding(
            padding: EdgeInsets.only(left: space18),
            child: PoppinsTextWidget(
                text: "Profile", size: 64, isBold: true, color: midOrange),
          ),
          Divider(
            height: space40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: space20),
            child: Column(
              children: [
                _signOut(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
