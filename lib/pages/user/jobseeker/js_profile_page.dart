import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:hospal/widgets/custom_button_widget.dart';
import 'package:intl/intl.dart';

import '../../../api/user_auth.dart';
import '../../../constants/style.dart';
import '../../../widgets/text_poppins_widget.dart';

class JobseekerProfilePage extends StatefulWidget {
  final String? profileId;
  const JobseekerProfilePage({Key? key, this.profileId}) : super(key: key);

  @override
  State<JobseekerProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<JobseekerProfilePage>
    with SingleTickerProviderStateMixin {
  String datetime = DateTime.now().toString();
  var companyName = "";
  var position = "";
  var description = "";
  var duration = "";
  var countryValue = "";
  var stateValue = "";
  var cityValue = "";
  var certificationName = "";
  var providerName = "";
  var certificationID = "";
  var certificationURL = "";
  var personEmail = "";
  var testimonial = "";
  bool valuefirst = false;
  bool _checkbox = false;
  DateTime? date;
  final TextEditingController _dateController = TextEditingController();

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this)
      ..addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _dateController.text = getDate();
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        y20,
        Padding(
          padding: EdgeInsets.only(left: space18),
          child: PoppinsTextWidget(
              text: "Profile", size: 64, isBold: true, color: midBlue),
        ),
        Divider(
          height: space40,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: space20),
          child: Column(
            children: [
              _signOut(),
            ],
          ),
        ),
      ],
    ));
  }

  Future<void> signOut() async {
    await UserAuth().signOut();
    Navigator.of(context).pop();
  }

  Widget _signOut() {
    return CustomButtonWidget(
      label: 'Log out',
      onTap: signOut,
      color: midBlue,
      icon: Icons.logout_rounded,
    );
  }

  Widget buildInfo() {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('profile')
            .doc(/* widget.profileId! */
                'MqHrdclhjQZ16XqvjkOV')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  y20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 15, left: 200),
                          child: PoppinsTextWidget(
                              text: "Profile",
                              size: 64,
                              isBold: true,
                              color: midBlue)),
                    ],
                  ),
                  y10,
                  y4,
                  Padding(
                    padding: const EdgeInsets.only(left: 170, right: 170),
                    child: SizedBox(
                      height: 400,
                      child: Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black.withOpacity(.4),
                                  width: .5),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 6),
                                    color: Colors.grey.withOpacity(.1),
                                    blurRadius: 12)
                              ],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 60, top: 20),
                                    child: ListTile(
                                      leading: const CircleAvatar(
                                        // minRadius: 50,
                                        // maxRadius: 50,
                                        backgroundImage: NetworkImage(
                                            "https://cdn-icons-png.flaticon.com/128/197/197374.png"),
                                      ),
                                      title: Padding(
                                        padding: EdgeInsets.only(left: space4),
                                        child: Text(
                                          snapshot.data!['name'],
                                          style: GoogleFonts.oswald(
                                              color: dark,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      subtitle: Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Icon(Icons.location_on,
                                              color: Colors.blue, size: 10),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: space4),
                                            child: Text(
                                              snapshot.data!['address'],
                                              style: GoogleFonts.roboto(
                                                  fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //Icon(Icons.settings, color: dark),
                                  Divider(
                                    thickness: 0.5,
                                    color: dark.withOpacity(.4),
                                  ),
                                  SizedBox(
                                    height: 300,
                                    child: Row(
                                      children: [
                                        Flexible(
                                            flex: 2,
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10, left: 15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "CONTACTS",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  color: dark,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10, left: 15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Icon(Icons.mail,
                                                            color: Colors.blue,
                                                            size: 12),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: space4),
                                                          child: Text(
                                                            snapshot
                                                                .data!['email'],
                                                            style: GoogleFonts
                                                                .openSans(
                                                                    color: dark
                                                                        .withOpacity(
                                                                            .4),
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5, left: 15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Icon(Icons.tty,
                                                            color: Colors.blue,
                                                            size: 12),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: space4),
                                                          child: Text(
                                                            snapshot.data![
                                                                'contact_number'],
                                                            style: GoogleFonts
                                                                .openSans(
                                                                    color: dark
                                                                        .withOpacity(
                                                                            .4),
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10, left: 15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "LANGUAGES",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  color: dark,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5, left: 15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "English: ",
                                                          style: GoogleFonts
                                                              .openSans(
                                                                  color: dark,
                                                                  fontSize: 12),
                                                        ),
                                                        Text(
                                                          "Native",
                                                          style: GoogleFonts
                                                              .openSans(
                                                                  color: dark
                                                                      .withOpacity(
                                                                          .4),
                                                                  fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5, left: 15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "French: ",
                                                          style: GoogleFonts
                                                              .openSans(
                                                                  color: dark,
                                                                  fontSize: 12),
                                                        ),
                                                        Text(
                                                          "Intermediare",
                                                          style: GoogleFonts
                                                              .openSans(
                                                                  color: dark
                                                                      .withOpacity(
                                                                          .4),
                                                                  fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10, left: 15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "EDUCATION",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  color: dark,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 7, left: 15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          snapshot.data![
                                                                  'education']
                                                              ['institution'],
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  color: dark
                                                                      .withOpacity(
                                                                          .6),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5, left: 15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${snapshot.data!['education']['degree']}\n${snapshot.data!['education']['year_start']} - ${snapshot.data!['education']['year_end']}',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  color: dark
                                                                      .withOpacity(
                                                                          .4),
                                                                  fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        VerticalDivider(
                                          thickness: 0.5,
                                          color: Colors.black.withOpacity(.4),
                                        ),
                                        Flexible(
                                            flex: 4,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20, left: 20),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        snapshot.data![
                                                            'description_title'],
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17,
                                                                color: dark),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20, left: 20),
                                                  child: Text(
                                                    snapshot.data![
                                                        'description_body'],
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 15,
                                                        color: dark,
                                                        height: 1.7),
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: .5,
                                                  color: dark.withOpacity(.4),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20, left: 20),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Skills",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17,
                                                                color: dark),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              top: 20),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[300],
                                                          border: Border.all(
                                                              color: dark
                                                                  .withOpacity(
                                                                      .5)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Text(
                                                        "Mobile Development",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 13,
                                                                color: dark),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              top: 20),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[300],
                                                          border: Border.all(
                                                              color: dark
                                                                  .withOpacity(
                                                                      .5)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Text(
                                                        "Web Development",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 13,
                                                                color: dark),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              top: 20),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[300],
                                                          border: Border.all(
                                                              color: dark
                                                                  .withOpacity(
                                                                      .5)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Text(
                                                        "Communication Skills",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 13,
                                                                color: dark),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                  y20,
                  y10,
                  buildTestimonials(),
                  y20,
                  y10,
                  buildCertifications(),
                  y20,
                  y10,
                  buildExperiences()
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  // testimonials widget
  Widget buildTestimonials() {
    return Padding(
      padding: const EdgeInsets.only(left: 170, right: 170),
      child: SizedBox(
        height: 360,
        child: Expanded(
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: Colors.black.withOpacity(.4), width: .5),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 6),
                      color: Colors.grey.withOpacity(.1),
                      blurRadius: 12)
                ],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: ListTile(
                        title: Text(
                          "Testimonials",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: dark),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "CV, Endorsements from past clients",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: dark.withOpacity(.4)),
                          ),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            showTestimonialForm(context);
                          },
                          child: Icon(Icons.add_circle, color: dark, size: 30),
                        )),
                  ),
                  Divider(
                    thickness: .5,
                    color: dark.withOpacity(.4),
                  ),
                  Center(
                      child: Column(children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(20),
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://cdn-icons-png.flaticon.com/512/2877/2877111.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    y8,
                    Text(
                      "Upload testimonials to improve your profile",
                      style: GoogleFonts.roboto(
                          //fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: dark),
                    ),
                    y8,
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Upload testimonials',
                            style: GoogleFonts.roboto(
                                decoration: TextDecoration.underline,
                                //fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.green),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showTestimonialForm(context);
                              }),
                      ]),
                    )
                  ])),
                ],
              )),
        ),
      ),
    );
  }

  // cetifications widget
  Widget buildCertifications() {
    return Padding(
      padding: const EdgeInsets.only(left: 170, right: 170),
      child: SizedBox(
        height: 360,
        child: Expanded(
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: Colors.black.withOpacity(.4), width: .5),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 6),
                      color: Colors.grey.withOpacity(.1),
                      blurRadius: 12)
                ],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: ListTile(
                        title: Text(
                          "Certifications",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: dark),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            showCertificationForm(context);
                          },
                          child: Icon(Icons.add_circle, color: dark, size: 30),
                        )),
                  ),
                  Divider(
                    thickness: .5,
                    color: dark.withOpacity(.4),
                  ),
                  Center(
                      child: Column(children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(20),
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://cdn-icons-png.flaticon.com/512/610/610333.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    y8,
                    Text(
                      "List your certifications to improve your profile",
                      style: GoogleFonts.roboto(
                          //fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: dark),
                    ),
                    y8,
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Add certification',
                            style: GoogleFonts.roboto(
                                decoration: TextDecoration.underline,
                                //fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.green),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showCertificationForm(context);
                              }),
                      ]),
                    )
                  ])),
                ],
              )),
        ),
      ),
    );
  }

  // Experiences widget
  Widget buildExperiences() {
    return Padding(
      padding: const EdgeInsets.only(left: 170, right: 170),
      child: SizedBox(
        height: 360,
        child: Expanded(
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: Colors.black.withOpacity(.4), width: .5),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 6),
                      color: Colors.grey.withOpacity(.1),
                      blurRadius: 12)
                ],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: ListTile(
                        title: Text(
                          "Work Experiences",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: dark),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            showExperienceForm(context);
                          },
                          child: Icon(Icons.add_circle, color: dark, size: 30),
                        )),
                  ),
                  Divider(
                    thickness: .5,
                    color: dark.withOpacity(.4),
                  ),
                  Center(
                      child: Column(children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(20),
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://cdn-icons-png.flaticon.com/512/2303/2303934.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    y8,
                    Text(
                      "Highliting relevant experiences to improve your profile",
                      style: GoogleFonts.roboto(
                          //fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: dark),
                    ),
                    y8,
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Add Experience',
                            style: GoogleFonts.roboto(
                                decoration: TextDecoration.underline,
                                //fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.green),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showExperienceForm(context);
                              }),
                      ]),
                    )
                  ])),
                ],
              )),
        ),
      ),
    );
  }

  // add testimonial form
  Future<void> showTestimonialForm(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: SizedBox(
                width: 700,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 10, right: 10),
                      child: ListTile(
                          title: Text(
                            "Add Testimonial",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: dark),
                          ),
                          trailing: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.close, color: dark, size: 30),
                          )),
                    ),
                    Divider(
                      thickness: .5,
                      color: dark.withOpacity(.4),
                    ),
                    y10,
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: TabBar(
                          isScrollable: true,
                          indicatorPadding: pad10,
                          //labelColor: Colors.grey,
                          unselectedLabelColor: Colors.black,
                          labelStyle: const TextStyle(fontSize: 20),
                          labelPadding: const EdgeInsets.only(
                              left: 35, right: 35, top: 10, bottom: 10),
                          indicator: BoxDecoration(
                              color: Colors.grey, borderRadius: bRadius20),
                          controller: _tabController,
                          tabs: [
                            Text(
                              'Give',
                              style: GoogleFonts.roboto(
                                  fontSize: 15, color: Colors.black),
                            ),
                            Text(
                              'Receive',
                              style: GoogleFonts.roboto(
                                  fontSize: 15, color: Colors.black),
                            ),
                          ]),
                    ),
                    Expanded(
                      child: TabBarView(controller: _tabController, children: [
                        giveTestimonials(),
                        receiveTestimonials(),
                      ]),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  // add certification form
  Future<void> showCertificationForm(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 700,
                  height: 850,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 10, right: 10),
                        child: ListTile(
                            title: Text(
                              "Add Certification",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: dark),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.close, color: dark, size: 30),
                            )),
                      ),
                      Divider(
                        thickness: .5,
                        color: dark.withOpacity(.4),
                      ),
                      y20,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Certification name *",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: dark),
                            ),
                          ],
                        ),
                      ),
                      y10,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Ex: Google Data Analytics",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onChanged: (value) {
                            setState(() {
                              certificationName = value;
                            });
                          },
                        ),
                      ),
                      y20,
                      y10,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Provider *",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: dark),
                            ),
                          ],
                        ),
                      ),
                      y10,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Ex: Google",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onChanged: (value) {
                            setState(() {
                              providerName = value;
                            });
                          },
                        ),
                      ),
                      y20,
                      y10,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Description *",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: dark),
                            ),
                          ],
                        ),
                      ),
                      y8,
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          minLines: 1,
                          maxLines: 7,
                          onChanged: (value) {
                            setState(() {
                              description = value;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: "Enter Description",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: dark),
                              )),
                        ),
                      ),
                      y20,
                      y10,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Issue date *",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: dark),
                            ),
                          ],
                        ),
                      ),
                      y10,
                      buildDateTF(),
                      y20,
                      y10,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Certication ID ",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: dark),
                            ),
                            Text(
                              "(optional)",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: dark.withOpacity(.4)),
                            ),
                          ],
                        ),
                      ),
                      y10,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          decoration: InputDecoration(
                              //hintText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onChanged: (value) {
                            setState(() {
                              certificationID = value;
                            });
                          },
                        ),
                      ),
                      y20,
                      y10,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Certication URL ",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: dark),
                            ),
                            Text(
                              "(optional)",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: dark.withOpacity(.4)),
                            ),
                          ],
                        ),
                      ),
                      y10,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          decoration: InputDecoration(
                              //hintText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onChanged: (value) {
                            setState(() {
                              certificationURL = value;
                            });
                          },
                        ),
                      ),
                      Divider(
                        thickness: .5,
                        color: dark.withOpacity(.4),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10, top: 20),
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    primary: dark,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                child: Center(
                                  child: PoppinsTextWidget(
                                      text: "Add Certification",
                                      size: fontLabel,
                                      color: light),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  // add work experience form
  Future showExperienceForm(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 700,
                  height: 850,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 10, right: 10),
                        child: ListTile(
                            title: Text(
                              "Add Work Experience",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: dark),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.close, color: dark, size: 30),
                            )),
                      ),
                      Divider(
                        thickness: .5,
                        color: dark.withOpacity(.4),
                      ),
                      y10,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Company *",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: dark),
                            ),
                          ],
                        ),
                      ),
                      y8,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Company Name",
                              hintText: "Ex: Teczo Sdn Bhd",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onChanged: (value) {
                            setState(() {
                              companyName = value;
                            });
                          },
                        ),
                      ),
                      y20,
                      y10,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Location *",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: dark),
                            ),
                          ],
                        ),
                      ),
                      y8,
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            ///Adding CSC Picker Widget in app
                            CSCPicker(
                              ///Enable disable state dropdown [OPTIONAL PARAMETER]
                              showStates: true,

                              /// Enable disable city drop down [OPTIONAL PARAMETER]
                              showCities: true,

                              ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                              flagState: CountryFlag.DISABLE,

                              ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                              dropdownDecoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 1)),

                              ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                              disabledDropdownDecoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Colors.grey.shade300,
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 1)),

                              ///placeholders for dropdown search field
                              countrySearchPlaceholder: "Country",
                              stateSearchPlaceholder: "State",
                              citySearchPlaceholder: "City",

                              ///labels for dropdown
                              countryDropdownLabel: "Country",
                              stateDropdownLabel: "State",
                              cityDropdownLabel: "City",

                              ///selected item style [OPTIONAL PARAMETER]
                              selectedItemStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),

                              ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                              dropdownHeadingStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),

                              ///DropdownDialog Item style [OPTIONAL PARAMETER]
                              dropdownItemStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),

                              ///Dialog box radius [OPTIONAL PARAMETER]
                              dropdownDialogRadius: 10.0,

                              ///Search bar radius [OPTIONAL PARAMETER]
                              searchBarRadius: 10.0,

                              ///triggers once country selected in dropdown
                              onCountryChanged: (value) {
                                setState(() {
                                  ///store value in country variable
                                  countryValue = value;
                                });
                              },

                              ///triggers once state selected in dropdown
                              onStateChanged: (value) {
                                setState(() {
                                  ///store value in state variable
                                  stateValue = value!;
                                });
                              },

                              ///triggers once city selected in dropdown
                              onCityChanged: (value) {
                                setState(() {
                                  ///store value in city variable
                                  cityValue = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      y20,
                      y10,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Title *",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: dark),
                            ),
                          ],
                        ),
                      ),
                      y8,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Position",
                              hintText: "Software Developer",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onChanged: (value) {
                            setState(() {
                              position = value;
                            });
                          },
                        ),
                      ),
                      y20,
                      y10,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Period *",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: dark),
                            ),
                          ],
                        ),
                      ),
                      y8,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: TextField(
                                decoration: InputDecoration(
                                    labelText: "Duration",
                                    hintText: "Ex: 2 years",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onChanged: (value) {
                                  setState(() {
                                    duration = value;
                                  });
                                },
                              ),
                            ),
                            Flexible(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.greenAccent,
                                      value: _checkbox,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkbox = !_checkbox;
                                        });
                                      },
                                    ),
                                    Text("I currently work here",
                                        style: GoogleFonts.openSans(
                                            color: dark, fontSize: 15))
                                  ],
                                ))
                          ],
                        ),
                      ),
                      y20,
                      y10,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Description ",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: dark),
                            ),
                            Text(
                              "(optional)",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: dark.withOpacity(.4)),
                            ),
                          ],
                        ),
                      ),
                      y8,
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          minLines: 1,
                          maxLines: 7,
                          onChanged: (value) {
                            setState(() {
                              description = value;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: "Enter Job Description",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: dark),
                              )),
                        ),
                      ),
                      y20,
                      Divider(
                        thickness: .5,
                        color: dark.withOpacity(.4),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10, top: 10),
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    primary: dark,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                child: Center(
                                  child: PoppinsTextWidget(
                                      text: "Add work Experience",
                                      size: fontLabel,
                                      color: light),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: /* date ??  */ initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;

    setState(() => date = newDate);
  }

  String getDate() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('MM/dd/yyyy').format(date!);
    }
  }

  Widget buildDateTF() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        autofocus: true,
        readOnly: true,
        decoration: InputDecoration(
            hintText: 'Date',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                icon: const Icon(Icons.date_range, color: Colors.blue),
                onPressed: () {
                  pickDate(context);
                },
              ),
            )),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill up this field.';
          }
          return null;
        },
        controller: _dateController,
        keyboardType: TextInputType.datetime,
        inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
      ),
    );
  }

  Widget giveTestimonials() {
    return Column(children: [
      y10,
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Give To *",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold, fontSize: 15, color: dark),
            ),
          ],
        ),
      ),
      y8,
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: TextField(
          decoration: InputDecoration(
              labelText: "Enter person email",
              hintText: "Ex: Peter@gmail.com",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          onChanged: (value) {
            setState(() {
              personEmail = value;
            });
          },
        ),
      ),
      y20,
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Enter testimonial *",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold, fontSize: 15, color: dark),
            ),
          ],
        ),
      ),
      y8,
      Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: TextField(
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 1,
          maxLines: 7,
          onChanged: (value) {
            setState(() {
              testimonial = value;
            });
          },
          decoration: InputDecoration(
              hintText: "Write testimonial here",
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: dark),
              )),
        ),
      ),
      y20,
      Divider(
        thickness: .5,
        color: dark.withOpacity(.4),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    primary: dark,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: Center(
                  child: PoppinsTextWidget(
                      text: "Give testimonial", size: fontLabel, color: light),
                ),
              ),
            ),
          ),
        ],
      ),
    ]);
  }

  Widget receiveTestimonials() {
    return Column(children: [
      y10,
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Receive from *",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold, fontSize: 15, color: dark),
            ),
          ],
        ),
      ),
      y8,
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: TextField(
          decoration: InputDecoration(
              labelText: "Enter person email",
              hintText: "Ex: Peter@gmail.com",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          onChanged: (value) {
            setState(() {
              personEmail = value;
            });
          },
        ),
      ),
      y20,
      //y10,
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Date *",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold, fontSize: 15, color: dark),
            ),
          ],
        ),
      ),
      y8,
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: TextField(
          decoration: InputDecoration(
              labelText: "Date",
              hintText: "Ex: 12-03-2022",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          onChanged: (value) {
            setState(() {
              personEmail = value;
            });
          },
        ),
      ),
      y20,
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Enter testimonial *",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold, fontSize: 15, color: dark),
            ),
          ],
        ),
      ),
      y8,
      Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: TextField(
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 1,
          maxLines: 7,
          onChanged: (value) {
            setState(() {
              testimonial = value;
            });
          },
          decoration: InputDecoration(
              hintText: "Paste testimonial here",
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: dark),
              )),
        ),
      ),
      y20,
      Divider(
        thickness: .5,
        color: dark.withOpacity(.4),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    primary: dark,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: Center(
                  child: PoppinsTextWidget(
                      text: "Get testimonial", size: fontLabel, color: light),
                ),
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
