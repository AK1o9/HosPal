import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hospal/constants/style.dart';
import 'package:hospal/widgets/button_widget.dart';
import 'package:hospal/widgets/text_poppins_widget.dart';
import 'package:hospal/widgets/textfield_widget.dart';

import '../../../widgets/custom_button_widget.dart';

class JobseekerLoginPage extends StatefulWidget {
  const JobseekerLoginPage({Key? key}) : super(key: key);

  @override
  State<JobseekerLoginPage> createState() => _JobseekerLoginPageState();
}

class _JobseekerLoginPageState extends State<JobseekerLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
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
          height: 300,
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
                    colorTheme: blueTheme),
                y20, y20,
                GestureDetector(
                    onTap: signIn,
                    child: CustomButtonWidget(
                        label: "Sign In", color: darkBlue, onTap: () {}))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
