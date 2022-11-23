import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hospal/api/user_auth.dart';
import 'package:hospal/pages/front_page.dart';
import 'package:hospal/pages/user/employer/emp_nav_bar.dart';

import 'jobseeker/js_nav_bar.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: UserAuth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData && UserAuth().userRole == 'Jobseeker') {
          return const JobseekerNavBar(); //Note: If any issues, use JobseekerAuth()
        } else if (snapshot.hasData && UserAuth().userRole == 'Employer') {
          return const EmployerNavBar();
        } else {
          return const FrontPage();
        }
      },
    );
  }
}
