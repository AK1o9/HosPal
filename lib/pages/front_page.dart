import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospal/constants/style.dart';
import 'package:hospal/pages/user/employer/emp_login_page.dart';
import 'package:hospal/pages/user/employer/emp_auth.dart';
import 'package:hospal/pages/user/jobseeker/js_login_page.dart';
import 'package:hospal/pages/user/jobseeker/js_auth.dart';
import 'package:hospal/pages/user/jobseeker/js_nav_bar.dart';
import 'package:hospal/widgets/text_nunito_widget.dart';

import '../widgets/custom_button_widget.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: softBlue,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(space40),
            child: Container(
              padding: pad20,
              width: 400,
              height: 700,
              decoration: BoxDecoration(borderRadius: bRadius20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  y20,
                  y20,

                  // HosPal Logo
                  // PoppinsTextWidget(
                  //   text: 'HosPal',
                  //   color: darkBlue,
                  //   size: 64,
                  //   isBold: true,
                  // ),
                  // Center(
                  //   child: Image.asset(
                  //     'hospal_logo.png',
                  //     scale: 0.2,
                  //   ),
                  // ),
                  y20,
                  y20,

                  // Welcome Message
                  NunitoTextWidget(
                      text: "Welcome, let's get started!",
                      size: fontTitle,
                      isBold: true,
                      color: dark),
                  SizedBox(
                    height: space40,
                  ),

                  // Login as
                  NunitoTextWidget(
                      text: "Login as a:", size: fontSubtitle, color: dark),
                  y20,
                  CustomButtonWidget(
                      label: 'Jobseeker',
                      fontSize: fontLabel,
                      color: midBlue,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const JobseekerAuth()));
                      }),
                  y10,
                  NunitoTextWidget(text: "Or", size: fontHeader, color: dark),
                  y10,
                  CustomButtonWidget(
                      label: 'Employer',
                      fontSize: fontLabel,
                      color: midOrange,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const EmployerAuth()));
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
