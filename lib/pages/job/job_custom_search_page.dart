import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospal/api/screen_responsiveness/dimensions.dart';
import 'package:hospal/constants/style.dart';
import 'package:hospal/pages/job/job_details_page.dart';
import 'package:hospal/widgets/text_poppins_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class JobCustomSearchPage extends StatefulWidget {
  final String? query;
  const JobCustomSearchPage({Key? key, this.query}) : super(key: key);

  @override
  State<JobCustomSearchPage> createState() => _JobSearchPageState();
}

class _JobSearchPageState extends State<JobCustomSearchPage> {
  final searchController = TextEditingController();
  String? docId;

  String? resultDocId;

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileWidth;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileWidth;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
    searchController.text = widget.query!;
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void clearAll() {
    searchController.clear();
    //NOTE: May also include other controllers in the page for filtering search results.
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: pad20,
        color: silver,
        child: SingleChildScrollView(
          child: Column(children: [
            Align(
              alignment: Alignment.topLeft,
              child: PoppinsTextWidget(
                  text: "Search", size: 64, isBold: true, color: midBlue),
            ),
            const Divider(height: 40),
            TextField(
              controller: searchController,
              onChanged: ((value) {
                setState(() {});
              }),
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    color: dark,
                    icon: Icon(
                      Icons.arrow_back,
                      color: grey,
                    ),
                    iconSize: 20,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  suffixIcon: searchController.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            clearAll();
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.close,
                            color: grey,
                          )),
                  contentPadding: EdgeInsets.only(left: space20),
                  hintText: 'Search by job title.',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4))),
            ),
            y20,
            Container(
              padding: pad20,
              decoration: BoxDecoration(borderRadius: bRadius20, color: light),
              child: IntrinsicHeight(
                child: Row(children: [
                  Expanded(
                      child:
                          // PoppinsTextWidget(
                          //     text: 'Results', size: fontTitle, color: dark)),
                          SafeArea(
                              child: SizedBox(
                                  height: /* 300 */ 600,
                                  child: buildJobResults()))),

                  isDesktop(context)
                      ? VerticalDivider(
                          thickness: 0.5,
                          width: space20,
                          color: grey,
                        )
                      : Container(
                          width: 0,
                        ),

                  //Side Preview
                  isDesktop(context)
                      ? Expanded(
                          child: resultDocId == null
                              ? PoppinsTextWidget(
                                  text: '',
                                  size: fontTitle,
                                  color: dark,
                                  isCenter: true,
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                  children: [
                                    buildJobView(),
                                  ],
                                )))
                      : Container(
                          width: 0,
                        )
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildJobResults() {
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Scaffold(
                                    appBar: AppBar(backgroundColor: darkBlue),
                                    body: JobPage(
                                      docId: resultDocId,
                                      employerId: document['employer_id'],
                                    ))));
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
                                  color: darkBlue,
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
                    y10,
                    Center(
                      child: PoppinsTextWidget(
                        text:
                            'Published on ${snapshot.data!['publication_date']}, ${snapshot.data!['publication_time']}',
                        size: fontLabel,
                        color: grey,
                      ),
                    ),
                    y30,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PoppinsTextWidget(
                            text: 'Salary',
                            size: fontHeader,
                            color: dark,
                            isBold: true),
                        y4,
                        PoppinsTextWidget(
                            text:
                                'RM ${snapshot.data!['job_pay_from']} - RM ${snapshot.data!['job_pay_till']}',
                            size: fontHeader,
                            color: dark)
                      ],
                    ),
                    y20,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PoppinsTextWidget(
                            text: 'Duration',
                            size: fontHeader,
                            color: dark,
                            isBold: true),
                        y4,
                        PoppinsTextWidget(
                            text: snapshot.data!['job_duration'],
                            size: fontHeader,
                            color: dark)
                      ],
                    ),
                    y30,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PoppinsTextWidget(
                            text: 'Job Type',
                            size: fontHeader,
                            color: dark,
                            isBold: true),
                        y4,
                        PoppinsTextWidget(
                            text: snapshot.data!['job_type'],
                            size: fontHeader,
                            color: dark)
                      ],
                    ),
                    y20,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PoppinsTextWidget(
                            text: 'Job Level',
                            size: fontHeader,
                            color: dark,
                            isBold: true),
                        y4,
                        PoppinsTextWidget(
                            text: snapshot.data!['job_level'],
                            size: fontHeader,
                            color: dark)
                      ],
                    ),
                    y20,
                    PoppinsTextWidget(
                      text: 'Job Description',
                      size: fontHeader,
                      color: dark,
                      isBold: true,
                    ),
                    y4,
                    SizedBox(
                        width: 500,
                        child: Text(snapshot.data!['job_description'],
                            style: GoogleFonts.getFont('Poppins',
                                textStyle: TextStyle(fontSize: fontHeader)))),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  void _onSearchChanged() {
    print(searchController.text);
  }
}
