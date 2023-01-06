import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospal/api/user_auth.dart';

import '../../../api/screen_responsiveness/dimensions.dart';
import '../../../constants/style.dart';
import '../../../widgets/text_poppins_widget.dart';
import '../../job/job_details_page.dart';

class EmployerPostHistoryPage extends StatefulWidget {
  const EmployerPostHistoryPage({Key? key}) : super(key: key);

  @override
  State<EmployerPostHistoryPage> createState() =>
      _EmployerPostHistoryPageState();
}

class _EmployerPostHistoryPageState extends State<EmployerPostHistoryPage> {
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileWidth;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: light,
        padding: EdgeInsets.symmetric(horizontal: space20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              y20,
              PoppinsTextWidget(
                  text: "My Job Posts",
                  size: 64,
                  isBold: true,
                  color: midOrange),
              Divider(
                height: space40,
              ),
              SafeArea(
                child: SizedBox(height: 400, child: buildJobListings()),
              ),
            ],
          ),
        ));
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
                                borderRadius: bRadius20,
                                border: Border.all(color: silver)),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  size: fontLabel,
                                                  color: dark,
                                                  isBold: true,
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
