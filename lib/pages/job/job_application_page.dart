import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospal/pages/user/employer/emp_home_page.dart';
import 'package:hospal/widgets/custom_button_widget.dart';
import 'package:hospal/widgets/text_nunito_widget.dart';
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

  String? errorMessage;
  PlatformFile? newFileToUpload;
  bool isCompleted = false;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final introLetterController = TextEditingController();
  final additionalInfoController = TextEditingController();
  final startDateController = TextEditingController();
  final desiredSalaryController = TextEditingController();

  late Map<String, String> filesToUpload; //TODO: remove if unused. (Max: 4)

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

  void saveJobApplication() {
    //TODO
  }

  Widget _errorMessage() => Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: space20),
          child: Container(
            padding: pad12,
            decoration: BoxDecoration(
                borderRadius: bRadius18, color: Colors.red.shade100),
            child: NunitoTextWidget(
                text: errorMessage!,
                size: fontLabel,
                isBold: true,
                color: Colors.red.shade700),
          ),
        ),
      );

  Widget buildCompleted() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.cloud_done_rounded,
          color: midBlue,
          size: 120,
        ),
        NunitoTextWidget(
            text: "Success!\nYou're Application was sent.",
            size: fontSubtitle,
            isBold: true,
            isCenter: true,
            color: midBlue),
        y10,
        NunitoTextWidget(
            text:
                "You can monitor your progress\nthrough the 'My Applications' Tab.",
            size: fontLabel,
            isBold: true,
            isCenter: true,
            color: grey),
        Padding(
          padding: pad20,
          child: CustomButtonWidget(
              label: 'Return to Job Post',
              isFontBold: true,
              backgroundColor: darkBlue,
              onTap: (() => Navigator.of(super.context).pop())),
        )
      ],
    );
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: const Text('Details'),
            content: Column(
              children: [
                y20,
                TextfieldWidget(
                  labelText: 'Full Name',
                  controller: fullNameController,
                  colorTheme: blueTheme,
                ),
                y20,
                TextfieldWidget(
                  labelText: 'E-mail address',
                  controller: emailController,
                  colorTheme: blueTheme,
                  textInputType: TextInputType.emailAddress,
                ),
                y20,
                TextfieldWidget(
                  labelText: 'Contact Number',
                  controller: phoneController,
                  colorTheme: blueTheme,
                  textInputType: TextInputType.phone,
                ),
                Divider(height: space40),
                TextfieldWidget(
                  labelText: 'Desired Start Date',
                  controller: startDateController,
                  colorTheme: blueTheme,
                  textInputType: TextInputType.datetime,
                ),
                y8,
                Align(
                  alignment: Alignment.centerLeft,
                  child: NunitoTextWidget(
                      text:
                          'Examples:\n\t- 1-1-2024\n\t- 1 Jan 2024\n\t- 1/1/2024',
                      size: fontBody,
                      color: grey),
                ),
                y20,
                TextfieldWidget(
                  labelText: 'Desired Salary or Pay (You may specify)',
                  controller: desiredSalaryController,
                  colorTheme: blueTheme,
                ),
                y8,
                Align(
                  alignment: Alignment.centerLeft,
                  child: NunitoTextWidget(
                      text:
                          'Examples:\n\t- RM 130/hr.\n\t- RM 900 per week.\n\t- RM 50,000 yearly.',
                      size: fontBody,
                      color: grey),
                ),
                (errorMessage != '' && errorMessage != null)
                    ? _errorMessage()
                    : Container(
                        width: 0,
                      ),
                Container(
                  height: space40 * 3,
                )
              ],
            )),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: const Text('Files'),
            content: Column(
              children: [
                y10,
                CustomButtonWidget(
                  label: 'Share File(s) from File Storage',
                  isFontBold: true,
                  onTap: () {},
                  icon: Icons.file_copy,
                  backgroundColor: darkBlue,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: space20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: space18),
                        child: NunitoTextWidget(
                          text: "OR",
                          size: fontLabel,
                          color: grey,
                          isBold: true,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: grey,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButtonWidget(
                  label: 'Upload New File',
                  isFontBold: true,
                  onTap: () {},
                  icon: Icons.upload_file_rounded,
                  backgroundColor: darkOrange,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: space40, horizontal: space10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: NunitoTextWidget(
                            isBold: true,
                            text: 'Files selected (0):',
                            size: fontLabel,
                            color: grey),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: space20),
                        child: Container(
                          // height: 200,
                          padding: pad20,
                          decoration: BoxDecoration(
                              color: silver, borderRadius: bRadius20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: pad12,
                                child: NunitoTextWidget(
                                    text: 'Open slot'.toUpperCase(),
                                    size: fontBody,
                                    isBold: true,
                                    isCenter: true,
                                    color: grey),
                              ),
                              Padding(
                                padding: pad12,
                                child: NunitoTextWidget(
                                    text: 'Open slot'.toUpperCase(),
                                    size: fontBody,
                                    isCenter: true,
                                    isBold: true,
                                    color: grey),
                              ),
                              Padding(
                                padding: pad12,
                                child: NunitoTextWidget(
                                    text: 'Open slot'.toUpperCase(),
                                    size: fontBody,
                                    isBold: true,
                                    isCenter: true,
                                    color: grey),
                              ),
                              Padding(
                                padding: pad12,
                                child: NunitoTextWidget(
                                    text: 'Open slot'.toUpperCase(),
                                    isCenter: true,
                                    isBold: true,
                                    size: fontBody,
                                    color: grey),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                (errorMessage != '' && errorMessage != null)
                    ? _errorMessage()
                    : Container(
                        width: 0,
                      )
              ],
            )),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 2,
            title: const Text('Extra Info'),
            content: Column(
              children: [
                y20,
                TextfieldWidget(
                  labelText: 'Additional Information (Optional)',
                  controller: additionalInfoController,
                  textInputType: TextInputType.multiline,
                  colorTheme: blueTheme,
                ),
                y8,
                Align(
                  alignment: Alignment.topLeft,
                  child: NunitoTextWidget(
                    text:
                        'Character limit: ${(300 - RegExp(r"\w+(\'\w+)?").allMatches(additionalInfoController.text).length)}',
                    size: fontLabel,
                    color: grey,
                    isBold: true,
                  ),
                ),
                (errorMessage != '' && errorMessage != null)
                    ? _errorMessage()
                    : Container(
                        width: 0,
                      )
              ],
            )),
      ];

  Widget buildStepper() {
    return Theme(
      data: Theme.of(super.context)
          .copyWith(colorScheme: ColorScheme.light(primary: midBlue)),
      child: Stepper(
        physics: const ClampingScrollPhysics(),
        type: StepperType.horizontal,
        elevation: 1,
        steps: getSteps(),
        currentStep: currentStep,
        // onStepTapped: (step) => setState(() => currentStep = step),
        onStepCancel: () {
          currentStep == 0
              ? Navigator.of(super.context).pop()
              : setState(() {
                  currentStep -= 1;
                  (errorMessage != null || errorMessage != '')
                      ? errorMessage = ''
                      : null;
                });
        },
        onStepContinue: () {
          final isLastStep = currentStep == getSteps().length - 1;
          if (isLastStep) {
            if (additionalInfoController.text.characters.length > 300) {
              print(additionalInfoController.text.characters.length);
              setState(() {
                errorMessage =
                    "Oops! You've exceeded the character limit!\nPlease use less characters to meet the quota.";
              });
            } else {
              //currentStep == 2
              //Job Application Completed
              //...
              setState(() {
                isCompleted = true;
              });
              if (kDebugMode) print('Job Application submitted successfully!');
              setState(() {
                (errorMessage != null || errorMessage != '')
                    ? errorMessage = ''
                    : null;
              });
            }
          } else if (currentStep == 1 && newFileToUpload != null) {
            //TODO
          } else if (currentStep == 0 &&
              (fullNameController.text.isEmpty ||
                  emailController.text.isEmpty ||
                  phoneController.text.isEmpty ||
                  desiredSalaryController.text.isEmpty ||
                  startDateController.text.isEmpty)) {
            setState(() {
              errorMessage = 'Please fill in all the textfields.';
            });
          } else if (currentStep == 0 &&
              (!emailController.text.contains('@') ||
                  !emailController.text.contains('.'))) {
            setState(() {
              errorMessage = 'Please enter a valid e-mail address.';
            });
          } else {
            setState(() {
              currentStep += 1;
              (errorMessage != null || errorMessage != '')
                  ? errorMessage = ''
                  : null;
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) print("Job Post ID: ${widget.jobId}");
    return Material(
      child: Column(
        children: [
          y20,
          PoppinsTextWidget(
            text: 'Submit Job Application'.toUpperCase(),
            size: fontTitle,
            isBold: true,
            color: darkBlue,
          ),
          Divider(
            height: space30,
          ),
          Expanded(child: isCompleted ? buildCompleted() : buildStepper()),
        ],
      ),
    );
  }
}
