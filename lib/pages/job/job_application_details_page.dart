import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hospal/api/user_auth.dart';
import 'package:hospal/constants/style.dart';
import 'package:hospal/pages/job/job_details_page.dart';
import 'package:hospal/pages/user/jobseeker/js_profile_page.dart';
import 'package:hospal/widgets/button_widget.dart';
import 'package:hospal/widgets/custom_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/text_poppins_widget.dart';

class JobApplicationDetailsPage extends StatefulWidget {
  final String docId;
  final bool isEmployerView;
  const JobApplicationDetailsPage(
      {required this.docId, this.isEmployerView = false, Key? key})
      : super(key: key);

  @override
  State<JobApplicationDetailsPage> createState() =>
      _JobApplicationDetailsPageState();
}

String? jobId;
String? jobDocId;

String jobseekerId = '';

List<String> files = [];

List<String> fileNames = [];
List<String> fileTypes = [];
List<String> fileSizes = [];
List<String> fileDownloadUrls = [];

var userDoc = FirebaseFirestore.instance
    .collection('users')
    .doc(UserAuth().currentUser!.uid); // FOR JOBSEEKERS only

var applicationsCollection =
    FirebaseFirestore.instance.collection('applications');

class _JobApplicationDetailsPageState extends State<JobApplicationDetailsPage> {
  @override
  void initState() {
    super.initState();
    //TODO: Fix
    getJobseekerData();
    // getFiles();
    // getFileInfo();
  }

  void getJobseekerData() async {
    // files.forEach((element) {});
    await applicationsCollection.doc(widget.docId).get().then((value) {
      setState(() {
        jobseekerId = value.data()!['jobseeker_id'];
      });
    });
  }

  Future<void> getFiles() async {
    try {
      List<String> temp = [];
      await applicationsCollection.doc(widget.docId).get().then((value) {
        value['files'].forEach((val) {
          temp.add(val.toString());
        });
        setState(() {
          files = temp;
        });
        if (kDebugMode) print(files);
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  void getFileInfo() async {
    try {
      // files.forEach((element) {});
      await FirebaseFirestore.instance
          .collection('users')
          .doc(jobseekerId)
          .collection('files')
          .get()
          .then((value) {
        for (var doc in value.docs) {
          for (var file in files) {
            if (file == doc.id) {
              setState(() {
                fileNames.add(doc['file_name']);
                fileTypes.add(doc['file_type']);
                fileSizes.add(doc['file_size']);
                fileDownloadUrls.add(doc['download_url']);
              });
            }
          }
        }
        // for (var file in files) {
        //   if (file==value.docs. {
        //     setState(() {
        //       fileNames.add(value);
        //     });
        //   }
        // }
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
      child: Container(
        color: light,
        child: Padding(
          padding: pad20,
          child: Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              PoppinsTextWidget(
                  text: 'Application Details',
                  size: 42,
                  isBold: true,
                  color: widget.isEmployerView ? darkOrange : midBlue),
              Divider(
                height: space20,
              ),
              y20,
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: silver, width: 1),
                      color: light,
                      borderRadius: bRadius12),
                  padding: EdgeInsets.symmetric(
                      horizontal: space10, vertical: space12),
                  child:
                      buildFuture() /* Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // PoppinsTextWidget(
                      //     text: 'tst', size: fontBody, color: dark),
                      buildFuture(),
                      Container(
                        height: 800,
                      )
                      //job title
                      //comp name
                      //comp_location

                      //your details

                      //your files (attachments)

                      //Status & how to proceed

                      //Option to delete application
                    ]), */
                  ),
              Padding(
                padding: pad20,
                child: CustomButtonWidget(
                  label: 'Back',
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {
                      jobseekerId = '';
                      files = [];
                      fileNames = [];
                      fileSizes = [];
                      fileTypes = [];
                    });
                  },
                  backgroundColor: darkOrange,
                  isFontBold: true,
                ),
              )
            ]),
          ),
        ),
      ),
    ));
  }

  Widget buildStream() {
    var applicationRef =
        FirebaseFirestore.instance.collection('applications').doc(widget.docId);
    return StreamBuilder(
        stream: applicationRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(/* child: Text(snapshot.data['sad']) */);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildFuture() {
    var applicationRef =
        FirebaseFirestore.instance.collection('applications').doc(widget.docId);
    return FutureBuilder<DocumentSnapshot>(
        future: applicationRef.get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var document = snapshot.data!.data();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PoppinsTextWidget(
                  text: document['job_title'],
                  // overflow: TextOverflow.ellipsis,
                  size: fontTitle,
                  color: dark,
                  isBold: true,
                ),
                y4,
                PoppinsTextWidget(
                  text: document['company_name'],
                  size: fontHeader,
                  color: dark,
                  isBold: true,
                ),
                y8,
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: space10),
                      child: Icon(
                        Icons.location_on,
                        color: dark,
                      ),
                    ),
                    Flexible(
                      child: PoppinsTextWidget(
                        text: document['company_address'],
                        // overflow: TextOverflow.ellipsis,
                        size: fontLabel,
                        color: dark,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: space20,
                ),
                y10,
                PoppinsTextWidget(
                    text: 'Your Details:', size: fontSubheader, color: dark),
                y20,
                PoppinsTextWidget(
                  text: 'Full name',
                  size: fontLabel,
                  isBold: true,
                  color: dark,
                ),
                PoppinsTextWidget(
                  text: '${document['full_name']}',
                  size: fontLabel,
                  color: dark,
                ),
                y10,
                PoppinsTextWidget(
                  text: 'E-mail address',
                  size: fontLabel,
                  isBold: true,
                  color: dark,
                ),
                PoppinsTextWidget(
                  text: '${document['email_address']}',
                  size: fontLabel,
                  color: dark,
                ),
                y10,
                PoppinsTextWidget(
                  text: 'Contact number',
                  size: fontLabel,
                  isBold: true,
                  color: dark,
                ),
                PoppinsTextWidget(
                  text: '${document['contact_number']}',
                  size: fontLabel,
                  color: dark,
                ),
                y20,
                PoppinsTextWidget(
                  text: 'Desired start date',
                  size: fontLabel,
                  isBold: true,
                  color: dark,
                ),
                PoppinsTextWidget(
                  text: '${document['desired_start_date']}',
                  size: fontLabel,
                  color: dark,
                ),
                y10,
                PoppinsTextWidget(
                  text: 'Desired salary or pay',
                  size: fontLabel,
                  isBold: true,
                  color: dark,
                ),
                PoppinsTextWidget(
                  text: '${document['desired_salary']}',
                  size: fontLabel,
                  color: dark,
                ),
                y30,
                PoppinsTextWidget(
                  text: 'Attachments (${document['files'].length})',
                  size: fontLabel,
                  isBold: true,
                  color: dark,
                ),
                y8,
                files.isEmpty
                    ? Padding(
                        padding: pad10,
                        child: CustomButtonWidget(
                            label: 'View Attachments',
                            backgroundColor: dark,
                            icon: Icons.visibility_rounded,
                            onTap: () {
                              getFiles();
                              getFileInfo();
                              // showDialog(
                              //     context: context,
                              //     builder: (context) => AlertDialog(
                              //         title: PoppinsTextWidget(
                              //           text: 'Attachments',
                              //           size: fontHeader,
                              //           isBold: true,
                              //           color: dark,
                              //         ),
                              //         content: /* FutureBuilder(
                              //             future: FirebaseFirestore.instance
                              //                 .collection('files')
                              //                 .doc(jobseekerId)
                              //                 .get(),
                              //             builder: (BuildContext context,
                              //                 AsyncSnapshot snapshot) {
                              //               if (snapshot.hasData) {
                              //                 var document = snapshot.data;
                              //                 return Column(
                              //                   children: [
                              //                     SizedBox(
                              //                       height: 200,
                              //                       child: ListView.builder(
                              //                           itemCount: snapshot
                              //                               .data.length,
                              //                           itemBuilder:
                              //                               (context, index) {
                              //                             return Card(
                              //                               child: Column(
                              //                                   children: [
                              //                                     Text(document[
                              //                                         'file_name'])
                              //                                   ]),
                              //                             );
                              //                           }),
                              //                     ),
                              //                   ],
                              //                 );
                              //               }
                              //               if (snapshot.hasError) {
                              //                 return const Center(
                              //                     child:
                              //                         Text('Nothing here...'));
                              //               }
                              //               return const Center(
                              //                 child:
                              //                     CircularProgressIndicator(),
                              //               );
                              //             },
                              //           ), */
                              //             Column(
                              //           children: [
                              //             SizedBox(
                              //               height: 200,
                              //               width: 200,
                              //               child: ListView.builder(
                              //                 itemCount: files.length,
                              //                 itemBuilder: ((context, index) {
                              //                   return Center(
                              //                     child: Card(
                              //                         child: Padding(
                              //                       padding: pad12,
                              //                       child: PoppinsTextWidget(
                              //                           text: fileNames[index],
                              //                           size: fontLabel,
                              //                           color: dark),
                              //                     )),
                              //                   );
                              //                 }),
                              //               ),
                              //             ),
                              //           ],
                              //         )));
                            }),
                      )
                    : document['files'].length > 0
                        ? Container(
                            padding: pad12,
                            decoration: BoxDecoration(
                                color: silver, borderRadius: bRadius12),
                            height: 200,
                            child: buildFilesLV(), //TODO
                          )
                        : PoppinsTextWidget(
                            text: 'None',
                            size: fontLabel,
                            color: dark,
                          ),
                y30,
                PoppinsTextWidget(
                  text: 'Status',
                  size: fontLabel,
                  isBold: true,
                  color: dark,
                ),
                PoppinsTextWidget(
                  text: '${document['status']}',
                  size: fontLabel,
                  color: dark,
                ),
                y8,
                Container(
                  padding: pad12,
                  decoration:
                      BoxDecoration(color: silver, borderRadius: bRadius12),
                  child: PoppinsTextWidget(
                      text: getStatusMessage(document['status']),
                      size: fontBody,
                      color: dark),
                ),
                Padding(
                  padding: EdgeInsets.only(top: space10),
                  child: widget.isEmployerView
                      ? Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: space20, horizontal: space10),
                                child: CustomButtonWidget(
                                  label: 'View Profile',
                                  isFontBold: true,
                                  icon: Icons.person_search,
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                JobseekerProfilePage(
                                                  userId: jobseekerId,
                                                  canBack: true,
                                                )));
                                  },
                                  backgroundColor: dark,
                                )),
                            Padding(
                              padding: pad10,
                              child: CustomButtonWidget(
                                label: 'Approve',
                                isFontBold: true,
                                icon: Icons.check_box,
                                onTap: () {
                                  updateStatus('Approved');
                                  if (kDebugMode) print('STATUS => APPROVED!');
                                },
                                backgroundColor: Colors.green.shade700,
                              ),
                            ),
                            Padding(
                              padding: pad10,
                              child: CustomButtonWidget(
                                label: 'Reject',
                                isFontBold: true,
                                icon: Icons.disabled_by_default_rounded,
                                onTap: () {
                                  updateStatus('Rejected');
                                  if (kDebugMode) print('STATUS => REJECTED.');
                                },
                                backgroundColor: Colors.red.shade700,
                              ),
                            )
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red.shade700,
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: PoppinsTextWidget(
                                              text: 'Delete Job Application',
                                              size: fontHeader,
                                              color: dark,
                                              isBold: true,
                                            ),
                                            content: PoppinsTextWidget(
                                                text:
                                                    'This action will delete the entire page. Are you sure you want to continue?',
                                                size: fontLabel,
                                                color: dark),
                                            actionsAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context)
                                                        .deactivate();
                                                    await applicationsCollection
                                                        .doc(widget.docId)
                                                        .delete();
                                                    print('deleted...');

                                                    Navigator.of(super.context)
                                                        .pop();
                                                  },
                                                  child: PoppinsTextWidget(
                                                    text: 'Confirm',
                                                    size: fontLabel,
                                                    color: dark,
                                                    isBold: true,
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: PoppinsTextWidget(
                                                    text: 'Cancel',
                                                    size: fontLabel,
                                                    color: dark,
                                                    isBold: false,
                                                  )),
                                            ],
                                          ));
                                },
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: CustomButtonWidget(
                                label: 'View Job Details',
                                onTap: () {
                                  getJobDocId(document['job_id']);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => JobPage(
                                            docId: document[
                                                'job_doc_id'], //jobDocId,
                                            employerId: document['employer_id'],
                                          )));
                                },
                                backgroundColor: darkBlue,
                                isFontBold: true,
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            return const Text('Oops! Something went wrong.');
          }

          return const Center(child: CircularProgressIndicator());
        });
  }

  Future<String>? getData() {}

  String getStatusMessage(String status) {
    switch (status) {
      case 'Approved':
        return "An 'Approved' status implies that the Employer has reviewed and accepted your application.\n\nCongratulations! The Employer has accepted your job application and you're now elligible for the role.\n\nMake sure to check your e-mails and contact information as the Employer is expected to contact you as to how you may proceed.";
      case 'Rejected':
        return "A 'Rejected' status implies that the Employer has sadly declined your application. \n\n Sorry! You may not have been elligibile for this role but don't fret! You can try out other job posts.";
      default:
        return "A 'Pending' status implies that the Employer has yet to read or review your application.\n\nFor now, you can sit back and relax. We will inform you once there's any updates from the Employer.";
    }
  }

  void getJobDocId(String jobId) async {
    var d = FirebaseFirestore.instance.collection('jobs');
    d.where('job_id', isEqualTo: jobId).get().then((value) {
      setState(() {
        jobDocId = value.docs.first.id.toString();
      });
    });
  }

  Future<void> getJobData(String jobId) async {
    var d = FirebaseFirestore.instance
        .collection('jobs')
        .where('job_id', isEqualTo: jobId);
    await d.get().then((value) {
      setState(() {
        jobDocId = value.docs.first.id.toString();
      });
    });
  }

  Future<void> updateStatus(String newStatus) async {
    await applicationsCollection.doc(widget.docId).update({
      'status': newStatus,
    });
    setState(() {});
  }

  Widget buildFilesLV() {
    // return ListView(
    //   scrollDirection: Axis.horizontal,
    //   children: files.map((file) {
    //     return Padding(
    //       padding: EdgeInsets.only(right: space10),
    //       child: InkWell(
    //         onTap: () {},
    //         child: Container(
    //             height: 150,
    //             width: 200,
    //             decoration:
    //                 BoxDecoration(color: light, borderRadius: bRadius20),
    //             padding: pad20,
    //             child: Column(
    //               children: [
    //                 PoppinsTextWidget(
    //                   text: file,
    //                   size: fontLabel,
    //                   color: dark,
    //                   isBold: true,
    //                 ),
    //                 PoppinsTextWidget(
    //                   text: fileNames[2],
    //                   size: fontLabel,
    //                   color: dark,
    //                   isBold: true,
    //                 ),
    //               ],
    //             )),
    //       ),
    //     );
    //   }).toList(),
    //   // children: files.map((e) {}).toList(),
    // );
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: files.length,
        itemBuilder: ((context, index) {
          return Padding(
              padding: EdgeInsets.only(right: space10),
              child: InkWell(
                onTap: () {
                  _launchUrl(fileDownloadUrls[index]);
                },
                child: Container(
                    height: 200,
                    width: 200,
                    decoration:
                        BoxDecoration(color: light, borderRadius: bRadius20),
                    padding: pad20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // PoppinsTextWidget(
                        //   text: files[index],
                        //   size: fontLabel,
                        //   color: dark,
                        //   isBold: true,
                        // ),
                        const Icon(
                          Icons.file_present_outlined,
                          size: 36,
                        ),
                        y10,
                        PoppinsTextWidget(
                          text: fileNames[index],
                          size: fontLabel,
                          color: dark,
                          overflow: TextOverflow.ellipsis,
                        ),
                        PoppinsTextWidget(
                          text: fileTypes[index],
                          size: fontBody,
                          color: dark,
                          overflow: TextOverflow.ellipsis,
                        ),
                        PoppinsTextWidget(
                          text: fileSizes[index],
                          size: fontBody,
                          color: dark,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // IconButton(
                        //     onPressed: () {},
                        //     icon: Icon(
                        //       Icons.download_rounded,
                        //       color: dark,
                        //     ))
                      ],
                    )),
              ));
        }));
  }

  Widget buildData(String fileDocId, String field /* from Firestore */,
      double fontSize, Color fontColor, bool isBold) {
    return FutureBuilder<DocumentSnapshot>(
        future: userDoc.collection('files').doc(fileDocId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Text("Loading...");
            // return const Center(child: CircularProgressIndicator());
          }
          var document = snapshot.data!;
          return PoppinsTextWidget(
            text: document[field].toString(),
            size: fontSize,
            color: fontColor,
            isBold: isBold,
          );
        });
  }

  Future buildFilesFuture(String fileDocId) async {
    var fileRef = FirebaseFirestore.instance
        .collection('users')
        .doc(UserAuth().currentUser!.uid)
        .collection('files');
    // .doc(fileDocId);
    return FutureBuilder(
        future: fileRef.get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var document = snapshot.data!;
            return SizedBox(
                height: 200,
                child: Row(
                  children: [
                    /* buildFilesLV(), */
                    ListView.builder(
                        itemCount: files.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              buildData(files[index], 'file_name', fontLabel,
                                  dark, false)
                            ],
                          );
                        })
                  ],
                )); //TODO
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
