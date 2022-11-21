import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hospal/api/user_auth.dart';
import 'package:hospal/constants/style.dart';
import 'package:hospal/widgets/button_widget.dart';
import 'package:hospal/widgets/text_poppins_widget.dart';
import 'package:hospal/widgets/textfield_widget.dart';

import '../../../widgets/custom_button_widget.dart';
import '../register_page.dart';

class JobseekerLoginPage extends StatefulWidget {
  @override
  State<JobseekerLoginPage> createState() => _JobseekerLoginPageState();
}

class _JobseekerLoginPageState extends State<JobseekerLoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signInWithEmailAndPassword() async {
    try {
      await UserAuth().signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
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
                // Image.asset('hospal_logo.png'),
                PoppinsTextWidget(
                    text: "Jobseeker Login",
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
                _errorMessage(),
                y20,
                CustomButtonWidget(
                    label: "Sign In",
                    color: darkBlue,
                    onTap: (signInWithEmailAndPassword)),
                Padding(
                    padding: pad12,
                    child: InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage())),
                        child: PoppinsTextWidget(
                          text: "Don't have an account? Click here to register",
                          size: fontBody,
                          color: darkBlue,
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
