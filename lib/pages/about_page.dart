import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hospal/constants/style.dart';
import 'package:hospal/widgets/custom_button_widget.dart';
import 'package:hospal/widgets/text_poppins_widget.dart';

import '../widgets/text_nunito_widget.dart';

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
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: space20, horizontal: space10),
                    child: Image.asset(
                      'assets/images/hospal_logo.png',
                      // width: 380,
                    ),
                  ),
                  PoppinsTextWidget(
                    text: 'Frequently Asked Questions\n(F.A.Q)',
                    size: fontSubtitle,
                    color: light,
                    isBold: true,
                    isCenter: true,
                  ),
                  y10,
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: bRadius20,
                        color: Color.fromRGBO(255, 255, 255, 0.8)),
                    padding: EdgeInsets.symmetric(
                        vertical: space20, horizontal: space10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PoppinsTextWidget(
                            text: 'What is HosPal?',
                            size: fontTitle,
                            isBold: true,
                            color: dark),
                        y4,
                        PoppinsTextWidget(
                            text:
                                'HosPal is a mobile application that helps people in the medical industry (such as doctors, nurses, surgeons and even students) to search for jobs in the medical field.',
                            size: fontLabel,
                            // isBold: true,
                            color: dark),
                        y8,
                        PoppinsTextWidget(
                            text:
                                'To use this app, people must register as either Jobseekers or Employers.',
                            size: fontLabel,
                            // isBold: true,
                            color: dark),
                        y30,
                        PoppinsTextWidget(
                            text: 'Jobseeker',
                            size: fontTitle,
                            isBold: true,
                            color: midBlue),
                        Divider(
                          color: midBlue,
                          thickness: 1.5,
                        ),
                        PoppinsTextWidget(
                            text:
                                'A jobseeker is a term used for people who are looking for jobs or to be hired.\nBy registering as a Jobseeker, you can search and apply for medical jobs through the app.\n\nYou can also do the following: ',
                            size: fontLabel,
                            // isBold: true,
                            color: dark),
                        PoppinsTextWidget(
                            text:
                                '\t- Save your files in a cloud File Storage for free.\n(For up to 1GB in storage space)\n\t- Attach or share files (from your File Storage) to your Job Applications so that the Employer can access/review these files.\n(Examples: CV/resume, letters and other)\n\t- Monitor the status and progress of your Job Applications.\n\t- Create/edit your own public profile page.',
                            size: fontLabel,
                            // isBold: true,
                            color: dark),
                        y30,
                        PoppinsTextWidget(
                            text: 'Employer',
                            size: fontTitle,
                            isBold: true,
                            color: midOrange),
                        Divider(
                          thickness: 1.5,
                          color: midOrange,
                        ),
                        PoppinsTextWidget(
                            text:
                                'An employer is a person who is looking to employ or hire others to work for them or their company. Registering as an Employer allows you to create job posts. These posts are available for all Jobseekers to check and apply for.\n\nEmployers can also:',
                            size: fontLabel,
                            // isBold: true,
                            color: dark),

                        PoppinsTextWidget(
                            text:
                                '\t- Receive, check and update the status of job applications from Jobseekers so that a suitable candidate is chosen for a job role every time!\n\t- Create/edit their own public profile page.',
                            size: fontLabel,
                            // isBold: true,
                            color: dark),
                        // Text(
                        //   'An employer is a person who is looking to employ or hire others to work for them or their company. Registering as an Employer allows you to create job posts. These posts are available for all Jobseekers to check and apply for.\n\nEmployers can also:',
                        // ),
                        // Text(
                        //   '\t- Receive, check and update the status of job applications from Jobseekers so that a suitable candidate is chosen for a job role every time!\n\t- Create/edit their own public profile page.',
                        // ),
                      ],
                    ),
                  ),
                  y20,
                  CustomButtonWidget(
                    label: 'Back',
                    isFontBold: true,
                    onTap: () => Navigator.of(context).pop(),
                    backgroundColor: darkOrange,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    )));
  }
}
