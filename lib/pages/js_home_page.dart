import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:gighub/api/search_service.dart';
import 'package:gighub/pages/job/job_page.dart';
import 'package:gighub/widgets/button_widget.dart';
import 'package:gighub/widgets/text_poppins_widget.dart';
import 'package:flutter/material.dart';
import 'package:gighub/widgets/textfield_widget.dart';
import '../constants/style.dart';
import 'job/job_post_page.dart';
import 'job/job_search_page.dart';

class JobseekerHomePage extends StatefulWidget {
  const JobseekerHomePage({Key? key}) : super(key: key);

  @override
  State<JobseekerHomePage> createState() => _JobseekerHomePageState();
}

class _JobseekerHomePageState extends State<JobseekerHomePage> {
  final searchController = TextEditingController();

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
        appBar: AppBar(
          title: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const JobseekerHomePage()));
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
                onTap: () {},
                child: Icon(Icons.person, color: light, size: 28)),
            x10,
            x8,
          ],
        ),
        backgroundColor: silver,
        floatingActionButton: FloatingActionButton(
          backgroundColor: dark,
          elevation: 16,
          child: Icon(
            Icons.add,
            color: light,
          ),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const JobPostPage()));
          },
        ),
        body: Container(
          margin: EdgeInsets.only(left: space18),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              y30,
              PoppinsTextWidget(
                text: "Welcome back Ahmed,\nLet's find you a job!",
                size: fontSubtitle,
                color: dark,
              ),
              y30,
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(right: space18),
                child: Row(children: [
                  //Search bar
                  Expanded(
                    flex: 10,
                    child: TextfieldWidget(
                      labelText: 'Job title, company name or keyword',
                      controller: searchController,
                      icon: Icon(Icons.search_outlined, color: dark //or aqua,
                          ),
                    ),
                  ),

                  // //Filter button (for search results) //TODO: Remove or replace in the search delegate.
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
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(left: space10),
                      child: ButtonWidget(
                          icon: Icons.search_rounded,
                          label: 'Search',
                          onTap: () {
                            showSearch(
                                context: context, delegate: MySearchDelegate());
                          }),
                    ),
                  ),
                ]),
              ),
              searchController.text.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: space50),
                      padding: pad20,
                      decoration:
                          BoxDecoration(borderRadius: bRadius20, color: light),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PoppinsTextWidget(
                            text: 'SEARCH RESULTS',
                            size: fontTitle,
                            color: dark,
                            isBold: true,
                          ),
                          y20,
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
                    )
                  : Container(width: 0),
              Container(
                margin: EdgeInsets.only(top: space50),
                padding: pad20,
                decoration:
                    BoxDecoration(borderRadius: bRadius20, color: light),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PoppinsTextWidget(
                      text: 'FEATURED',
                      size: fontTitle,
                      color: dark,
                      isBold: true,
                    ),
                    y20,
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
                margin: EdgeInsets.only(top: space50),
                padding: pad20,
                decoration:
                    BoxDecoration(borderRadius: bRadius20, color: light),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PoppinsTextWidget(
                      text: 'NEAR YOU',
                      size: fontTitle,
                      color: dark,
                      isBold: true,
                    ),
                    y20,
                    SafeArea(
                        child: SizedBox(height: 200, child: buildJobTiles()))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: space50, right: space20),
                padding: pad20,
                decoration:
                    BoxDecoration(borderRadius: bRadius20, color: light),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PoppinsTextWidget(
                          text: 'BROWSE ALL JOBS',
                          size: fontTitle,
                          color: dark,
                          isBold: true,
                        ),
                        IconButton(
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
                              color: dark,
                              size: 28,
                            ))
                      ],
                    ),
                    y20,
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
                                //TODO: Replace w/ logo
                                // child: SafeArea(
                                //   child: buildLogo('J-LLP1X68Fp6minnZ28rcg',
                                //       'Glitch WP.jpg' /* , document['logo'] */),
                                // )
                                child: Icon(
                                  Icons.photo_rounded,
                                  color: grey,
                                  size: 45,
                                ),
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
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const JobPage()));
      },
      child: Container(
        height: 200,
        width: 260,
        margin: EdgeInsets.only(right: space30),
        padding: pad20,
        decoration: BoxDecoration(borderRadius: bRadius20, color: dark),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: pad10,
                width: 72,
                height: 72,
                decoration:
                    BoxDecoration(borderRadius: bRadius12, color: light),
                child: Icon(
                  Icons.photo_rounded,
                  color: grey,
                  size: 45,
                ),
              ),
              Container(
                padding: pad8,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightGreenAccent),
                    borderRadius: bRadius20),
                child: PoppinsTextWidget(
                  text: 'RM 1250 - 2500',
                  size: fontLabel,
                  color: light, //Colors.lightGreen,
                ),
              )
            ],
          ),
          y20,
          PoppinsTextWidget(
            text: 'IT Intern',
            size: fontLabel,
            color: light,
            isBold: true,
          ),
          PoppinsTextWidget(
            text: 'Teczo Sdn. Bhd.',
            size: fontLabel,
            color: light,
          ),
          PoppinsTextWidget(
            text: 'Kuala Lumpur, Malaysia',
            size: fontLabel,
            color: light,
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
                        shape: RoundedRectangleBorder(borderRadius: bRadius20),
                        color: dark,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    JobPage(docId: document.id)));
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
                                                    text: document[
                                                        'company_name'],
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
