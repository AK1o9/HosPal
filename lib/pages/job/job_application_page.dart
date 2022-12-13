import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospal/widgets/text_poppins_widget.dart';
import 'package:hospal/widgets/textfield_widget.dart';
import 'package:path/path.dart';

import '../../constants/style.dart';

class JobApplicationPage extends StatefulWidget {
  final String? jobId;
  const JobApplicationPage({Key? key, this.jobId}) : super(key: key);

  @override
  State<JobApplicationPage> createState() => _JobApplicationPageState();
}

class _JobApplicationPageState extends State<JobApplicationPage> {
  String? fullName;
  String? email;
  String? phone;

  DateTime? startDate;
  double? desiredSalary;

  int currentStep = 0;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final introLetterController = TextEditingController();
  final additionalInfoController = TextEditingController();
  final startDateController = TextEditingController();
  final desiredSalaryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fullNameController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
    phoneController.addListener(() => setState(() {}));
    introLetterController.addListener(() => setState(() {}));
    additionalInfoController.addListener(() => setState(() {}));
    startDateController.addListener(() => setState(() {}));
    desiredSalaryController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    introLetterController.dispose();
    additionalInfoController.dispose();
    startDateController.dispose();
    desiredSalaryController.dispose();
    super.dispose();
  }

  void clearFields() {
    fullNameController.clear();
    emailController.clear();
    phoneController.clear();
    introLetterController.clear();
    additionalInfoController.clear();
    startDateController.clear();
    desiredSalaryController.clear();
  }

  List<Step> getSteps() => [
        Step(
            isActive: currentStep >= 0,
            title: PoppinsTextWidget(
              text: 'Details',
              size: fontLabel,
              color: dark,
            ),
            content: Column(
              children: [
                TextfieldWidget(
                    labelText: 'Full Name', controller: fullNameController),
                y10,
                TextfieldWidget(
                    labelText: 'E-mail address', controller: emailController),
                y10,
                TextfieldWidget(
                    labelText: 'Contact Number', controller: phoneController),
                y10,
                TextfieldWidget(
                    labelText: 'Desired Start Date',
                    controller: startDateController),
                y10,
                TextfieldWidget(
                    labelText: 'Desired Salary or Pay',
                    controller: desiredSalaryController),
              ],
            )),
        Step(
            isActive: currentStep >= 1,
            title: PoppinsTextWidget(
              text: 'Files',
              size: fontLabel,
              color: dark,
            ),
            content: Column(
              children: [
                PoppinsTextWidget(
                    text:
                        'You may either UPLOAD your files here or IMPORT them from your file storage:\nSuch files may include: CVs, Cover Letters and Internship Letters.',
                    size: fontLabel,
                    color: dark),
                y10,
                Container(),
              ],
            )),
        Step(
            isActive: currentStep >= 2,
            title: PoppinsTextWidget(
              text: 'Additional Info',
              size: fontLabel,
              color: dark,
            ),
            content: Column(
              children: [
                TextfieldWidget(
                  labelText: 'Additional Information (Optional)',
                  controller: additionalInfoController,
                  textInputType: TextInputType.multiline,
                ),
              ],
            )),
      ];

  Widget buildStepper() {
    return Stepper(
      type: StepperType.horizontal,
      steps: getSteps(),
      currentStep: currentStep,
      onStepCancel: currentStep == 0
          ? null
          : () {
              setState(() {
                currentStep -= 1;
              });
            },
      onStepContinue: () {
        final isLastStep = currentStep == getSteps().length - 1;
        if (isLastStep) {
          //Job Application Completed
          //...
          if (kDebugMode) {
            print('Job Application submitted successfully!');
          }
        } else {
          setState(() {
            currentStep += 1;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Job Post ID: ${widget.jobId}");
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: pad20,
          color: light,
          child: Column(children: [
            y10,
            PoppinsTextWidget(
              text: 'Submit job application',
              size: fontTitle,
              color: dark,
            ),
            y20,
            buildStepper(),
          ]),
        ),
      ),
    );
  }
}
