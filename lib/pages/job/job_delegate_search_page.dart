import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gighub/pages/job/job_page.dart';

import '../../constants/style.dart';

//NOTE: May be a temp class.

class JobSearchDelegatePage extends StatefulWidget {
  final String keyword;
  const JobSearchDelegatePage({Key? key, this.keyword = ''}) : super(key: key);

  @override
  State<JobSearchDelegatePage> createState() => _JobSearchPageState();
}

class _JobSearchPageState extends State<JobSearchDelegatePage> {
  String? searchQuery;

  final searchBarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchBarController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: light, //dark,
                  borderRadius: bRadius12,
                ),
                child: TextField(
                  controller: searchBarController,
                  cursorColor: dark, //light,
                  decoration: InputDecoration(
                      icon: IconButton(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          showSearch(
                              context: context, delegate: MySearchDelegate());
                        },
                        icon: Icon(
                          Icons.search,
                          size: 25,
                          color: dark, //light,
                        ),
                      ),
                      border: InputBorder.none,
                      hintText: 'Search for a job of your choice.',
                      hintStyle: TextStyle(color: /* light */ grey),
                      suffixIcon: searchBarController.text.isNotEmpty
                          ? IconButton(
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              icon: Icon(
                                Icons.close,
                                color: dark,
                              ),
                              onPressed: () => searchBarController.clear(),
                            )
                          : Container(width: 0)),
                ),
              )),
            ],
          ),
        ],
      )),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('jobs');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: const Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseFirestore.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            if (kDebugMode) {
              print(snapshot.data);
            }
            return ListView(children: [
              ...snapshot.data!.docs
                  .where((QueryDocumentSnapshot element) => element['job_title']
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .map((QueryDocumentSnapshot<Object?> data) {
                final String jobTitle = data.get('job_title');
                final String companyName = data.get('company_name');

                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => JobPage(
                              docId: data.id,
                            )));
                  },
                  title: Text(jobTitle),
                  subtitle: Text(
                    companyName,
                    style: TextStyle(fontSize: fontBody),
                  ),
                  leading: CircleAvatar(
                      backgroundColor: dark,
                      child: Icon(
                        Icons.photo,
                        color: light,
                      )),
                );
              })
            ]);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = [
      'Software Developer',
      'Paralegal',
      'Lawyer',
      'Nurse',
      'Doctor',
      'Video Editor'
    ];

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
              title: Text(
                suggestion,
                style: TextStyle(color: dark),
              ),
              onTap: () {
                query = suggestion;
                showResults(context);

                if (kDebugMode) {
                  print('Selection: $suggestion');
                }
              });
        });
  }
}
