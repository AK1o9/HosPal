import 'package:flutter/material.dart';
import 'package:hospal/constants/style.dart';
import 'package:hospal/pages/user/employer/emp_home_page.dart';
import 'package:hospal/pages/user/employer/emp_nav_bar.dart';
import 'package:hospal/pages/user/jobseeker/js_home_page.dart';
import 'package:hospal/pages/user/jobseeker/js_nav_bar.dart';
import 'package:hospal/widgets/button_widget.dart';
import 'package:hospal/widgets/text_nunito_widget.dart';

import '../widgets/custom_button_widget.dart';
import '../widgets/text_poppins_widget.dart';

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
        body:
            // Container(
            //   padding: pad20,
            //   child: Row(children: [
            //     Expanded(
            //       child: ButtonWidget(
            //           label: 'Jobseeker',
            //           fontSize: 72,
            //           onTap: () {
            //             Navigator.of(context).push(MaterialPageRoute(
            //                 builder: (context) => const JobseekerHomePage()));
            //           }),
            //     ),
            //     x20,
            //     Expanded(
            //       child: ButtonWidget(
            //           label: 'Employer',
            //           fontSize: 72,
            //           onTap: () {
            //             Navigator.of(context).push(MaterialPageRoute(
            //                 builder: (context) => const EmployerHomePage()));
            //           }),
            //     )
            //   ]),
            // ),
            Center(
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
                  // // HosPal Logo
                  // PoppinsTextWidget(
                  //   text: 'HosPal',
                  //   color: darkBlue,
                  //   size: 64,
                  //   isBold: true,
                  // ),
                  Center(
                    child: Image.asset('hospal_logo.png'),
                  ),
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
                            builder: (context) => const JobseekerNavBar()));
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
                            builder: (context) => const EmployerNavBar()));
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
