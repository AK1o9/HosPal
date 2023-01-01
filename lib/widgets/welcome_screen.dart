import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hospal/constants/style.dart';
import 'package:hospal/widgets/text_nunito_widget.dart';
import 'package:hospal/widgets/text_poppins_widget.dart';

import '../pages/about_page.dart';
import '../pages/user/employer/emp_auth.dart';
import '../pages/user/jobseeker/js_auth.dart';
import 'custom_button_widget.dart';

class WelcomeScreenWidget extends StatelessWidget {
  const WelcomeScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(bottom: 0),
      color: darkBlue,
      child: Stack(
        children: [
          Positioned.fill(
              child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    'assets/images/hospital_bed.jpg',
                    fit: BoxFit.cover,
                  ))),
          Center(
            child: Padding(
              padding: pad20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/hospal_logo.png',
                    // width: 380,
                  ),
                  y30,
                  NunitoTextWidget(
                      text: 'Welcome.', size: fontTitle, color: light),
                  y10,
                  NunitoTextWidget(
                      text: 'Sign in or register to get started!',
                      size: fontHeader,
                      color: light),
                  y30,
                  CustomButtonWidget(
                      label: 'Jobseeker',
                      fontSize: fontLabel,
                      backgroundColor: darkBlue,
                      onTap: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const JobseekerAuth()));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const JobseekerAuth())); //TODO do replace instead?
                      }),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: space12, vertical: space10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: light,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: space18),
                          child: NunitoTextWidget(
                              text: "OR", size: fontLabel, color: light),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: light,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomButtonWidget(
                      label: 'Employer',
                      fontSize: fontLabel,
                      backgroundColor: darkOrange,
                      onTap: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const EmployerAuth()));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const EmployerAuth()));
                      }),
                  y20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NunitoTextWidget(
                          text: 'First time?', size: fontLabel, color: light),
                      x4,
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AboutPage()));
                        },
                        child: NunitoTextWidget(
                            text: 'Tap here to learn more.',
                            size: fontLabel,
                            color: Colors.lightBlue.shade200),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
