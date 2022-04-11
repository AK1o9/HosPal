import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gighub/widgets/button_widget.dart';
import 'package:gighub/widgets/text_poppins_widget.dart';
import 'package:gighub/widgets/textfield_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../api/firebase_api.dart';
import '../../classes/firebase_file.dart';
import '../../constants/style.dart';

import 'package:path/path.dart' as _path;

class JobPostPage extends StatefulWidget {
  const JobPostPage({Key? key}) : super(key: key);

  @override
  State<JobPostPage> createState() => _JobPostPageState();
}

class _JobPostPageState extends State<JobPostPage> {
  String? jobId; //Note: This also acts as the document ID in Firebase.
  String? jobType; //Types: Full Time, Part Time, Internship
  String? jobLevel; //Levels: Intermediate, Amateur, Proffesional...
  String?
      jobLocation; //Location requirements: Local, Local + Remote, Global (Fully Remote)
  List<String>?
      jobSkills; //User can set(add) multiple required skills in a list.
  String? jobRequirements; // -> Multiline String
  int jobSalary = 0;

  UploadTask? task;
  File? file;
  //Note: The below variables are intended for Web Usage only.
  Uint8List? bytes;
  PlatformFile? byteFile;
  String? fileURL;
  FirebaseFile? firebaseFile;

  final jobTitleController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final jobSalaryController = TextEditingController();
  final jobSkillsController = TextEditingController();
  final companyNameController = TextEditingController();
  final companyAddressController = TextEditingController();
  final companyDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    jobTitleController.addListener(() => setState(() {}));
    jobDescriptionController.addListener(() => setState(() {}));
    jobSalaryController.addListener(() => setState(() {}));
    jobSkillsController.addListener(() => setState(() {}));
    companyNameController.addListener(() => setState(() {}));
    companyAddressController.addListener(() => setState(() {}));
    companyDescriptionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    jobTitleController.dispose();
    jobDescriptionController.dispose();
    jobSalaryController.dispose();
    jobSkillsController.dispose();
    companyNameController.dispose();
    companyAddressController.dispose();
    companyDescriptionController.dispose();
    super.dispose();
  }

  void clearFields() {
    jobTitleController.clear();
    jobDescriptionController.clear();
    jobSalaryController.clear();
    jobSkillsController.clear();
    companyNameController.clear();
    companyAddressController.clear();
    companyDescriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    jobId = getRandomString(22);
    jobSalaryController.text = 'RM $jobSalary';
    return Material(
      child: Container(
        padding: pad20,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const BackButton(),
            y20,
            y10,
            PoppinsTextWidget(
              text: 'Post a Job Vacancy',
              size: fontTitle,
              color: dark,
              isBold: false,
            ),
            y20,
            y20,

            //Job Info
            PoppinsTextWidget(text: 'Job', size: fontSubtitle, color: dark),
            y20,
            TextfieldWidget(
              labelText: 'Job Title',
              controller: jobTitleController,
            ),
            y20,
            TextfieldWidget(
                labelText: 'Job Description',
                controller: jobDescriptionController),
            y20,
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: TextfieldWidget(
                    labelText: 'Monthly Salary',
                    controller: jobSalaryController,
                    textInputType: TextInputType.number,
                    icon: const Icon(Icons.monetization_on),
                  ),
                ),
                x10,
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onDoubleTap: () {
                            if ((jobSalary - 50) >= 0) {
                              setState(() {
                                jobSalary = jobSalary - 50;
                              });
                            }
                          },
                          onLongPress: () {
                            if ((jobSalary - 100) >= 0) {
                              setState(() {
                                jobSalary = jobSalary - 100;
                              });
                            }
                          },
                          onTap: () {
                            if ((jobSalary - 10) >= 0) {
                              setState(() {
                                jobSalary = jobSalary - 10;
                              });
                            }
                          },
                          child: Container(
                              padding: pad10,
                              decoration: BoxDecoration(
                                  color: silver, borderRadius: bRadius20),
                              child: const Icon(Icons.remove)),
                        ),
                      ),
                      x8,
                      Expanded(
                        child: InkWell(
                          onDoubleTap: () {
                            setState(() {
                              jobSalary = jobSalary + 50;
                            });
                          },
                          onLongPress: () {
                            setState(() {
                              jobSalary = jobSalary + 100;
                            });
                          },
                          onTap: () {
                            setState(() {
                              jobSalary = jobSalary + 10;
                            });
                          },
                          child: Container(
                              padding: pad10,
                              decoration: BoxDecoration(
                                  color: silver, borderRadius: bRadius20),
                              child: const Icon(Icons.add)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            y20,
            Row(
              children: [
                PoppinsTextWidget(
                    text: 'Job Type: ', size: fontSubheader, color: dark),
                x20,
                DropdownButton<String>(
                    value: jobType,
                    elevation: 10,
                    style: TextStyle(color: dark),
                    underline: Container(
                      height: 2,
                      color: grey,
                    ),
                    items: <String>['Full Time', 'Part Time', 'Internship']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        jobType = newValue!;
                      });
                      if (kDebugMode) {
                        print('Job type set to: $jobType.');
                      }
                    }),
              ],
            ),
            y20,
            TextfieldWidget(
              labelText: 'Skills Required',
              controller: jobSkillsController,
            ),
            Divider(height: space40),

            //Company Info
            PoppinsTextWidget(text: 'Company', size: fontSubtitle, color: dark),
            y20,

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextfieldWidget(
                              labelText: 'Company Name',
                              controller: companyNameController,
                              icon: const Icon(Icons.business),
                            ),
                          ),
                          x10,
                          Expanded(
                            flex: 2,
                            child: TextfieldWidget(
                              labelText: 'Company Address',
                              controller: companyAddressController,
                              icon: const Icon(Icons.location_on),
                              textInputType: TextInputType.streetAddress,
                            ),
                          ),
                        ],
                      ),
                      y20,
                      TextfieldWidget(
                          labelText: 'Company Description & Information',
                          // hintText:
                          //     "Short summary of Company's activities and achievements",
                          controller: companyDescriptionController,
                          textInputType: TextInputType.multiline),
                      y20,
                      TextfieldWidget(
                          labelText: 'Company Description & Information',
                          // hintText:
                          //     "Short summary of Company's activities and achievements",
                          controller: companyDescriptionController,
                          textInputType: TextInputType.multiline),
                      y20,
                      TextfieldWidget(
                          labelText: 'Company Description & Information',
                          // hintText:
                          //     "Short summary of Company's activities and achievements",
                          controller: companyDescriptionController,
                          textInputType: TextInputType.multiline),
                      y20,
                      TextfieldWidget(
                          labelText: 'Company Description & Information',
                          // hintText:
                          //     "Short summary of Company's activities and achievements",
                          controller: companyDescriptionController,
                          textInputType: TextInputType.multiline),
                    ],
                  ),
                ),
                x10,
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      PoppinsTextWidget(
                          text: 'Company Logo', size: fontHeader, color: dark),
                      y8,
                      buildImageBox(),
                    ],
                  ),
                ),
              ],
            ),

            y30, y20,
            Center(
              child: ButtonWidget(
                  label: 'Post Job Opening',
                  onTap: () {
                    validateData();
                  }),
            )
          ]),
        ),
      ),
    );
  }

  void validateData() {
    if (jobTitleController.text.isEmpty ||
        jobDescriptionController.text.isEmpty ||
        companyNameController.text.isEmpty ||
        companyAddressController.text.isEmpty ||
        companyDescriptionController.text.isEmpty) {
      //Error message: fill all fields.
    } else if (jobSalary < 1500 && jobType != 'Internship') {
      //Below Minimum wage.
    } else if (jobType == '' || jobType == null) {
      //Please set a job type.
    } else {
      //Save data
      saveData();
      uploadFile();
      //Confirmation message
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (_) => AlertDialog(
                title: PoppinsTextWidget(
                  text: 'Post Published',
                  size: fontTitle,
                  color: dark,
                  isBold: true,
                ),
                content: PoppinsTextWidget(
                  text:
                      "You can view your post under 'My listings' from the main menu.",
                  size: fontSubtitle,
                  color: dark,
                ),
                // actionsAlignment: MainAxisAlignment.center,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(this.context).pop;
                    },
                    child: PoppinsTextWidget(
                      text: "OK",
                      size: fontSubtitle,
                      color: dark,
                      isBold: true,
                    ),
                  ),
                ],
              ));

      //Reset fields & data
      clearFields();
      setState(() {
        jobSalary = 0;
        jobType = null;
      });
    }
  }

  void saveData() {
    try {
      var collection = FirebaseFirestore.instance.collection('jobs');
      collection.doc(jobId).set({
        'job_title': jobTitleController.text,
        'job_description': jobDescriptionController.text,
        'job_type': jobType,
        'monthly_salary': jobSalary,
        'company_name': companyNameController.text,
        'company_address': companyAddressController.text,
        'company_info': companyDescriptionController.text,
      }).then((value) {
        if (kDebugMode) {
          print('Data saved successfuly!');
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('Encountered an error whilst saving data:\n$error');
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error trying to save the post in Firebase:\n$e');
      }
    }
  }

  Widget buildImageBox() {
    return Container(
      padding: pad12,
      decoration: BoxDecoration(
          border: Border.all(color: grey, width: 0.5), borderRadius: bRadius20),
      child: Column(children: [
        Container(
            // padding: pad10,
            width: 150,
            height: 150,
            decoration: BoxDecoration(borderRadius: bRadius20, color: silver),
            // ignore: prefer_const_constructors
            child: (file != null)
                ? SafeArea(
                    child: Image.network(
                      file!.path,
                      fit: BoxFit.scaleDown,
                    ),
                  )
                : (bytes != null)
                    ? SafeArea(
                        child: Image.network(
                          bytes.toString(),
                          fit: BoxFit.scaleDown,
                        ),
                      )
                    : Icon(
                        Icons.image_not_supported_rounded,
                        size: 50,
                        color: grey,
                      )),
        y20,
        ButtonWidget(
          label: 'Upload Image',
          onTap: selectFile,
          isInverted: true,
        ),
        y8,
        PoppinsTextWidget(
            text: '* Maximum File Size: 1 GB.', size: fontBody, color: dark)
      ]),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) {
      return;
    } else if (/* result.files.single.bytes != null ||
        FilePicker.platform.toString() == "Instance of 'FilePickerWeb'" ||  */
        kIsWeb) {
      final path = result.files.single.path;
      setState(() {
        bytes = result.files.single.bytes;
        byteFile = result.files.single;
        // file = File(path!).writeAsBytes(bytes!) as File?;
      });
    } else {
      final path = result.files.single.path;
      setState(() => file = File(path!));
    }

    //File Information: (Dev view)
    if (kDebugMode) {
      print('File Info: ');
      print('Name: ${result.files.single.name}');
      print('Size: ${result.files.single.size}');
      print('Extension: ${result.files.single.extension}');
      result.files.single.bytes != null
          ? print('Bytes: ${result.files.single.bytes}')
          : print('Path: ${result.files.single.path}');
    }
  }

  Future uploadFile() async {
    if (file == null && bytes == null) {
      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text("Please make sure you've selected a file to upload."),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    } else if (file != null) {
      final fileName = _path.basename(file!.path);
      final destination = 'jobs/$fileName';

      task = FirebaseApi.uploadFile(destination, file!);
      setState(() {});
    } else {
      //if (bytes != null){
      final fileName = byteFile!.name;
      final destination = 'jobs/$jobId/$fileName';

      task = FirebaseApi.uploadBytes(destination, bytes!);
      setState(() {});
    }

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    if (kDebugMode) {
      print('Download-Link: $urlDownload');
    }

    setState(() {
      fileURL = urlDownload;
    });
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap!.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);
            // ignore: unrelated_type_equality_checks
            if (buildUploadStatus(task) == 'Upload Status: 100 %') {
              Navigator.of(context).pop();
            }

            return Text(
              'Upload Status: $percentage %',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );

  //Generating doc id
  String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
}
