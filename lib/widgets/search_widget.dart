import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gighub/constants/style.dart';
import 'package:gighub/widgets/text_poppins_widget.dart';

class SearchWidget extends SearchDelegate {
  final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('jobs');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
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
            print(snapshot.data);
            return ListView(children: [
              ...snapshot.data!.docs
                  .where((QueryDocumentSnapshot element) => element['job_title']
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .map((QueryDocumentSnapshot<Object?> data) {
                final String jobTitle = data.get('job_title');

                return ListTile(
                  onTap: () {},
                  title: Text(jobTitle),
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
    return PoppinsTextWidget(
        text: 'Enter a keyword to start searching for your dream job!',
        size: fontBody,
        color: dark);
  }
}
