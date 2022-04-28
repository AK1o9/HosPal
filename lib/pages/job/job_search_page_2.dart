import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gighub/constants/style.dart';
import 'package:gighub/widgets/text_poppins_widget.dart';
import 'package:universal_html/html.dart';

import '../../api/search_service.dart';

class JobSearchPage2 extends StatefulWidget {
  final String? query;
  const JobSearchPage2({Key? key, this.query}) : super(key: key);

  @override
  State<JobSearchPage2> createState() => _JobSearchPage2State();
}

class _JobSearchPage2State extends State<JobSearchPage2> {
  final searchController = TextEditingController();
  String? docId;

  var queryResults = [];
  var tempSearchStore = [];

  var _allResults = [];
  var _resultsList = [];

  String? resultDocId;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged /* () => setState(() {}) */);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void clearAll() {
    searchController.clear();
    //NOTE: May also include other controllers in the page.
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: pad20,
        color: silver,
        child: Column(children: [
          // TextfieldWidget(labelText: 'Search', controller: searchController),
          TextField(
            controller: searchController,
            onChanged: ((value) {
              setState(() {});
              // initiateSearch(value);
            }),
            decoration: InputDecoration(
                prefixIcon: IconButton(
                  color: dark,
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 20,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                contentPadding: EdgeInsets.only(left: space20),
                hintText: 'Search by job title.',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(4))),
          ),
          y20,
          // (queryResults == [] && tempSearchStore == [])
          //     ? GridView.count(
          //         padding: EdgeInsets.symmetric(horizontal: space10),
          //         crossAxisCount: kIsWeb ? 1 : 2,
          //         crossAxisSpacing: space4,
          //         mainAxisSpacing: space4,
          //         primary: false,
          //         shrinkWrap: true,
          //         children: tempSearchStore.map((element) {
          //           return buildResultCard(element);
          //         }).toList(),
          //       )
          //     : Container(),
          Container(
            padding: pad20,
            decoration: BoxDecoration(borderRadius: bRadius20, color: light),
            child: IntrinsicHeight(
              child: Row(children: [
                //ListView,
                Expanded(
                    child: SafeArea(
                        child: SizedBox(height: 300, child: buildJobStream()))),
                // PoppinsTextWidget(
                //     text: 'Results', size: fontTitle, color: dark)),

                // child: showResults()),

                VerticalDivider(
                  thickness: 0.5,
                  width: space20,
                  color: grey,
                  // indent: space20,
                  // endIndent: space20,
                ),

                //Side Preview
                Expanded(
                    child: resultDocId == null
                        ? PoppinsTextWidget(
                            text: 'View',
                            size: fontTitle,
                            color: dark,
                            isCenter: true,
                          )
                        : buildJobView()
                    /* Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PoppinsTextWidget(
                                  text: resultDocId!,
                                  size: fontTitle,
                                  color: dark,
                                  isCenter: true,
                                ),
                              ],
                            ),
                          ) */
                    )
              ]),
            ),
          ),
          // ListView.builder(
          //   itemCount: _resultsList.length,
          //   itemBuilder: (BuildContext context, int index) =>
          //       buildJobCard(context, _resultsList[index]),
          // ),
        ]),
      ),
    );
  }

  Widget buildJobStream() {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('jobs');
    return FutureBuilder<QuerySnapshot>(
        future: searchController.text.isEmpty
            ? collection.get()
            : collection
                .where(
                  'search_keys',
                  arrayContains: searchController.text,
                )
                .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var documents = snapshot.data!.docs;
            return ListView(
              children: documents
                  .map((document) => Card(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              resultDocId = document.id;
                            });
                          },
                          child: ListTile(
                            contentPadding: pad12,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PoppinsTextWidget(
                                  text: document['job_title'],
                                  size: fontHeader,
                                  color: dark,
                                ),
                                y4,
                                PoppinsTextWidget(
                                  text: document['company_name'],
                                  size: fontSubheader,
                                  color: aqua,
                                )
                              ],
                            ),
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

  Widget buildSearchResults() {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('jobs').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView(
                children: snapshot.data!.docs.map((document) {
              return PoppinsTextWidget(
                  text: document['job_title'], size: fontHeader, color: dark);
            }).toList());
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget buildResult(String data) {
    return Container();
  }

  void initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResults = [];
        tempSearchStore = [];
      });
    }

    // ignore: unused_local_variable
    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    // ignore: prefer_is_empty
    if (queryResults.length == 0 && value.length == 1) {
      SearchService().search(value).then((QuerySnapshot documents) {
        for (int? i; i! < documents.docs.length; ++i) {
          queryResults.add(documents.docs[i].data());
        }
      });
    } else {
      tempSearchStore = [];
      queryResults.forEach((element) {
        if (element['search_key'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
    // ignore: prefer_is_empty
    if (tempSearchStore.length == 0 && value.length > 1) {
      setState(() {});
    }
  }

  Widget buildResultCard(data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: bRadius12),
      elevation: 2,
      child: Center(
        child: Text(
          data['job_title'],
          textAlign: TextAlign.center,
          style: TextStyle(color: dark, fontSize: fontHeader),
        ),
      ),
    );
  }

  void _onSearchChanged() {
    print(searchController.text);
  }

  getJobStreamSnapshots(BuildContext context) async {
    var data = await FirebaseFirestore.instance
        .collection('jobs')
        .orderBy('job_title')
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultsList();
    return "complete";
  }

  Widget showResults() {
    return StreamBuilder(
        stream: getJobStreamSnapshots(context),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) =>
                    buildJobCard(context, snapshot.data!.docs[index]));
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  void searchResultsList() {
    var showResults = [];

    if (searchController.text != "") {
      for (var job_post in _allResults) {
        // var title = Trip.fromSnapshot(job_post).title.toLowerCase();

        // if (title.contains(searchController.text.toLowerCase())) {
        //   showResults.add(job_post);
        // }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  Widget buildJobView() {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('jobs')
            .doc(resultDocId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Container(
              padding: pad12,
              child: Container(
                padding: pad8,
                // decoration:
                //     BoxDecoration(border: Border.all(width: 0.25, color: grey)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: PoppinsTextWidget(
                        text: snapshot.data!['job_title'],
                        size: fontTitle,
                        color: dark,
                      ),
                    ),
                    y20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: dark,
                          child: Icon(
                            Icons.image_rounded,
                            color: light,
                          ),
                        ),
                        x8,
                        PoppinsTextWidget(
                            text: snapshot.data!['company_name'],
                            size: fontSubtitle,
                            color: dark),
                      ],
                    ),
                    y30,
                    PoppinsTextWidget(
                      text: 'Job Description',
                      size: fontHeader,
                      color: dark,
                      isBold: true,
                    ),
                    y4,
                    SizedBox(
                        width: 500,
                        child: Text(snapshot.data!['job_description'])),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  buildJobCard(BuildContext context, document) {
    return const Card(
      child: InkWell(
          child: Padding(
        padding: pad20,
        child: Text('test'),
      )),
    );
  }
}
