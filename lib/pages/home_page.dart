import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:gighub/pages/job/job_page.dart';
import 'package:gighub/widgets/search_widget.dart';
import 'package:gighub/widgets/text_poppins_widget.dart';
import 'package:flutter/material.dart';
import '../constants/style.dart';
import 'job/job_post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    //May also include other controllers in the page.
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      home: Scaffold(
        appBar: AppBar(
          title: InkWell(
            onTap: () {},
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
                  onTap: () {},
                  child: Icon(Icons.menu_rounded, color: light, size: 28))),
          actions: [
            InkWell(
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
                height: space50,
                margin: EdgeInsets.only(right: space18),
                child: Row(children: [
                  //Search bar
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: light, //dark,
                      borderRadius: bRadius12,
                    ),
                    child: TextField(
                      controller: searchController,
                      cursorColor: dark, //light,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.search,
                            size: 25,
                            color: dark, //light,
                          ),
                          border: InputBorder.none,
                          hintText: 'Search for a job of your choice.',
                          hintStyle: TextStyle(color: /* light */ grey),
                          suffixIcon: searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: dark,
                                  ),
                                  onPressed: () => searchController.clear(),
                                )
                              : Container(width: 0)),
                    ),
                  )),
                  //Filter button (for search results)
                  InkWell(
                    onTap: () {
                      SearchWidget();
                    },
                    child: Container(
                        height: space50,
                        width: space50,
                        margin: EdgeInsets.only(left: space12),
                        decoration:
                            BoxDecoration(color: dark, borderRadius: bRadius12),
                        child: Icon(Icons.filter_alt_rounded,
                            color: light, size: 24)),
                  )
                ]),
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
                      text: 'FEATURED',
                      size: fontTitle,
                      color: dark,
                      isBold: true,
                    ),
                    y20,
                    SafeArea(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Expanded(
                            child: Row(children: [
                          buildJobTile(),
                          buildJobTile(),
                          buildJobTile(),
                          buildJobTile(),
                          buildJobTile(),
                          buildJobTile(),
                          buildJobTile(),
                          buildJobTile(),
                        ])),
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
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Expanded(
                            child: Row(children: [
                          buildJobTile(),
                          buildJobTile(),
                          buildJobTile(),
                          buildJobTile(),
                          buildJobTile(),
                          buildJobTile(),
                          buildJobTile(),
                          buildJobTile(),
                        ])),
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
                      text: 'ALL JOBS',
                      size: fontTitle,
                      color: dark,
                      isBold: true,
                    ),
                    y20,
                    buildJobListing(), //TODO: use as reference for format. (temp)
                    //TODO: Apply Format
                    SafeArea(
                      child: SizedBox(height: 200, child: buildJobListings()),
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

  Widget buildJobTiles() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs.map((document) {
                return Container(
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
                              padding: pad10,
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                  borderRadius: bRadius12, color: light),
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
                                text: 'RM ${document['monthly_salary']}',
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
                );
              }).toList(),
            );
          }
        });
  }

  Widget buildJobTile() {
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
                        child: ListTile(
                          title: Text(document['job_title']),
                        ),
                      ))
                  .toList(),
            );
            // return ListView.builder(
            //     itemCount: snapshot.data!.docs.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Text(snapshot.data!.docs[index].id);
            //     });
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

  Widget buildJobListing() {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const JobPage()));
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.only(bottom: space20),
        padding: EdgeInsets.only(
            top: space10, bottom: space10, left: space10, right: space20),
        decoration: BoxDecoration(borderRadius: bRadius20, color: dark),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(space10),
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(space12),
                            color: light),
                        child: Icon(
                          Icons.photo_rounded,
                          color: grey,
                          size: 45,
                        ),
                      ),
                      x20,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PoppinsTextWidget(
                            text: 'IT Intern',
                            size: fontLabel,
                            color: light,
                            isBold: true,
                          ),
                          y8,
                          Row(
                            children: [
                              PoppinsTextWidget(
                                text: 'Teczo Sdn. Bhd.',
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
                                text: 'Kuala Lumpur, Malaysia',
                                size: fontLabel,
                                color: light,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
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
            ]),
      ),
    );
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
