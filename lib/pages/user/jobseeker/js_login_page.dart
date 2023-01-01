import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospal/constants/style.dart';
import 'package:hospal/pages/user/jobseeker/js_nav_bar.dart';
import 'package:hospal/widgets/text_poppins_widget.dart';
import 'package:hospal/widgets/textfield_widget.dart';

import '../../../widgets/custom_button_widget.dart';
import 'js_register_page.dart';

class JobseekerLoginPage extends StatefulWidget {
  const JobseekerLoginPage({Key? key}) : super(key: key);

  @override
  State<JobseekerLoginPage> createState() => _JobseekerLoginPageState();
}

//khalifa.teczo@gmail.com AK1o9@teczo (Jobseeker)
//ahmed1o9@hotmail.com AK1o9@teczo (Jobseeker)
//ziowswaket@gmail.com AK1o9@teczo (Employer)
//theyven@teczo.co theyven@teczo.co (Employer)

class _JobseekerLoginPageState extends State<JobseekerLoginPage> {
  String? errorMessage;
  bool isLogin = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signInWithEmailAndPassword() async {
    try {
      validateUserDetails(_emailController.text.trim(),
          _passwordController.text.trim(), 'Jobseeker');
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  void validateUserDetails(String email, String password, String role) async {
    try {
      final fa = FirebaseAuth.instance;

      final newUser =
          await fa.signInWithEmailAndPassword(email: email, password: password);

      // ignore: unnecessary_null_comparison
      if (newUser != null) {
        if (kDebugMode) {
          print("Successful Login!");
        }
        final User? user = fa.currentUser;
        final userID = user!.uid;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            if (documentSnapshot.get('role') == role && role == 'Jobseeker') {
              // print(UserAuth().userRoleAsString);
              _emailController.clear();
              _passwordController.clear();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const JobseekerNavBar()));
            } else if (documentSnapshot.get('role') == role &&
                role == 'Employer') {
              if (kDebugMode) {
                print(
                    "Error: Wrong account type! Please login as an Employer instead");
              }
            }
            // else {}
          } else {
            if (kDebugMode) {
              print('User does not exist within the database');
            }
          }
        });
      } else {
        if (kDebugMode) {
          print("Failed Login.");
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Widget _errorMessage() {
    return errorMessage == null
        ? Container(
            width: 0,
          )
        : PoppinsTextWidget(
            text: 'Error: $errorMessage', size: fontBody, color: Colors.red);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //Sample data login
  void setSampleLoginData() {
    setState(() {
      _emailController.text = 'khalifa.teczo@gmail.com';
      _passwordController.text = 'AK1o9@teczo';
    });
  }

  @override
  Widget build(BuildContext context) {
    _emailController.text = 'khalifa.teczo@gmail.com';
    _passwordController.text = 'AK1o9@teczo';
    return Scaffold(
      backgroundColor: midBlue,
      body: Center(
        child: Container(
          width: 500,
          // height: 300,
          padding: pad20,
          decoration: BoxDecoration(color: light, borderRadius: bRadius20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    BackButton(
                      color: darkBlue,
                    ),
                    // Image.asset('hospal_logo.png'),
                    PoppinsTextWidget(
                        text: "Jobseeker Login",
                        size: fontHeader,
                        color: darkBlue,
                        isBold: true),
                  ],
                ),
                y20,
                TextfieldWidget(
                  labelText: "E-mail Address",
                  controller: _emailController,
                  colorTheme: blueTheme,
                ),
                y20,
                TextfieldWidget(
                  labelText: "Password",
                  controller: _passwordController,
                  colorTheme: blueTheme,
                  hideText: true,
                ),
                y20,
                _errorMessage(),
                y20,
                CustomButtonWidget(
                    label: "Sign In",
                    backgroundColor: darkBlue,
                    onTap: () async {
                      if ((_emailController.text.isEmpty ||
                              _emailController.text == '') ||
                          (_passwordController.text.isEmpty ||
                              _passwordController.text == '')) {
                        setState(() {
                          errorMessage =
                              'Please fill in all of the form fields.';
                        });
                      } else {
                        await signInWithEmailAndPassword();
                        setState(() {});
                      }
                    }),
                Padding(
                    padding: pad12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PoppinsTextWidget(
                          text: "Don't have an account?",
                          size: fontBody,
                          color: dark,
                        ),
                        x4,
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const JobseekerRegisterPage())),
                          child: PoppinsTextWidget(
                            text: "Tap here to register",
                            size: fontBody,
                            color: Colors.blue.shade600,
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
