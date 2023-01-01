import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hospal/api/user_auth.dart';
import 'package:hospal/constants/style.dart';

import '../../../widgets/custom_button_widget.dart';
import '../../../widgets/text_poppins_widget.dart';
import '../../../widgets/textfield_widget.dart';

class JobseekerRegisterPage extends StatefulWidget {
  const JobseekerRegisterPage({Key? key}) : super(key: key);

  @override
  State<JobseekerRegisterPage> createState() => _JobseekerRegisterPageState();
}

class _JobseekerRegisterPageState extends State<JobseekerRegisterPage> {
  String? role;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? errorMessage;
  String? successMessage;

  bool accountCreated = false;
//TODO: To function similar to a stepper (step 1: jobseeker or employer, step 2: fill in details, ...)

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Widget _errorMessage() {
    // setState(() {
    //   accountCreated = false;
    // });
    return errorMessage == null
        ? Container(
            width: 0,
          )
        : PoppinsTextWidget(
            text: 'Error: $errorMessage',
            size: fontBody,
            color: Colors.red.shade900);
  }

  Widget _successMessage() {
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
    await ref.doc(user!.uid).set({
      'email': email,
      'role': role,
      'username': email,
      'photo_url': '',
      'description': ''
    });
  }

  Future signUpWithEmailAndPassword() async {
    try {
      //TODO: Fix same email crash.
      // await
      await UserAuth()
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((_) async {
        await postDetailsToFirestore(_emailController.text.trim(), 'Jobseeker')
            /* .catchError((e) {
          // setState(() {
          errorMessage = e.message!;
          // });
          if (kDebugMode) {
            print(e);
          }
          // throw Exception(e);
        }) */
            ;
        setState(() {
          accountCreated = true;
          successMessage = 'You may now go back and log in.';
        });
        // Navigator.of(context).pop();
        if (kDebugMode) {
          print("Account successfully created!");
        }
      }); /* .catchError((e) {
        // print('[Error] Account not created: $e');
        setState(() {
          accountCreated = false;
          errorMessage = e;
        });
      }); */
    } on FirebaseAuthException catch (ex) {
      /* accountCreated
          ?  */
      setState(() {
        accountCreated = false;
        errorMessage = ex.message!;
      });
      // : null;
      if (kDebugMode) {
        print('Error: [AUTH] ${ex.message}');
      }
    }
  }

  void validateData(String email, String password, String confirmPassword) {
    //Format Validation
    String emailPattern = r'\w+a\w+\.\w+';
    String passwordPattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    //Full Validation
    if ((email.isEmpty || email == '') ||
        (password.isEmpty || password == '') ||
        (confirmPassword.isEmpty || confirmPassword == '')) {
      setState(() {
        accountCreated ? accountCreated = false : null;
        errorMessage = 'Please fill up all the fields.';
      });
    } else if (!email.contains('@') || !email.contains('.')) {
      setState(() {
        accountCreated ? accountCreated = false : null;
        errorMessage = 'Please enter a valid e-mail address.';
      });
    } else if (password != confirmPassword) {
      setState(() {
        accountCreated ? accountCreated = false : null;
        errorMessage = 'Passwords do not match.';
      });
    } else if (!RegExp(emailPattern).hasMatch(email)) {
      setState(() {
        accountCreated ? accountCreated = false : null;
        errorMessage = 'Invalid e-mail address format.';
      });
    } else if (/* password.characters.length < 8 &&  */ !RegExp(passwordPattern)
        .hasMatch(password)) {
      setState(() {
        accountCreated ? accountCreated = false : null;
        errorMessage =
            'Passwords must be atleast 8 characters long & consist of a combination of atleast numbers, uppercase letters and symbols.';
      });
    } else {
      signUpWithEmailAndPassword();
      setState(() {});
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
      backgroundColor: midBlue,
      body: Form(
        key: _key,
        child: Center(
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
                  text: "Jobseeker Register",
                  size: fontHeader,
                  color: darkBlue,
                  isBold: true),
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
              TextfieldWidget(
                labelText: "Confirm Password",
                controller: _confirmPasswordController,
                colorTheme: blueTheme,
                hideText: true,
              ),
              y16,
              // accountCreated ? _successMessage() : _errorMessage(),
              buildMessage(),
              y16,
              CustomButtonWidget(
                  label: "Sign Up",
                  backgroundColor: darkBlue,
                  onTap: () {
                    validateData(
                        _emailController.text,
                        _passwordController.text,
                        _confirmPasswordController.text);
                  }),
              Center(
                child: Padding(
                    padding: pad12,
                    child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: PoppinsTextWidget(
                          text: "Cancel",
                          size: fontBody,
                          color: darkBlue,
                        ))),
              )
            ],
          )),
        )),
      ),
    );
  }
}
