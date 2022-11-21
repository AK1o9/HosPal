import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospal/pages/user/employer/emp_login_page.dart';
import 'emp_nav_bar.dart';

class EmployerMain extends StatelessWidget {
  const EmployerMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const EmployerNavBar();
        } else {
          return const EmployerLoginPage();
        }
      },
    );
  }
}
