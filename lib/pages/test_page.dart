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
        child: SafeArea(child: SizedBox(height: 250, child: buildJobTiles2())),
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

  Widget buildJobTiles2() {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('jobs').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
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
                              //TODO: Replace w/ logo
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
                                text: 'RM ${document['job_pay_till']}',
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

          return const Center(child: CircularProgressIndicator());
        });
  }
}
