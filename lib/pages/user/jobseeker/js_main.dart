// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:hospal/api/user_auth.dart';

// class JobseekerMain extends StatelessWidget {
//   JobseekerMain({Key? key}) : super(key: key);

//   final User? user = UserAuth().currentUser;

//   Future<void> signOut() async {
//     await UserAuth().signOut();
//   }

//   Widget _userUid() {
//     return Text(user?.email ?? 'User email');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hospal/api/user_auth.dart';
import 'package:hospal/pages/user/jobseeker/js_login_page.dart';
import 'package:hospal/pages/user/jobseeker/js_nav_bar.dart';

class JobseekerMain extends StatelessWidget {
  const JobseekerMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: UserAuth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData && UserAuth().userRole == 'Jobseeker') {
          return const JobseekerNavBar();
        } else {
          return const JobseekerLoginPage();
        }
      },
    );
  }
}
