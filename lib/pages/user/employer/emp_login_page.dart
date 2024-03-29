import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospal/api/user_auth.dart';
import 'package:hospal/constants/style.dart';
import 'package:hospal/pages/user/employer/emp_nav_bar.dart';
import 'package:hospal/widgets/custom_button_widget.dart';
import 'package:hospal/widgets/text_poppins_widget.dart';
import 'package:hospal/widgets/textfield_widget.dart';

import 'emp_register_page.dart';

class EmployerLoginPage extends StatefulWidget {
  const EmployerLoginPage({Key? key}) : super(key: key);

  @override
  State<EmployerLoginPage> createState() => _EmployerLoginPageState();
}

class _EmployerLoginPageState extends State<EmployerLoginPage> {
  String? errorMessage;
  bool isLogin = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signInWithEmailAndPassword() async {
    try {
      validateUserDetails(_emailController.text.trim(),
          _passwordController.text.trim(), 'Employer');
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
              setState(() {
                errorMessage =
                    "Error: Wrong account type! Please login as an Employer instead";
              });
              if (kDebugMode) {
                print(
                    "Error: Wrong account type! Please login as an Employer instead");
              }
            } else if (documentSnapshot.get('role') == role &&
                role == 'Employer') {
              _emailController.clear();
              _passwordController.clear();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const EmployerNavBar())); //TODO: Maybe remove const
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
    } on FirebaseAuthException catch (ex) {
      setState(() {
        errorMessage = ex.message!;
      });
      if (kDebugMode) {
        print(ex.message);
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

  @override
  Widget build(BuildContext context) {
    _emailController.text = 'ziowswaket@gmail.com';
    _passwordController.text = 'AK1o9@teczo';
    return Scaffold(
      backgroundColor: midOrange,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
                child: Opacity(
                    opacity: 0.2,
                    child: Image.asset(
                      'assets/images/hospital_bed.jpg',
                      fit: BoxFit.cover,
                    ))),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: pad20,
                    child: BackButton(
                      color: light,
                    ),
                  ),
                ),
                PoppinsTextWidget(
                  text: 'LOGIN',
                  size: 64,
                  color: light,
                  isBold: true,
                ),
                y10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PoppinsTextWidget(
                      text: 'as an',
                      size: fontSubheader,
                      color: light,
                      // isBold: true,
                    ),
                    x8,
                    Container(
                      padding: pad10,
                      color: light,
                      child: PoppinsTextWidget(
                        text: 'Employer',
                        color: midOrange,
                        size: fontSubheader,
                        isBold: true,
                      ),
                    )
                  ],
                ),
                y30,
                y20,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: space20),
                  child: Container(
                    padding: pad20,
                    decoration:
                        BoxDecoration(borderRadius: bRadius20, color: light),
                    child: Column(
                      children: [
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
                            backgroundColor: darkOrange,
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
                                              const EmployerRegisterPage())),
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
                const SizedBox(
                  height: 200,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
