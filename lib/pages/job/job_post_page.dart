import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:hospal/api/screen_responsiveness/dimensions.dart';
import 'package:hospal/api/user_auth.dart';
import 'package:hospal/widgets/button_widget.dart';
import 'package:hospal/widgets/text_poppins_widget.dart';
import 'package:hospal/widgets/textfield_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../api/firebase_api.dart';
import '../../classes/dropped_file.dart';
import '../../classes/firebase_file.dart';
import '../../constants/style.dart';

import 'package:path/path.dart' as _path;

import '../../widgets/custom_button_widget.dart';
import '../../widgets/dropped_file_widget.dart';
import '../../widgets/dropzone_widget.dart';

class JobPostPage extends StatefulWidget {
  const JobPostPage({Key? key}) : super(key: key);

  @override
  State<JobPostPage> createState() => _JobPostPageState();
}

class _JobPostPageState extends State<JobPostPage> {
  String? docId;
  String? jobId;
  String? jobType = 'Part Time'; //Types: Full Time, Part Time, Internship
  String? jobLevel =
      'Intermediate'; //Levels: Intermediate, Amateur, Proffesional...
  String?
      jobLocation; //Location requirements: Local, Local + Remote, Global (Fully Remote)
  List<String>? jobSkills =
      []; //User can set(add) multiple required skills in a list.
  String? jobRequirements; // -> Multiline String
  int jobSalary = 0; //TODO: Remove?
  int jobDuration = 0; //TODO: Remove?
  String? jobDurationInterval = 'Month(s)'; //Intervals: Days, Months, Years

  final jobTitleController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final jobPayFromController = TextEditingController();
  final jobPayTillController = TextEditingController();
  final jobDurationController = TextEditingController();
  final jobRequirementsController = TextEditingController();
  final jobSkillsController = TextEditingController();
  final companyNameController = TextEditingController();
  final companyAddressController = TextEditingController();
  final companyDescriptionController = TextEditingController();

  DropzoneViewController? dropzoneController;
  bool isDropzoneHighlighted = false;
  bool uploadError = false;

  UploadTask? task;
  File? file;
  DroppedFile? droppedFile;
  FirebaseFile? firebaseFile;

  //Note: The below variables are intended for Web Usage only.
  Uint8List? bytes;
  PlatformFile? byteFile;
  String? fileURL;

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileWidth;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileWidth;

  @override
  void initState() {
    super.initState();
    jobTitleController.addListener(() => setState(() {}));
    jobDescriptionController.addListener(() => setState(() {}));
    jobPayFromController.addListener(() => setState(() {}));
    jobPayTillController.addListener(() => setState(() {}));
    jobDurationController.addListener(() => setState(() {}));
    jobRequirementsController.addListener(() => setState(() {}));
    jobSkillsController.addListener(() => setState(() {}));
    companyNameController.addListener(() => setState(() {}));
    companyAddressController.addListener(() => setState(() {}));
    companyDescriptionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    jobTitleController.dispose();
    jobDescriptionController.dispose();
    jobPayFromController.dispose();
    jobPayTillController.dispose();
    jobDurationController.dispose();
    jobRequirementsController.dispose();
    jobSkillsController.dispose();
    companyNameController.dispose();
    companyAddressController.dispose();
    companyDescriptionController.dispose();
    super.dispose();
  }

  void clearFields() {
    jobTitleController.clear();
    jobDescriptionController.clear();
    jobPayFromController.clear();
    jobPayTillController.clear();
    jobDurationController.clear();
    jobRequirementsController.clear();
    jobSkillsController.clear();
    companyNameController.clear();
    companyAddressController.clear();
    companyDescriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    docId = getRandomString(22);
    jobId = 'J-${getRandomString(20)}';
    return Material(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(
              left: isMobile(context) ? space12 : space18,
              right: isMobile(context) ? space12 : 0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // const BackButton(),
              y20,
              PoppinsTextWidget(
                  text: "New Job Post",
                  size: 64,
                  isBold: true,
                  color: midOrange),
              Divider(
                height: space40,
              ),
              y20,
              PoppinsTextWidget(
                  text: 'NOTE:\nAsterisk (*)  =>  Required',
                  size: fontLabel,
                  color: dark),
              y20,
              //Job Info
              PoppinsTextWidget(text: 'Job', size: fontSubtitle, color: dark),
              y20,
              TextfieldWidget(
                labelText: 'Job Title *',
                controller: jobTitleController,
                colorTheme: orangeTheme,
              ),
              y20,
              TextfieldWidget(
                labelText: 'Job Description *',
                controller: jobDescriptionController,
                colorTheme: orangeTheme,
              ),
              y20,
              PoppinsTextWidget(
                  text: 'Pay Range (RM) *', size: fontSubheader, color: dark),
              y10,
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextfieldWidget(
                      colorTheme: orangeTheme,
                      labelText: 'From',
                      controller: jobPayFromController,
                      textInputType: TextInputType.number,
                      icon: const Icon(Icons.monetization_on),
                    ),
                  ),
                  x10,
                  Expanded(
                    flex: 2,
                    child: TextfieldWidget(
                      labelText: 'To',
                      controller: jobPayTillController,
                      colorTheme: orangeTheme,
                      textInputType: TextInputType.number,
                      icon: const Icon(Icons.monetization_on),
                    ),
                  )
                ],
              ),
              y20,
              Row(
                children: [
                  Expanded(
                    flex: isMobile(context) ? 2 : 15,
                    child: TextfieldWidget(
                        labelText: 'Duration *',
                        controller: jobDurationController,
                        colorTheme: orangeTheme,
                        textInputType: TextInputType.number,
                        icon: const Icon(Icons.calendar_month)),
                  ),
                  x10,
                  x8,
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DropdownButton<String>(
                            value: jobDurationInterval,
                            elevation: 10,
                            style: TextStyle(color: dark),
                            underline: Container(
                              height: 2,
                              color: grey,
                            ),
                            items: <String>[
                              'Day(s)',
                              'Month(s)',
                              'Year(s)',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                jobDurationInterval = newValue!;
                              });
                              if (kDebugMode) {
                                print(
                                    'Job duration interval set to: $jobDurationInterval.');
                              }
                            }),
                      ],
                    ),
                  )
                ],
              ),
              y20,
              Row(
                children: [
                  PoppinsTextWidget(
                      text: 'Job Type * : ', size: fontSubheader, color: dark),
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
              Row(
                children: [
                  PoppinsTextWidget(
                      text: 'Job Level * : ', size: fontSubheader, color: dark),
                  x20,
                  DropdownButton<String>(
                      value: jobLevel,
                      elevation: 10,
                      style: TextStyle(color: dark),
                      underline: Container(
                        height: 2,
                        color: grey,
                      ),
                      items: <String>[
                        'Expert',
                        'Proffessional',
                        'Amateur',
                        'Student',
                        'Intermediate'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          jobLevel = newValue!;
                        });
                        if (kDebugMode) {
                          print('Job level set to: $jobLevel.');
                        }
                      }),
                ],
              ),
              y20,
              TextfieldWidget(
                labelText: 'Job Requirements',
                colorTheme: orangeTheme,
                controller: jobRequirementsController,
                textInputType: TextInputType.multiline,
              ),
              y20,
              Row(
                children: [
                  Expanded(
                    flex: isMobile(context) ? 2 : 12,
                    child: TextfieldWidget(
                      labelText: 'Skills Required',
                      controller: jobSkillsController,
                      colorTheme: orangeTheme,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: space10),
                    child: CustomButtonWidget(
                        backgroundColor: darkOrange,
                        label: 'Add',
                        icon: Icons.add,
                        onTap: () {
                          setState(() {
                            jobSkills!.add(jobSkillsController.text);
                            jobSkillsController.clear();
                          });
                          if (kDebugMode) {
                            print('Job skills: $jobSkills');
                          }
                        }),
                  ))
                ],
              ),
              jobSkills!.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: space10),
                      child: SafeArea(
                          child: SizedBox(height: 64, child: buildJobSkills())),
                    )
                  : Container(width: 0),
              Divider(height: space40),

              //Company Info
              PoppinsTextWidget(
                  text: 'Company', size: fontSubtitle, color: dark),
              y20,

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextfieldWidget(
                                labelText: 'Company Name *',
                                controller: companyNameController,
                                icon: const Icon(Icons.business),
                                colorTheme: orangeTheme,
                              ),
                            ),
                            isDesktop(context)
                                ? x10
                                : Container(
                                    width: 0,
                                  ),
                            isDesktop(context)
                                ? Expanded(
                                    flex: 2,
                                    child: TextfieldWidget(
                                      labelText: 'Company Address',
                                      colorTheme: orangeTheme,
                                      controller: companyAddressController,
                                      icon: const Icon(Icons.location_on),
                                      textInputType:
                                          TextInputType.streetAddress,
                                    ),
                                  )
                                : Container(
                                    width: 0,
                                  ),
                          ],
                        ),
                        isMobile(context)
                            ? y20
                            : Container(
                                width: 0,
                              ),
                        isMobile(context)
                            ? TextfieldWidget(
                                labelText: 'Company Address',
                                colorTheme: orangeTheme,
                                controller: companyAddressController,
                                icon: const Icon(Icons.location_on),
                                textInputType: TextInputType.streetAddress,
                              )
                            : Container(
                                width: 0,
                              ),
                        y20,
                        TextfieldWidget(
                            colorTheme: orangeTheme,
                            labelText: 'Company Description & Information',
                            controller: companyDescriptionController,
                            textInputType: TextInputType.multiline),
                      ],
                    ),
                  ),
                ],
              ),
              y20,
              uploadError
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: space12),
                      child: PoppinsTextWidget(
                          text: "Sorry! This feature is temporarily disabled.",
                          size: fontLabel,
                          color: Colors.red),
                    )
                  : Container(
                      width: 0,
                    ),
              y30,
              y20,
              Center(
                child: SizedBox(
                  width: 200,
                  child: SafeArea(
                    child: CustomButtonWidget(
                        backgroundColor: darkOrange,
                        label: 'Post Job Opening',
                        onTap: () {
                          validateData();
                        }),
                  ),
                ),
              ),
              y20
            ]),
          ),
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
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.red,
              title: PoppinsTextWidget(
                text: 'Error',
                size: fontTitle,
                color: light,
                isBold: true,
              ),
              content: PoppinsTextWidget(
                text: "Please make sure to fill up all of the fields.",
                size: fontSubtitle,
                color: light,
              ),
            );
          });
    } else if (jobType == '' || jobType == null) {
      //Please set a job type.
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (_) => AlertDialog(
                backgroundColor: Colors.red,
                title: PoppinsTextWidget(
                  text: 'Error',
                  size: fontTitle,
                  color: light,
                  isBold: true,
                ),
                content: PoppinsTextWidget(
                  text: "Please select a valid job type.",
                  size: fontSubtitle,
                  color: light,
                ),
              ));
    } else {
      //Save data
      saveData();
      saveFiles();
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
                contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 35),
                content: PoppinsTextWidget(
                  text:
                      "You can view your post under 'My listings' from the main menu.",
                  size: fontSubtitle,
                  color: dark,
                ),
              ));

      //Reset fields & data
      clearFields();
      setState(() {
        jobSalary = 0;
        jobType = null;
        jobLevel = null;
        jobSkills!.clear();
        jobDurationInterval = null;
        droppedFile = null;
      });
    }
  }

  void saveData() {
    var collection = FirebaseFirestore.instance.collection('jobs');
    String userId = UserAuth().currentUser!.uid;
    // var collection = FirebaseFirestore.instance.collection('users').doc(userId);
    try {
      collection.doc(docId).set({
        // collection.collection('jobs').doc(docId).set({
        'job_id': jobId,
        'employer_id': userId,
        'job_level': jobLevel,
        'job_title': jobTitleController.text,
        'job_description': jobDescriptionController.text,
        'job_type': jobType,
        'job_pay_from': int.parse(jobPayFromController.text),
        'job_pay_till': int.parse(jobPayTillController.text),
        'job_duration': jobDurationController.text + ' ' + jobDurationInterval!,
        'job_skills': jobSkills,
        'company_name': companyNameController.text,
        'company_address': companyAddressController.text,
        'company_info': companyDescriptionController.text,
        'logo_file': null,
        'logo_url': null,
        'publication_date':
            DateFormat('dd/MM/yyyy').format(DateTime.now()), //reformat
        'publication_time': DateFormat.Hms().format(DateTime.now()),
        'search_keys': setSearchKeys(jobTitleController.text),
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

  Future<void> saveFiles() async {
    if (droppedFile == null) {
      return;
    } else if (kIsWeb) {
      try {
        String _docId =
            docId!; //Note: This variable fixes an issue in where docId would keep resetting to a different string
        var ref = FirebaseStorage.instance
            .ref()
            .child('jobs')
            .child(jobId!)
            .child(droppedFile!.name);

        // Firebase.upload
        var uploadTask = ref.putData(droppedFile!.bytes).catchError((error) {
          if (kDebugMode) {
            print('Error saving file:\n$error');
          }
        });

        var loadURL = await (await uploadTask).ref.getDownloadURL();

        String finalName = (await uploadTask).ref.name;
        String finalURL = loadURL.toString();

        var db = FirebaseFirestore.instance.collection('jobs');

        db
            .doc(_docId)
            .update({'logo_file': finalName, 'logo_url': finalURL}).then((_) {
          if (kDebugMode) {
            print('Task File URL saved successfully.');
          }
        }).catchError((error) {
          if (kDebugMode) {
            print(
                'Failed to save the File URL for the select task.\nError: $error');
          }
        });
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      //File Upload for Android.
      return;
    }
  }

  Widget pickFile() {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            backgroundColor: midOrange,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        icon: const Icon(Icons.attach_file_rounded, size: 32),
        label: const Text('Attach File(s)',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        onPressed: () async {
          setState(() {
            uploadError = true;
          });

        },
      ),
    );
  }

  Future<dynamic> acceptFile(dynamic event) async {
    final name = event.name;
    final mime = await dropzoneController!.getFileMIME(event);
    final size = await dropzoneController!.getFileSize(event);
    final url = await dropzoneController!.createFileUrl(event);
    final bytes = await dropzoneController!.getFileData(event);

    if (kDebugMode) {
      print(name);
      print(mime);
      print(size);
      print(url);
    }

    // ignore: unused_local_variable
    final droppedFile = DroppedFile(
      url: url,
      name: name,
      mime: mime,
      size: size,
      bytes: bytes,
    );

  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) {
      return;
    } else if (
        kIsWeb) {
      final path = result.files.single.path;
      setState(() {
        bytes = result.files.single.bytes;
        byteFile = result.files.single;
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

  Widget buildJobSkills() {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: jobSkills!.length,
            itemBuilder: (context, index) {
              return InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    jobSkills!.removeAt(index);
                  });
                },
                child: Card(
                    color: silver,
                    child: Center(
                        child: Padding(
                      padding: pad12,
                      child: Column(
                        children: [
                          PoppinsTextWidget(
                            text: jobSkills![index],
                            size: fontBody,
                            color: dark,
                          ),
                        ],
                      ),
                    ))),
              );
            }));
  }

  setSearchKeys(String keyword) {
    List<String> searchKeyList = [];
    String temp = "";
    for (int i = 0; i < keyword.length; i++) {
      temp = temp + keyword[i];
      searchKeyList.add(temp);
    }
    return searchKeyList;
  }
}
