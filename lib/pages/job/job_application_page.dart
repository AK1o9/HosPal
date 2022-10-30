import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospal/widgets/text_poppins_widget.dart';
import 'package:hospal/widgets/textfield_widget.dart';

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
            y10,
          ]),
        ),
      ),
    );
  }
}
