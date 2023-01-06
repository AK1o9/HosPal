import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:hospal/api/screen_responsiveness/dimensions.dart';
import 'package:hospal/api/user_auth.dart';
import 'package:hospal/pages/job/job_details_page.dart';
import 'package:hospal/pages/job/job_custom_search_page.dart';
import 'package:hospal/widgets/text_poppins_widget.dart';
import 'package:flutter/material.dart';
import 'package:hospal/widgets/textfield_widget.dart';
import '../../../constants/style.dart';
import '../../../widgets/custom_button_widget.dart';
import '../../../widgets/text_nunito_widget.dart';
import '../../job/job_application_details_page.dart';

class EmployerHomePage extends StatefulWidget {
  const EmployerHomePage({Key? key}) : super(key: key);

  @override
  State<EmployerHomePage> createState() => _EmployerHomePageState();
}

class _EmployerHomePageState extends State<EmployerHomePage> {
  final searchController = TextEditingController();
  List<String> applicationIds = [];

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileWidth;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileWidth;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() => setState(() {}));
    getApplicationIds();
  }

  getApplicationIds() async {
    await FirebaseFirestore.instance
        .collection('applications')
        .where('employer_id', isEqualTo: UserAuth().currentUser!.uid)
        .get()
        .then((value) {
      for (var doc in value.docs) {
        setState(() {
          applicationIds.add(doc.id);
        });
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void clearAll() {
    searchController.clear();
    //NOTE: May also include other controllers in the page.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light,
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(left: space18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            y20,
            PoppinsTextWidget(
                text: "Home", size: 64, isBold: true, color: midOrange),
            Divider(
              height: space40,
            ),
            buildJobApplications(),
            Container(
              margin: EdgeInsets.only(
                  top: space20, right: space20, bottom: space20),
              padding: pad20,
              decoration:
                  BoxDecoration(borderRadius: bRadius20, color: darkOrange),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PoppinsTextWidget(
                        text: 'MY POSTS',
                        size: fontTitle,
                        color: light,
                        isBold: true,
                      ),
                      isMobile(context)
                          ? Container(
                              width: 0,
                            )
                          : IconButton(
                              padding: EdgeInsets.only(right: space10),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            super.widget));
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: light,
                                size: 28,
                              ))
                    ],
                  ),
                  isMobile(context) ? y4 : y20,
                  SafeArea(
                    child: SizedBox(height: 512, child: buildJobListings()),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget buildLogo(String jobId, String imageName) {
    var image = FirebaseStorage.instance
        .ref()
        .child('jobs')
        .child(jobId)
        .child(imageName);
    return FutureBuilder(
        future: image.getDownloadURL(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Image.network(snapshot.data!, fit: BoxFit.cover);
          }
          return Icon(
            Icons.photo_rounded,
            color: grey,
            size: 45,
          );
        });
  }

  Widget buildJobApplications() {
    return Container(
      margin: EdgeInsets.only(top: space20, right: space20),
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 0),
      decoration: BoxDecoration(borderRadius: bRadius20, color: darkOrange),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PoppinsTextWidget(
            text: 'APPLICANTS',
            size: fontTitle,
            color: light,
            isBold: true,
          ),
          y20,
          SafeArea(child: buildJobApplicationsLV())
        ],
      ),
    );
  }

  Widget buildJobApplicationsLV() {
    var ref = FirebaseFirestore.instance.collection('applications');
    return FutureBuilder<QuerySnapshot>(
        future: ref
            .where('employer_id', isEqualTo: UserAuth().currentUser!.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var documents = snapshot.data!.docs;
            return SizedBox(
                height: 200,
                child: ListView.builder(
                    itemCount: documents.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildApplicationCard(context, documents[index]);
                    }));
          } else if (snapshot.hasError) {
            return Center(
              child: PoppinsTextWidget(
                  text: 'Oops, something went wrong!\nTry refreshing the page.',
                  size: fontLabel,
                  color: grey),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(color: midBlue),
            );
          }
        });
  }

  Widget buildApplicationCard(BuildContext context, QueryDocumentSnapshot doc) {
    // String companyName = getJobCompanyName(doc['job_id']).toString();
    // String companyAddress = eleme;
    return SizedBox(
      height: 200,
      width: 260,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => JobApplicationDetailsPage(
                    docId: doc.id,
                    isEmployerView: true,
                  )));
        },
        child: Card(
            shape: RoundedRectangleBorder(borderRadius: bRadius20),
            color: light,
            margin: EdgeInsets.only(right: space30),
            child: Padding(
              padding: pad20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: pad10,
                      decoration: BoxDecoration(
                          borderRadius: bRadius20, color: darkOrange),
                      child: Center(
                        child: PoppinsTextWidget(
                            text: doc['full_name'],
                            size: fontLabel,
                            isBold: true,
                            isCenter: true,
                            overflow: TextOverflow.ellipsis,
                            color: light),
                      )),
                  // y30,
                  Divider(
                    height: space30,
                    color: darkOrange,
                  ),
                  SizedBox(
                    width: 220,
                    child: PoppinsTextWidget(
                      text: doc['job_title'],
                      size: fontHeader,
                      overflow: TextOverflow.ellipsis,
                      color: dark,
                      isBold: true,
                    ),
                  ),
                  y4,
                  SizedBox(
                    width: 220,
                    child: PoppinsTextWidget(
                      text: doc['company_name'],
                      size: fontSubheader,
                      overflow: TextOverflow.ellipsis,
                      color: dark,
                      // isBold: true,
                    ),
                  ),
                  y4,
                  SizedBox(
                    width: 220,
                    child: PoppinsTextWidget(
                      overflow: TextOverflow.ellipsis,
                      text: doc['company_address'],
                      size: fontLabel,
                      color: dark,
                      // isBold: true,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget buildJobListings() {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('jobs');
    return FutureBuilder<QuerySnapshot>(
        future: collection
            .where('employer_id', isEqualTo: UserAuth().currentUser!.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var documents = snapshot.data!.docs;
            return ListView(
              children: documents
                  .map((document) => Card(
                        margin: EdgeInsets.symmetric(vertical: space10),
                        shape: RoundedRectangleBorder(borderRadius: bRadius20),
                        color: light,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => JobPage(
                                    docId: document.id,
                                    isEmployerView: true,
                                    employerId: document['employer_id'])));
                          },
                          child: Container(
                            height: isMobile(context) ? 210 : 120,
                            padding: isMobile(context)
                                ? pad18
                                : EdgeInsets.only(
                                    top: space10,
                                    bottom: space10,
                                    left: space20,
                                    right: space20),
                            decoration: BoxDecoration(
                                borderRadius: bRadius20, color: light),
                            child: Column(
                                mainAxisAlignment: isMobile(context)
                                    ? MainAxisAlignment.start
                                    : MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(space10),
                                            width: 72,
                                            height: 72,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        space12),
                                                color: silver),
                                            child: Icon(
                                              Icons.photo_rounded,
                                              color: grey,
                                              size: 45,
                                            ),
                                          ),
                                          x20,
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              isMobile(context)
                                                  ? y4
                                                  : Container(
                                                      width: 0,
                                                    ),
                                              SizedBox(
                                                width: 150,
                                                child: PoppinsTextWidget(
                                                  text: document['job_title'],
                                                  size: fontLabel,
                                                  color: dark,
                                                  isBold: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              isMobile(context) ? y8 : y4,
                                              isMobile(context)
                                                  ? Container(
                                                      padding: pad8,
                                                      decoration: BoxDecoration(
                                                          /* borderRadius:
                                                          bRadius20, */
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          8),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          8)),
                                                          color: darkBlue),
                                                      child: PoppinsTextWidget(
                                                          text: document[
                                                              'job_type'],
                                                          size: fontBody,
                                                          color: light),
                                                    )
                                                  : Row(
                                                      children: [
                                                        PoppinsTextWidget(
                                                          text: document[
                                                              'company_name'],
                                                          size: fontLabel,
                                                          color: dark,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        x10,
                                                        PoppinsTextWidget(
                                                          text: '|',
                                                          size: fontLabel,
                                                          color: dark,
                                                        ),
                                                        x10,
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child:
                                                              PoppinsTextWidget(
                                                            text: document[
                                                                'company_address'],
                                                            size: fontLabel,
                                                            color: dark,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                              y8,
                                              isMobile(context)
                                                  ? Container(
                                                      width: 0,
                                                    )
                                                  : Container(
                                                      padding: pad8,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              bRadius20,
                                                          color: dark),
                                                      child: PoppinsTextWidget(
                                                          text: document[
                                                              'job_type'],
                                                          size: fontLabel,
                                                          color: light),
                                                    )
                                            ],
                                          ),
                                        ],
                                      ),
                                      isMobile(context)
                                          ? Container(
                                              width: 0,
                                            )
                                          : Container(
                                              padding: pad8,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: /* Colors.lightGreenAccent */ dark),
                                                  borderRadius: bRadius20),
                                              child: PoppinsTextWidget(
                                                text:
                                                    'RM ${document['job_pay_from']} - ${document['job_pay_till']}',
                                                size: fontLabel,
                                                color:
                                                    dark, //Colors.lightGreen,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                    ],
                                  ),
                                  isMobile(context)
                                      ? y16
                                      : Container(
                                          width: 0,
                                        ),
                                  isMobile(context)
                                      ? Column(
                                          children: [
                                            Row(
                                                // mainAxisAlignment:
                                                //     MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 80,
                                                        child:
                                                            PoppinsTextWidget(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          text: document[
                                                              'company_name'],
                                                          size: fontLabel,
                                                          color: dark,
                                                          isBold: true,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  x10,
                                                  PoppinsTextWidget(
                                                    text: '|',
                                                    size: fontLabel,
                                                    color: dark,
                                                  ),
                                                  x10,
                                                  Flexible(
                                                    child: PoppinsTextWidget(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      text: document[
                                                          'company_address'],
                                                      size: fontLabel,
                                                      color: dark,
                                                    ),
                                                  ),
                                                ]),
                                            y16,
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                padding: pad8,
                                                decoration: BoxDecoration(
                                                    // border: Border.all(
                                                    //     color: /* Colors.lightGreenAccent */ dark),
                                                    color: Colors
                                                        .greenAccent.shade200,
                                                    borderRadius: bRadius20),
                                                child: PoppinsTextWidget(
                                                  text:
                                                      'RM ${document['job_pay_from']} - ${document['job_pay_till']}',
                                                  size: fontLabel,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.green
                                                      .shade900, //Colors.lightGreen,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : Container(
                                          width: 0,
                                        )
                                ]),
                          ),
                        ),
                      ))
                  .toList(),
            );
          } else if (snapshot.hasError) {
            return PoppinsTextWidget(
              text: 'Oops! Something went wrong...',
              size: fontLabel,
              color: light,
              isBold: true,
              isCenter: true,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

Widget buildApplicants() {
  CollectionReference collection =
      FirebaseFirestore.instance.collection('jobs');
  return FutureBuilder<QuerySnapshot>(
      future: collection.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var documents = snapshot.data!.docs;
          return ListView(
            children: documents
                .map((document) => Card(
                      shape: RoundedRectangleBorder(borderRadius: bRadius20),
                      color: dark,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => JobPage(
                                    docId: document.id,
                                    employerId: document['employer_id'],
                                  )));
                        },
                        child: Container(
                          height: 120,
                          padding: EdgeInsets.only(
                              top: space10,
                              bottom: space10,
                              left: space20,
                              right: space20),
                          decoration: BoxDecoration(
                              borderRadius: bRadius20, color: dark),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(space10),
                                          width: 72,
                                          height: 72,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      space12),
                                              color: light),
                                          child: Icon(
                                            Icons.photo_rounded,
                                            color: grey,
                                            size: 45,
                                          ),
                                        ),
                                        x20,
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            PoppinsTextWidget(
                                              text: document['job_title'],
                                              size: fontLabel,
                                              color: light,
                                              isBold: true,
                                            ),
                                            y4,
                                            Row(
                                              children: [
                                                PoppinsTextWidget(
                                                  text:
                                                      document['company_name'],
                                                  size: fontLabel,
                                                  color: light,
                                                ),
                                                x10,
                                                PoppinsTextWidget(
                                                  text: '|',
                                                  size: fontLabel,
                                                  color: light,
                                                ),
                                                x10,
                                                PoppinsTextWidget(
                                                  text: document[
                                                      'company_address'],
                                                  size: fontLabel,
                                                  color: light,
                                                ),
                                              ],
                                            ),
                                            y8,
                                            Container(
                                              padding: pad8,
                                              decoration: BoxDecoration(
                                                  borderRadius: bRadius30,
                                                  color: light),
                                              child: PoppinsTextWidget(
                                                  text: document['job_type'],
                                                  size: fontBody,
                                                  color: dark),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                      padding: pad8,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: /* Colors.lightGreenAccent */ dark),
                                          borderRadius: bRadius20),
                                      child: PoppinsTextWidget(
                                        text:
                                            'RM ${document['job_pay_from']} - ${document['job_pay_till']}',
                                        size: fontLabel,
                                        color: light, //Colors.lightGreen,
                                      ),
                                    )
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    ))
                .toList(),
          );
        } else if (snapshot.hasError) {
          return PoppinsTextWidget(
            text: 'Oops! Something went wrong...',
            size: fontLabel,
            color: light,
            isBold: true,
            isCenter: true,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      });
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class DataController /* extends GetxController */ {
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }

  Future queryData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('jobs')
        .where('job_title', isGreaterThanOrEqualTo: queryString)
        .get();
  }
}
