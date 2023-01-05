import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hospal/api/user_auth.dart';
import 'package:hospal/widgets/custom_button_widget.dart';
import 'package:hospal/widgets/text_nunito_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/style.dart';
import '../../../widgets/text_poppins_widget.dart';

class JobseekerFileStoragePage extends StatefulWidget {
  const JobseekerFileStoragePage({Key? key}) : super(key: key);

  @override
  State<JobseekerFileStoragePage> createState() =>
      _JobseekerFileStoragePageState();
}

class _JobseekerFileStoragePageState extends State<JobseekerFileStoragePage> {
  double maxStorageSpace =
      1000; //1,000 MB (or 1 GB) of free file storage space is given to Jobseekers by default.
  double usedStorageSpace = 990;
  bool isStorageEnough = true;
  PlatformFile? selectedFileToUpload; //New file to upload
  UploadTask? uploadTask;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsedFileStorage();
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      selectedFileToUpload = result.files.first;
    });
  }

  void updateUsedFileStorage(double totalSize) {
    setState(() {
      usedStorageSpace = totalSize;
    });
  }

  Future<void> getUsedFileStorage() async {
    double usedStorage = 0;
    //double usedStorage = usedStorageSpace //For checking if the available space is to be exceeded.
    try {
      var ref = await FirebaseFirestore.instance
          .collection('users')
          .doc(UserAuth().currentUser!.uid)
          .collection('files')
          .get();
      // double usedStorage = 0;
      // for (var i = 0; i < ref.size; i++) {
      //   usedStorage +=
      //       double.parse(ref.docs[i]['file_size'].toString().split(' ')[0]);
      // }
      for (var element in ref.docs) {
        usedStorage +=
            double.parse(element['file_size'].toString().split(' ')[0]);
      }
      // return usedStorage;

    } on Exception catch (e) {
      if (kDebugMode) print(e);
      // return usedStorage;
    }
    setState(() {
      usedStorageSpace = usedStorage;
    });
  }

  Widget buildLinearProgressIndicator() {
    // getUsedFileStorage().then((double val) {
    //   setState(() {
    //     usedStorageSpace = val;
    //   });
    // });
    // double usedStorage;
    return LinearProgressIndicator(
      value: usedStorageSpace / maxStorageSpace,
      backgroundColor: blueTheme.shade100,
      color: midBlue,
    );
  }

  _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
  //TEMP funcs (Can be copied to API and used from there)

  Future uploadFile() async {
    try {
      final path =
          'files/${UserAuth().currentUser!.uid}/${selectedFileToUpload!.name}';
      final file = File(selectedFileToUpload!.path!);
      final firestoreRef = FirebaseFirestore.instance
          .collection('users')
          .doc(UserAuth().currentUser!.uid);
      final storageRef = FirebaseStorage.instance.ref().child(path);

      //Upload file to storage
      uploadTask = storageRef.putFile(file);
      final snapshot = await uploadTask!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      if (kDebugMode) print('Download URL: $urlDownload');

      //Upload file details to firestore
      firestoreRef.collection('files').doc().set({
        'file_id': selectedFileToUpload!.hashCode,
        'file_name': selectedFileToUpload!.name,
        'file_size':
            '${(selectedFileToUpload!.size / 1000000).toStringAsFixed(2)} MB', //TODO: Improve byte conversion
        'file_type': selectedFileToUpload!.extension,
        'download_url': urlDownload
      });
      if (kDebugMode) print('File uploaded successfully!');
    } on Exception catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Widget buildUploadProgress() {
    return StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return progress == 1
                ? Container(width: 0)
                : Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: space12, horizontal: space8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NunitoTextWidget(
                            text: progress != 1
                                ? 'Uploading file...'
                                : 'Upload complete!',
                            size: fontLabel,
                            color: darkBlue),
                        y4,
                        Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(space20)),
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    backgroundColor: softBlue,
                                    color: darkBlue,
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: space10),
                                  child: NunitoTextWidget(
                                      text:
                                          '${(100 * progress).roundToDouble()}%',
                                      size: fontBody,
                                      color: darkBlue),
                                ))
                          ],
                        )
                      ],
                    ),
                  );
          } else {
            return Container(
              width: 0,
            );
          }
        }));
  }

  Future<ListResult> listFilesFromStorage() async {
    final path = 'files/${UserAuth().currentUser!.uid}/';
    final results = await FirebaseStorage.instance.ref(path).listAll();
    for (var ref in results.items) {
      if (kDebugMode) print('Found file: $ref');
    }
    return results;
  }

  Stream<QuerySnapshot> getFileSnapshotsFromFirestore() {
    final snapshots = FirebaseFirestore.instance
        .collection('users')
        .doc(UserAuth().currentUser!.uid)
        .collection('files')
        .snapshots();
    return snapshots;
  }

  Widget buildFilesStreamBuilder() {
    return StreamBuilder<QuerySnapshot>(
        stream: getFileSnapshotsFromFirestore(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: darkBlue),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: NunitoTextWidget(
                  text: 'Oops! Something went wrong.\nTry refreshing',
                  size: fontLabel,
                  color: dark),
            );
          }
          final data = snapshot.requireData;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: space8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NunitoTextWidget(
                        text: 'Files (${data.size.toString()})',
                        size: fontHeader,
                        isBold: true,
                        color: darkBlue),
                    IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.refresh,
                          color: darkBlue,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      // double totalSize = 0;
                      // double size;
                      // for (var i = 0; i < data.size; i++) {
                      //   size = double.parse(
                      //       data.docs[i]['file_size'].toString().split(' ')[0]);
                      //   totalSize += size;
                      // }
                      // updateUsedFileStorage(totalSize);
                      return Container(
                        margin: EdgeInsets.only(bottom: space12),
                        padding: pad20,
                        decoration: BoxDecoration(
                            color: midBlue, borderRadius: bRadius18),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // PoppinsTextWidget(
                              //   text: '${data.docs[index]['file_type']}'
                              //       .toString()
                              //       .toUpperCase(),
                              //   size: fontHeader,
                              //   color: light,
                              //   isBold: true,
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  NunitoTextWidget(
                                    text: data.docs[index]['file_name'],
                                    size: fontLabel,
                                    color: light,
                                    isBold: true,
                                  ),
                                  PoppinsTextWidget(
                                    text: data.docs[index]['file_type']
                                        .toString()
                                        .toUpperCase(),
                                    size: fontBody,
                                    color: light,
                                    // isBold: true,
                                  ),
                                  NunitoTextWidget(
                                    text: data.docs[index]['file_size'],
                                    size: fontBody,
                                    color: light,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  // x10,
                                  (data.docs[index]['file_type']
                                                  .toString()
                                                  .toLowerCase() ==
                                              'jpg' ||
                                          data.docs[index]['file_type']
                                                  .toString()
                                                  .toLowerCase() ==
                                              'png')
                                      ? IconButton(
                                          onPressed: () {
                                            _launchUrl(data.docs[index]
                                                ['download_url']);
                                          },
                                          icon: Icon(
                                            Icons.download_for_offline_rounded,
                                            color: light,
                                          ),
                                          tooltip:
                                              'Download file (Only available for images)',
                                        )
                                      : Container(
                                          width: 0,
                                        ),
                                  IconButton(
                                      tooltip: 'Delete file',
                                      onPressed: () {
                                        removeFileFromStorage(
                                            data.docs[index]['file_name']);
                                        removeFileFromFirestore(
                                            data.docs[index].id);
                                        getUsedFileStorage();
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: light,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ]),
                      );
                    }),
              ),
            ],
          );
        });
  }

  Widget buildFilesFutureBuilder() {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('users')
        .doc(UserAuth().currentUser!.uid)
        .collection('files');
    return FutureBuilder(
        future: collectionReference.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var documents = snapshot.data!.docs;
            return Column(
              children: [
                NunitoTextWidget(
                    text: 'Files (${documents.length})',
                    size: fontLabel,
                    color: darkBlue),
                IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: darkBlue,
                    )),
                y8,
                ListView(
                  children: documents
                      .map((document) => Container(
                            decoration: BoxDecoration(color: midBlue),
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: space12),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(document['file_name']),
                                    Text(document['file_size'])
                                  ],
                                )
                              ]),
                            ),
                          ))
                      .toList(),
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(color: midBlue),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: PoppinsTextWidget(
                text: 'No files found.',
                size: fontLabel,
                color: grey,
                isBold: true,
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(color: midBlue),
          );
        });
  }

  void removeFileFromStorage(String fileName) {
    FirebaseStorage _storage = FirebaseStorage.instance;
    String ref = 'files/${UserAuth().currentUser!.uid}/$fileName';
    try {
      _storage.ref(ref).delete();
      if (kDebugMode) print('>> File deleted from FB Storage.');
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  void removeFileFromFirestore(String fileDoc) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      _firestore
          .collection('users')
          .doc(UserAuth().currentUser!.uid)
          .collection('files')
          .doc(fileDoc)
          .delete();
      if (kDebugMode) print('>> File deleted from FB Firestore.');
    } on Exception catch (e) {
      if (kDebugMode) print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // getUsedFileStorage();
    return Scaffold(
      backgroundColor: softGrey,
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: space18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            y20,
            PoppinsTextWidget(
                text: "My Files", size: 64, isBold: true, color: midBlue),
            Divider(
              height: space40,
            ),
            //TODO: Storage space calculation.
            Padding(
              padding: EdgeInsets.symmetric(vertical: space8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NunitoTextWidget(
                      text: "Storage Space",
                      size: fontLabel,
                      isBold: true,
                      color: grey),
                  y4,
                  NunitoTextWidget(
                      text:
                          "You've used ${usedStorageSpace.toStringAsFixed(2)} MB (${(usedStorageSpace * 100 / maxStorageSpace).toStringAsFixed(2)}%) of $maxStorageSpace MB (1 GB).",
                      size: fontLabel,
                      color: grey),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: space8),
                    height: space10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(space20)),
                      child: buildLinearProgressIndicator(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: NunitoTextWidget(
                        text:
                            'Remaining space: ${(maxStorageSpace - usedStorageSpace).toStringAsFixed(2)} MB',
                        size: fontBody,
                        isBold: true,
                        color: grey),
                  )
                ],
              ),
            ),
            y10,
            CustomButtonWidget(
              label: 'Upload from Google Drive',
              onTap: () async {
                await selectFile();
                if (maxStorageSpace -
                        usedStorageSpace -
                        (selectedFileToUpload!.size / 1000000) >=
                    0) {
                  await uploadFile();
                  getUsedFileStorage();
                  if (!isStorageEnough) {
                    setState(() {
                      isStorageEnough = true;
                    });
                  }
                } else {
                  setState(() {
                    isStorageEnough = false;
                  });
                }
                // initState();
                listFilesFromStorage().toString(); //TODO remove
              },
              icon: Icons.add_to_drive_outlined,
              backgroundColor: darkBlue,
            ),
            isStorageEnough
                ? Container(
                    width: 0,
                  )
                : Padding(
                    padding: EdgeInsets.only(top: space20),
                    child: Center(
                      child: NunitoTextWidget(
                          text:
                              'Insufficient space! Try removing some unneeded files.',
                          size: fontLabel,
                          isBold: true,
                          color: Colors.red.shade900),
                    ),
                  ),
            uploadTask == null
                ? Container(
                    width: 0,
                  )
                : buildUploadProgress(),
            y20,
            buildFilesStreamBuilder(),
            // Padding(
            //   padding: EdgeInsets.only(bottom: space20),
            //   child: Container(
            //     //TODO: Remove?
            //     padding: pad12,
            //     height: 250, //TODO: May remove/change
            //     decoration: BoxDecoration(
            //         borderRadius: bRadius20,
            //         border: Border.all(color: midBlue)),
            //     // child: Column(children: [
            //     //   //TODO: Column may be replaced w gridlayout
            //     // ]),
            //   ),
            // ),
            // y20,
          ],
        ),
      )),
    );
  }
}
