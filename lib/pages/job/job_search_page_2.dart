import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gighub/constants/style.dart';
import 'package:gighub/widgets/text_poppins_widget.dart';
import 'package:gighub/widgets/textfield_widget.dart';

class JobSearchPage2 extends StatefulWidget {
  final String? query;
  const JobSearchPage2({Key? key, this.query}) : super(key: key);

  @override
  State<JobSearchPage2> createState() => _JobSearchPage2State();
}

class _JobSearchPage2State extends State<JobSearchPage2> {
  final searchController = TextEditingController();
  String? docId;

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
    return Material(
      child: Container(
        padding: pad20,
        color: silver,
        child: Column(children: [
          TextfieldWidget(labelText: 'Search', controller: searchController),
          y20,
          Container(
            padding: pad12,
            decoration: BoxDecoration(borderRadius: bRadius20, color: light),
            child: Row(children: [
              //ListView,
              Expanded(
                  child: PoppinsTextWidget(
                      text: 'sdf', size: fontTitle, color: dark)),
              //Side Preview
              Expanded(
                  child: PoppinsTextWidget(
                      text: 'View', size: fontTitle, color: dark))
            ]),
          )
        ]),
      ),
    );
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
}
