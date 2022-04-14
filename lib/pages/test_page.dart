import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gighub/constants/style.dart';

import '../widgets/text_poppins_widget.dart';

//NOTE: This is a temporary page for testing widgets.

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        padding: pad20,
        child: buildJobListings(),
      ),
    );
  }

  Widget buildJobsHoriztonally() {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('jobs').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Text(snapshot.data!.docs.first['job_title']);
          }

          return const Center(child: CircularProgressIndicator());
        });
  }

  Widget buildJobListings() {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('jobs');
    return FutureBuilder<QuerySnapshot>(
        future: collection.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //Method 1
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
            //Method 2
            // return ListView.builder(
            //     itemCount: snapshot.data!.docs.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Text(snapshot.data!.docs[index]['job_title']);
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
}
