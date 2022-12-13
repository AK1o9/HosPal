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

//khalifa.teczo@gmail.com AK1o9@teczo (Jobseeker)
//ahmed1o9@hotmail.com AK1o9@teczo (Jobseeker)
//ziowswaket@gmail.com AK1o9@teczo (Employer)
//theyven@teczo.co theyven@teczo.co (Employer)

class _EmployerLoginPageState extends State<EmployerLoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signInWithEmailAndPassword() async {
    try {
      // await UserAuth()
      //     .signInWithEmailAndPassword(
      //   email: _emailController.text.trim(),
      //   password: _passwordController.text.trim(),
      // )
      //     .then((_) {
      validateUserDetails(_emailController.text.trim(),
          _passwordController.text.trim(), 'Employer');
      // });

      //   UserAuth().validateUserDetails(_emailController.text.trim(),
      //       _passwordController.text.trim(), 'Jobseeker');
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  void validateUserDetails(String email, String password, String role) async {
    // User? user = currentUser;
    //     String result = '';
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(user!.uid)
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     if (documentSnapshot.get('role') == 'Jobseeker') {
    //       result = 'Jobseeker';
    //     } else if (documentSnapshot.get('role') == 'Employer') {
    //       result = 'Employer';
    //     }
    //     // else {}
    //   } else {
    //     print('Document does not exist within the database');
    //   }
    // });
    // return result;

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
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future createUserWithEmailAndPassword() async {
    try {
      await UserAuth().createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _errorMessage() {
    return PoppinsTextWidget(
        text: errorMessage == '' ? '' : 'Error: $errorMessage',
        size: fontBody,
        color: Colors.red);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: midOrange,
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
                // Image.asset('hospal_logo.png'),
                PoppinsTextWidget(
                    text: "Employer Login",
                    size: fontHeader,
                    color: darkOrange,
                    isBold: true),
                y20,
                TextfieldWidget(
                  labelText: "E-mail Address",
                  controller: _emailController,
                  colorTheme: orangeTheme,
                ),
                y20,
                TextfieldWidget(
                  labelText: "Password",
                  controller: _passwordController,
                  colorTheme: orangeTheme,
                  hideText: true,
                ),
                y20,
                _errorMessage(),
                y20,
                CustomButtonWidget(
                    label: "Sign In",
                    color: darkOrange,
                    onTap: (signInWithEmailAndPassword)),
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
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
