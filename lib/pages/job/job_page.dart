import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import '../../constants/style.dart';
import '../../widgets/text_poppins_widget.dart';
import '../home_page.dart';

class JobPage extends StatefulWidget {
  final String? docId; //TODO: Remove ?

  const JobPage({Key? key, this.docId}) : super(key: key);

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  //Data to be obtained from Firestore
  String? jobTitle;
  String? jobDescription;

  String? jobType;
  int? jobSalary;
  int? jobDuration; //TODO: Add to FB
  String? jobLevel; //TODO: Add to FB

  String? jobSkills;
  String? jobRequirements;

  String? companyName;
  String? companyAddress;
  String? companyDescription;
  String? companyLogoURL;
  String? companyLogoName; //TODO: Remove if unused (in the future)

  DateTime? publicationDate;
  DateTime? publicationTime;

  CollectionReference collection =
      FirebaseFirestore.instance.collection('jobs');

  Future getData() async {
    // var docSnapshot = await collection.doc(widget.docId).get();
    // if (docSnapshot.exists) {
    //   Map<String, dynamic> data = docSnapshot.data()!;
    //   var name = data['job_title'];
    // }
    return await collection.get();
  }

  Widget buildData(String field /* from Firestore */, double fontSize,
      Color fontColor, bool isBold) {
    return FutureBuilder<DocumentSnapshot>(
        future: collection.doc(widget.docId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // return const Text("Loading...");
            return const Center(child: CircularProgressIndicator());
          }
          var document = snapshot.data;
          return PoppinsTextWidget(
            text: document![field].toString(),
            size: fontSize,
            color: fontColor,
            isBold: isBold,
          );
        });
  }

  Widget buildWhenPosted() {
    return FutureBuilder<DocumentSnapshot>(
        future: collection.doc(widget.docId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // return const Text("Loading...");
            return const Center(child: CircularProgressIndicator());
          }
          var document = snapshot.data!;
          var a = document['publication_date'],
              b = document['publication_time'];

          Widget getWhenPosted(String date, String time) {
            //Notes:
            //Date format: dd/mm/yyyy
            //Time format: hh:mm (24h)
            var currentDateTime = DateTime.now();
            String
                result; //Posted $answer $differentialUnits ago OR Posted on date, time.
            String differentialTerm; //From: minutes -> years

            var a = date.split('/');
            var b = a[0] + '-' + a[1] + '-' + a[2];

            String publishedWhen = date + ' ' + time;
            DateTime published = DateTime.tryParse(publishedWhen)!;

            if (kDebugMode) {
              print(published);
            }

            if (published == null) published = DateTime.now();

            return PoppinsTextWidget(
              text: published.toString(),
              size: fontLabel,
              color: dark.withOpacity(.4),
              isBold: false,
            );
          }

          return getWhenPosted(a, b);
          // return PoppinsTextWidget(
          //   text: '...',
          //   size: fontLabel,
          //   color: dark.withOpacity(.4),
          //   isBold: false,
          // );
        });
  }

  @override
  Widget build(BuildContext context) {
    // jobTitle = collection.doc(widget.docId).get();
    return Scaffold(
        appBar: AppBar(
          title: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            child: PoppinsTextWidget(
              text: 'GigHub',
              color: light,
              size: fontTitle,
              isBold: true,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: dark,
          leading: Padding(
              padding: EdgeInsets.only(
                  left: space18, top: space12, right: space12, bottom: space12),
              child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {},
                  child: Icon(Icons.menu_rounded, color: light, size: 28))),
          actions: [
            InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                // hoverColor: Colors.transparent,
                onTap: () {},
                child: Icon(Icons.person, color: light, size: 28)),
            x10,
            x8,
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              y20,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 15, left: 200),
                      child: PoppinsTextWidget(
                        text: 'Job Details',
                        size: fontHeader,
                        color: dark,
                        isBold: true,
                      )),
                ],
              ),
              y10,
              y4,
              Padding(
                padding: const EdgeInsets.only(left: 170, right: 170),
                child: SizedBox(
                  height: 500,
                  child: Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.black.withOpacity(.4), width: .5),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 6),
                                color: Colors.grey.withOpacity(.1),
                                blurRadius: 12)
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 4,
                              child: Center(
                                child: Column(children: [
                                  Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: buildData(
                                          'job_title',
                                          fontSubtitle,
                                          dark,
                                          true) /* PoppinsTextWidget(
                                      text: "IT Intern",
                                      size: fontSubtitle,
                                      color: dark,
                                      isBold: true,
                                    ), */
                                      ),
                                  Divider(
                                    thickness: 0.5,
                                    color: Colors.black.withOpacity(.4),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        buildData('company_name', fontLabel,
                                            Colors.blue, true)
                                        // Text(
                                        //   "Mobile App Development Company",
                                        //   style: GoogleFonts.roboto(
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 15,
                                        //       color: Colors.lightBlue),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10),
                                    // child: buildWhenPosted() //TODO: Uncomment
                                    child: Row(
                                      children: [
                                        Text(
                                          "Posted 6 hours ago",
                                          style: GoogleFonts.roboto(
                                              fontSize: 15,
                                              color:
                                                  Colors.black.withOpacity(.4)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            color: Colors.blue),
                                        x8,
                                        buildData('company_address', fontLabel,
                                            dark, false)
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    color: Colors.black.withOpacity(.4),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Job Description",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: dark),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 0),
                                      child: buildData('job_description',
                                          fontLabel, dark, false)),
                                  Divider(
                                    thickness: 0.5,
                                    color: Colors.black.withOpacity(.4),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: space10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.monetization_on,
                                                      color: dark),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: space4),
                                                    child: Row(
                                                      children: [
                                                        PoppinsTextWidget(
                                                          text: 'MYR',
                                                          size: fontLabel,
                                                          color: dark,
                                                          isBold: true,
                                                        ),
                                                        x4,
                                                        buildData(
                                                            'job_pay_from',
                                                            fontLabel,
                                                            dark,
                                                            true),
                                                        PoppinsTextWidget(
                                                          text: '  -  ',
                                                          size: fontLabel,
                                                          color: dark,
                                                          isBold: true,
                                                        ),
                                                        buildData(
                                                            'job_pay_till',
                                                            fontLabel,
                                                            dark,
                                                            true),
                                                      ],
                                                    ),
                                                  )
                                                  // Text(
                                                  //   "  RM 1250 - 2500",
                                                  //   style: GoogleFonts.roboto(
                                                  //       fontWeight:
                                                  //           FontWeight.bold,
                                                  //       fontSize: 15,
                                                  //       color: dark),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Text(
                                                "Income",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 13,
                                                    color:
                                                        dark.withOpacity(.4)),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.calendar_month,
                                                    color: dark),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: space4),
                                                  child: buildData(
                                                      'job_duration',
                                                      fontLabel,
                                                      dark,
                                                      true),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Text(
                                                "Duration",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 13,
                                                    color:
                                                        dark.withOpacity(.4)),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.category,
                                                    color: dark),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: space4),
                                                    child: buildData('job_type',
                                                        fontLabel, dark, true))
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                " Job type",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 13,
                                                    color:
                                                        dark.withOpacity(.4)),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.psychology,
                                                    color: dark),
                                                Text(
                                                  "  Intermediate",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: dark),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "Job Level",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 13,
                                                  color: dark.withOpacity(.4)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Divider(
                                      thickness: 0.5,
                                      color: Colors.black.withOpacity(.4),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 20),
                                    child: Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Job Requirements & Skills",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: dark),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, top: 10),
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            border: Border.all(
                                                color: dark.withOpacity(.4)),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "Bachelor's Degree",
                                          style: GoogleFonts.roboto(
                                              fontSize: 13, color: dark),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, top: 10),
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            border: Border.all(
                                                color: dark.withOpacity(.4)),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "Mobile App Development",
                                          style: GoogleFonts.roboto(
                                              fontSize: 13, color: dark),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, top: 10),
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            border: Border.all(
                                                color: dark.withOpacity(.4)),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "Web Development",
                                          style: GoogleFonts.roboto(
                                              fontSize: 13, color: dark),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, top: 10),
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            border: Border.all(
                                                color: dark.withOpacity(.4)),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "IOS",
                                          style: GoogleFonts.roboto(
                                              fontSize: 13, color: dark),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, top: 10),
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            border: Border.all(
                                                color: dark.withOpacity(.4)),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "Android",
                                          style: GoogleFonts.roboto(
                                              fontSize: 13, color: dark),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, top: 10),
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            border: Border.all(
                                                color: dark.withOpacity(.4)),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "Communication Skills",
                                          style: GoogleFonts.roboto(
                                              fontSize: 13, color: dark),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, top: 10),
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            border: Border.all(
                                                color: dark.withOpacity(.4)),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "Teamwork",
                                          style: GoogleFonts.roboto(
                                              fontSize: 13, color: dark),
                                        ),
                                      ),
                                    ],
                                  )
                                ]),
                              ),
                            ),
                            VerticalDivider(
                              thickness: 0.5,
                              color: Colors.black.withOpacity(.4),
                            ),
                            Flexible(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 10, right: 10),
                                      child: SizedBox(
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              primary: dark,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                          child: Center(
                                            child: PoppinsTextWidget(
                                                text: "Apply",
                                                size: fontLabel,
                                                color: light),
                                          ),
                                        ),
                                      ),
                                    ),
                                    y10,
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 10, right: 10),
                                      child: SizedBox(
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              primary: light,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.favorite,
                                                color: Colors.black,
                                              ),
                                              x10,
                                              PoppinsTextWidget(
                                                  text: "Save Job",
                                                  size: fontLabel,
                                                  color: dark),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    y10,
                                    Divider(
                                      thickness: 0.5,
                                      color: Colors.black.withOpacity(.4),
                                    ),
                                    y10,
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "About the company",
                                            style: GoogleFonts.oswald(
                                                color: dark,
                                                fontSize: fontHeader,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    y8,
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Name: ",
                                            style: GoogleFonts.openSans(
                                                color: dark.withOpacity(.4),
                                                fontSize: fontLabel),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: buildData(
                                                  'company_name',
                                                  fontLabel,
                                                  dark.withOpacity(.4),
                                                  false)),
                                        ],
                                      ),
                                    ),
                                    y8,
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Location: ",
                                            style: GoogleFonts.openSans(
                                                color: dark.withOpacity(.4),
                                                fontSize: fontLabel),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: buildData(
                                                  'company_address',
                                                  fontLabel,
                                                  dark.withOpacity(.4),
                                                  false)),
                                        ],
                                      ),
                                    ),
                                    y8,
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Description: ",
                                              style: GoogleFonts.openSans(
                                                  color: dark.withOpacity(.4),
                                                  fontSize: fontLabel),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: buildData(
                                                    'company_info',
                                                    fontLabel,
                                                    dark.withOpacity(.4),
                                                    false)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    y8,
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Logo",
                                                style: GoogleFonts.openSans(
                                                    color: dark.withOpacity(.4),
                                                    fontSize: fontLabel),
                                              ),
                                            ])),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        Icon(Icons.image,
                                            size: 200, color: Colors.black),
                                      ],
                                    )
                                  ],
                                )),
                          ],
                        )),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
