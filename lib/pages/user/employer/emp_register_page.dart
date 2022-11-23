import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospal/api/user_auth.dart';
import 'package:hospal/constants/style.dart';

import '../../../widgets/custom_button_widget.dart';
import '../../../widgets/text_poppins_widget.dart';
import '../../../widgets/textfield_widget.dart';

class EmployerRegisterPage extends StatefulWidget {
  const EmployerRegisterPage({Key? key}) : super(key: key);

  @override
  State<EmployerRegisterPage> createState() => _EmployerRegisterPageState();
}

class _EmployerRegisterPageState extends State<EmployerRegisterPage> {
  String? role;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? errorMessage = '';
  String? successMessage;

  bool accountCreated = false;

  Widget _errorMessage() {
    // setState(() {
    //   accountCreated = false;
    // });
    return PoppinsTextWidget(
        text: errorMessage == '' ? '' : 'Error: $errorMessage',
        size: fontBody,
        color: Colors.red);
  }

  Widget _successMessage() {
    // setState(() {
    //   accountCreated = true;
    // });
    return PoppinsTextWidget(
        text: errorMessage == '' ? '' : 'Success! $successMessage',
        size: fontBody,
        color: Colors.green);
  }

  Widget buildMessage() {
    if (accountCreated) {
      return _successMessage();
    } else {
      return _errorMessage();
    }
  }

  Future<void> postDetailsToFirestore(String email, String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = UserAuth().currentUser;
    CollectionReference ref = firebaseFirestore.collection('users');
    ref.doc(user!.uid).set(
        {'email': email, 'role': role, 'username': email, 'photo_url': ''});
  }

  Future signUpWithEmailAndPassword() async {
    try {
      //TODO: Fix same email crash.
      // await
      UserAuth()
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((_) {
        postDetailsToFirestore(_emailController.text.trim(), 'Employer')
            .catchError((e) {
          setState(() {
            errorMessage = e;
          });
          if (kDebugMode) {
            print(e);
          }
          throw Exception(e);
        });
        setState(() {
          accountCreated = true;
          successMessage = 'You may now go back and log in.';
        });
        // Navigator.of(context).pop();
        if (kDebugMode) {
          print("Account successfully created!");
        }
      }).catchError((e) {
        // print('[Error] Account not created: $e');
        setState(() {
          accountCreated = false;
          errorMessage = e;
        });
      });
    } on FirebaseAuthException catch (ex) {
      setState(() {
        accountCreated = false;
        errorMessage = ex.message;
      });
      if (kDebugMode) {
        print('Error: [AUTH] $ex');
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (successMessage != null) {
    //   dispose();
    // }
    return Scaffold(
      backgroundColor: midOrange,
      body: Center(
          child: Container(
        width: 500,
        padding: pad20,
        decoration: BoxDecoration(color: light, borderRadius: bRadius20),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.asset('hospal_logo.png'),
            PoppinsTextWidget(
                text: "Employer Register",
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
            TextfieldWidget(
              labelText: "Confirm Password",
              controller: _confirmPasswordController,
              colorTheme: orangeTheme,
              hideText: true,
            ),
            y20,
            // accountCreated ? _successMessage() : _errorMessage(),
            buildMessage(),
            y20,
            CustomButtonWidget(
                label: "Sign Up",
                color: darkOrange,
                onTap: () {
                  if (_emailController.text.isEmpty ||
                      _passwordController.text.isEmpty ||
                      _confirmPasswordController.text.isEmpty) {
                    setState(() {
                      accountCreated = false;
                      errorMessage = 'Please fill up all the fields.';
                    });
                  } else if (!_emailController.text.contains('@') ||
                      !_emailController.text.contains('.')) {
                    setState(() {
                      accountCreated = false;
                      errorMessage = 'Please enter a valid email address.';
                    });
                  } else if (_passwordController.text !=
                      _confirmPasswordController.text) {
                    setState(() {
                      accountCreated = false;
                      errorMessage = 'Passwords do not match.';
                    });
                  } else {
                    //jasonz@example.com jj232323
                    signUpWithEmailAndPassword();
                  }
                }),
            Center(
              child: Padding(
                  padding: pad12,
                  child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: PoppinsTextWidget(
                        text: "Cancel",
                        size: fontBody,
                        color: darkOrange,
                      ))),
            )
          ],
        )),
      )),
    );
  }
}