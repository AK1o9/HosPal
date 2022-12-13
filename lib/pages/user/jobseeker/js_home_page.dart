import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:hospal/api/screen_responsiveness/dimensions.dart';
import 'package:hospal/pages/job/job_details_page.dart';
import 'package:hospal/widgets/text_poppins_widget.dart';
import 'package:flutter/material.dart';
import 'package:hospal/widgets/textfield_widget.dart';
import '../../../constants/style.dart';
import '../../../widgets/custom_button_widget.dart';
import '../../job/job_custom_search_page.dart';

class JobseekerHomePage extends StatefulWidget {
  const JobseekerHomePage({Key? key}) : super(key: key);

  @override
  State<JobseekerHomePage> createState() => _JobseekerHomePageState();
}

class _JobseekerHomePageState extends State<JobseekerHomePage> {
  final searchController = TextEditingController();

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileWidth;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileWidth;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() => setState(() {}));
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      home: Scaffold(
        // appBar: AppBar(
        //   title: InkWell(
        //     splashColor: Colors.transparent,
        //     highlightColor: Colors.transparent,
        //     onTap: () {
        //       Navigator.of(context).pop();
        //       Navigator.of(context).push(MaterialPageRoute(
        //           builder: (context) => const JobseekerHomePage()));
        //     },
        //     child: PoppinsTextWidget(
        //       text: 'HosPal',
        //       color: light,
        //       size: fontTitle,
        //       isBold: true,
        //     ),
        //   ),
        //   centerTitle: true,
        //   elevation: 0,
        //   backgroundColor: midBlue,
        //   leading: Padding(
        //       padding: EdgeInsets.only(
        //           left: space18, top: space12, right: space12, bottom: space12),
        //       child: InkWell(
        //           splashColor: Colors.transparent,
        //           highlightColor: Colors.transparent,
        //           onTap: () {},
        //           child: Icon(Icons.menu_rounded, color: light, size: 28))),
        //   actions: [
        //     InkWell(
        //         splashColor: Colors.transparent,
        //         highlightColor: Colors.transparent,
        //         onTap: () {
        //           Navigator.of(context).push(MaterialPageRoute(
        //               builder: (context) => JobseekerProfilePage()));
        //         },
        //         child: Icon(Icons.person, color: light, size: 28)),
        //     x10,
        //     x8,
        //   ],
        // ),
        backgroundColor: softGrey,
        body: Container(
          margin: EdgeInsets.only(left: isMobile(context) ? space12 : space18),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //'Welcome back' Message

              // y30,
              // PoppinsTextWidget(
              //   text: "Welcome back, Ahmed.\nLet's find you a job!",
              //   size: fontSubtitle,
              //   color: dark,
              // ),

              y20,
              PoppinsTextWidget(
                  text: "Home", size: 64, isBold: true, color: midBlue),
              Divider(
                height: space40,
              ),
              Container(
                margin: EdgeInsets.only(
                    right: isMobile(context) ? space12 : space20),
                padding: pad10,
                decoration:
                    BoxDecoration(borderRadius: bRadius20, color: softGrey),
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(right: space18),
                    child: Row(children: [
                      //Search bar
                      Expanded(
                        flex: isMobile(context) ? 4 : 10,
                        child: TextfieldWidget(
                          colorTheme: blueTheme,
                          labelText: 'Job title, company name or keyword',
                          controller: searchController,
                          icon: Icon(Icons.search_outlined,
                              color: midBlue //or aqua,
                              ),
                        ),
                      ),

                      //Filter button (for search results) //TODO: Remove or replace in the search delegate.
                      // Expanded(
                      //   child: InkWell(
                      //     hoverColor: Colors.transparent,
                      //     splashColor: Colors.transparent,
                      //     highlightColor: Colors.transparent,
                      //     onTap: () {
                      //       //Filter
                      //     },
                      //     child: Container(
                      //         height: space50,
                      //         width: space50,
                      //         margin: EdgeInsets.only(left: space12),
                      //         decoration: BoxDecoration(
                      //             color: dark, borderRadius: bRadius12),
                      //         child: Icon(Icons.filter_alt_rounded,
                      //             color: light, size: 24)),
                      //   ),
                      // ),

                      //Search button
                      if (isMobile(context) && searchController.text != '')
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: isMobile(context) ? space8 : space10),
                            child: CustomButtonWidget(
                                icon: Icons.search_rounded,
                                label: 'Search',
                                color: midBlue,
                                onTap: () {
                                  // showSearch(
                                  //     context: context, delegate: MySearchDelegate());
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => JobCustomSearchPage(
                                            query: searchController.text,
                                          )));
                                }),
                          ),
                        )
                      else
                        Container(width: 0),
                    ]),
                  ),
                ]),
              ),
              Container(
                margin: EdgeInsets.only(top: space20, right: space20),
                padding: const EdgeInsets.only(
                    left: 20, top: 20, bottom: 20, right: 0),
                decoration:
                    BoxDecoration(borderRadius: bRadius20, color: midBlue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PoppinsTextWidget(
                      text: 'FEATURED',
                      size: fontTitle,
                      color: light,
                      isBold: true,
                    ),
                    isMobile(context) ? y4 : y20,
                    SafeArea(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          buildSampleJobTile(),
                          buildSampleJobTile(),
                          buildSampleJobTile(),
                          buildSampleJobTile(),
                          buildSampleJobTile(),
                          buildSampleJobTile(),
                          buildSampleJobTile(),
                          buildSampleJobTile(),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: space20, right: space20),
                padding: const EdgeInsets.only(
                    left: 20, top: 20, bottom: 20, right: 0),
                decoration:
                    BoxDecoration(borderRadius: bRadius20, color: midBlue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PoppinsTextWidget(
                      text: 'NEAR YOU',
                      size: fontTitle,
                      color: light,
                      isBold: true,
                    ),
                    isMobile(context) ? y4 : y20,
                    SafeArea(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        buildSampleJobTile(),
                        buildSampleJobTile(),
                        buildSampleJobTile(),
                        buildSampleJobTile(),
                        buildSampleJobTile(),
                        buildSampleJobTile(),
                        buildSampleJobTile(),
                        buildSampleJobTile(),
                      ]),
                    ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: isMobile(context) ? space12 : space20,
                    right: isMobile(context) ? space12 : space20,
                    bottom: isMobile(context) ? space12 : space20),
                padding: pad20,
                decoration:
                    BoxDecoration(borderRadius: bRadius20, color: midBlue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PoppinsTextWidget(
                          text: 'BROWSE ALL JOBS',
                          size: fontTitle,
                          color: light,
                          isBold: true,
                        ),
                        isMobile(context)
                            ? IconButton(
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
                                  color: midBlue,
                                  size: 28,
                                ))
                            : Container(
                                width: 0,
                              )
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
          )),
        ),
      ),
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

  Widget buildJobTiles() {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('jobs').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs.map((document) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => JobPage(
                              docId: document.id,
                            )));
                  },
                  child: Container(
                    height: 200,
                    width: 260,
                    margin: EdgeInsets.only(right: space30),
                    padding: pad20,
                    decoration:
                        BoxDecoration(borderRadius: bRadius20, color: dark),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                      borderRadius: bRadius12, color: light),
                                  // TODO: Replace w/ logo
                                  child: SafeArea(
                                      child: buildLogo(
                                          document.id, document['logo_file'])
                                      // buildLogo('J-LLP1X68Fp6minnZ28rcg',
                                      //     'Glitch WP.jpg'),
                                      )
                                  // child: Icon(
                                  //   Icons.photo_rounded,
                                  //   color: grey,
                                  //   size: 45,
                                  // ),
                                  ),
                              Container(
                                padding: pad8,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.lightGreenAccent),
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
                          y20,
                          PoppinsTextWidget(
                            text: document['job_title'],
                            size: fontLabel,
                            color: light,
                            isBold: true,
                          ),
                          PoppinsTextWidget(
                            text: document['company_name'],
                            size: fontLabel,
                            color: light,
                          ),
                          PoppinsTextWidget(
                            text: document['company_address'],
                            size: fontLabel,
                            color: light,
                          )
                        ]),
                  ),
                );
              }).toList(),
            );
          }

          return const Center(child: CircularProgressIndicator());
        });
  }

//Sample Data
  Widget buildSampleJobTile() {
    return InkWell(
      onTap: () {
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => const JobPage()));
      },
      child: Container(
        height: 200,
        width: 260,
        margin: EdgeInsets.only(right: space30),
        padding: pad20,
        decoration: BoxDecoration(borderRadius: bRadius20, color: light),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: pad10,
                width: 72,
                height: 72,
                decoration:
                    BoxDecoration(borderRadius: bRadius12, color: silver),
                child: Icon(
                  Icons.photo_rounded,
                  color: grey,
                  size: 45,
                ),
              ),
              Container(
                padding: pad8,
                decoration: BoxDecoration(
                    /* border: Border.all(color: dark) */ color:
                        Colors.greenAccent.shade200,
                    borderRadius: bRadius20),
                child: PoppinsTextWidget(
                  text: 'RM 1250 - 2500',
                  size: fontLabel,
                  color: Colors.green.shade900, //Colors.lightGreen,
                ),
              )
            ],
          ),
          y20,
          PoppinsTextWidget(
            text: 'EMS Receptionist',
            size: fontLabel,
            color: dark,
            isBold: true,
          ),
          PoppinsTextWidget(
            text: 'Teczo Sdn. Bhd.',
            size: fontLabel,
            color: dark,
          ),
          PoppinsTextWidget(
            text: 'Kuala Lumpur, Malaysia',
            size: fontLabel,
            color: dark,
          )
        ]),
      ),
    );
  }

  Widget buildJobListings() {
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
                        margin: EdgeInsets.symmetric(vertical: space10),
                        shape: RoundedRectangleBorder(borderRadius: bRadius20),
                        color: light,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    JobPage(docId: document.id)));
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
                                              PoppinsTextWidget(
                                                text: document['job_title'],
                                                size: fontLabel,
                                                color: dark,
                                                isBold: true,
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
                                                        ),
                                                        x10,
                                                        PoppinsTextWidget(
                                                          text: '|',
                                                          size: fontLabel,
                                                          color: dark,
                                                        ),
                                                        x10,
                                                        PoppinsTextWidget(
                                                          text: document[
                                                              'company_address'],
                                                          size: fontLabel,
                                                          color: dark,
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
                                                      PoppinsTextWidget(
                                                        text: document[
                                                            'company_name'],
                                                        size: fontLabel,
                                                        color: dark,
                                                        isBold: true,
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
                                                  PoppinsTextWidget(
                                                    text: document[
                                                        'company_address'],
                                                    size: fontLabel,
                                                    color: dark,
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
