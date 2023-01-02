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
import '../../../widgets/textfield_widget.dart';

class JobseekerProfilePage extends StatefulWidget {
  final String? userId;
  final bool canBack;
  final bool canModify;
  const JobseekerProfilePage(
      {required this.userId,
      this.canBack = false,
      this.canModify = false,
      Key? key})
      : super(key: key);

  @override
  State<JobseekerProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<JobseekerProfilePage>
    with SingleTickerProviderStateMixin {
  // String datetime = DateTime.now().toString();
  // var companyName = "";
  // var position = "";
  // var description = "";
  // var duration = "";
  // var countryValue = "";
  // var stateValue = "";
  // var cityValue = "";
  // var certificationName = "";
  // var providerName = "";
  // var certificationID = "";
  // var certificationURL = "";
  // var personEmail = "";
  // var testimonial = "";
  // bool valuefirst = false;
  // bool _checkbox = false;
  // DateTime? date;
  // final TextEditingController _dateController = TextEditingController();

  // TabController? _tabController;

  String email = '';
  String username = '';
  String description = '';
  String role = ''; //-> Jobseeker or Employer

  bool editingMode = false; //edit profile data
  String? errorMessage;

  final usernameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();

    // emailController.addListener(() => setState(() {}));
    usernameController.addListener(() => setState(() {}));
    descriptionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // emailController.dispose();
    usernameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future getData() async {
    var user =
        FirebaseFirestore.instance.collection('users').doc(widget.userId);
    await user.get().then((value) {
      setState(() {
        email = value['email'];
        username = value['username'];
        description = value['description'];
        role = value['role'];
      });
    });
  }

  Future<void> signOut() async {
    await UserAuth().signOut();
    Navigator.of(context).pop();
  }

  Widget _signOut() {
    return CustomButtonWidget(
      label: 'Log out',
      onTap: signOut,
      backgroundColor: darkBlue,
      icon: Icons.logout_rounded,
    );
  }

  Widget _errorMessage() {
    return errorMessage != null
        ? Center(
            child: Padding(
              padding: pad10,
              child: Container(
                padding: pad10,
                decoration: BoxDecoration(
                    borderRadius: bRadius12, color: Colors.red.shade100),
                child: PoppinsTextWidget(
                    text: errorMessage!,
                    size: fontLabel,
                    color: Colors.red.shade900),
              ),
            ),
          )
        : Container(
            width: 0,
          );
  }

  void checkData() {
    if (/* emailController.text.isEmpty || */
        usernameController.text.isEmpty || descriptionController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all of the textfields.';
      });
    } else if (RegExp(r"\w+(\'\w+)?")
            .allMatches(descriptionController.text)
            .length >
        300) {
      setState(() {
        errorMessage =
            'Your description should not exceed 300 words. Please shorten it & try again.';
      });
    } else if (usernameController.text == username &&
        descriptionController.text == description) {
      null;
    } else {
      setState(() {
        errorMessage = null;
      });
      saveData();
    }
  }

  void saveData() {
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(UserAuth().currentUser!.uid);

    userRef.update({
      'username': usernameController.text.trim(),
      'description': descriptionController.text,
    });

    setState(() {
      username = usernameController.text.trim();
      description = descriptionController.text;
    });
  }

  void setData() {
    usernameController.text = username;
    descriptionController.text = description;
    // usernameController.notifyListeners();
    // descriptionController.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    // setData();
    return Material(
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          y20,
          Padding(
            padding: EdgeInsets.only(left: space18),
            child: PoppinsTextWidget(
                text: "Profile",
                size: 64,
                isBold: true,
                color: widget.canBack ? midOrange : midBlue),
          ),
          Divider(
            height: space40,
          ),
          Center(
              child: Padding(
            padding: EdgeInsets.only(bottom: space20),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(90)),
              child: Container(
                padding: pad10,
                color: grey,
                child: Icon(
                  Icons.person,
                  color: light,
                  size: 120,
                ),
              ),
            ),
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: space20),
            child: Container(
              decoration: BoxDecoration(borderRadius: bRadius12, color: silver),
              padding: pad10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  editingMode
                      ? Container(
                          width: 0,
                        )
                      : PoppinsTextWidget(
                          text: 'Name',
                          size: fontLabel,
                          color: dark,
                          isBold: true,
                        ),
                  editingMode
                      ? TextfieldWidget(
                          labelText: 'Full name',
                          colorTheme: blueTheme,
                          controller: usernameController)
                      : PoppinsTextWidget(
                          text: username,
                          size: fontLabel,
                          color: dark,
                        ),
                  y20,
                  widget.canBack
                      ? Container(
                          width: 0,
                        )
                      : PoppinsTextWidget(
                          text: 'E-mail address',
                          isBold: true,
                          size: fontLabel,
                          color: dark),
                  widget.canBack
                      ? Container(
                          width: 0,
                        )
                      : PoppinsTextWidget(
                          text: email, size: fontLabel, color: dark),
                  widget.canBack
                      ? Container(
                          width: 0,
                        )
                      : y20,
                  PoppinsTextWidget(
                      text: 'Account Type',
                      isBold: true,
                      size: fontLabel,
                      color: dark),
                  PoppinsTextWidget(text: role, size: fontLabel, color: dark),
                  y20,
                  editingMode
                      ? Container(
                          width: 0,
                        )
                      : PoppinsTextWidget(
                          text: 'Description',
                          isBold: true,
                          size: fontLabel,
                          color: dark),
                  editingMode
                      ? TextfieldWidget(
                          labelText: 'Description',
                          textInputType: TextInputType.multiline,
                          colorTheme: blueTheme,
                          controller: descriptionController)
                      : PoppinsTextWidget(
                          text: description, size: fontLabel, color: dark),
                ],
              ),
            ),
          ),
          errorMessage != null
              ? _errorMessage()
              : Container(
                  width: 0,
                ),
          widget.canModify
              ? y20
              : Container(
                  width: 0,
                ),
          widget.canModify
              ? editingMode
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: space20),
                      child: CustomButtonWidget(
                          label: "Save",
                          icon: Icons.save,
                          isFontBold: true,
                          backgroundColor: darkOrange,
                          onTap: () {
                            checkData();
                            setState(() {
                              editingMode = false;
                            });
                          }))
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: space20),
                      child: CustomButtonWidget(
                          label: "Edit Profile",
                          icon: Icons.edit,
                          isFontBold: true,
                          backgroundColor: darkOrange,
                          onTap: () {
                            setState(() {
                              editingMode = true;
                            });
                          }))
              : Container(
                  width: 0,
                ),
          y20,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: space20),
            child: widget.canBack
                ? CustomButtonWidget(
                    label: "Back",
                    isFontBold: true,
                    backgroundColor: widget.canBack ? darkOrange : darkBlue,
                    onTap: () => Navigator.of(context).pop())
                : _signOut(),
          ),
          y20,
        ],
      )),
    );
  }
}
