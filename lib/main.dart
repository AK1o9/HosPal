import 'package:flutter/gestures.dart';
import 'package:hospal/constants/style.dart';
import 'package:hospal/pages/front_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hospal/pages/job/job_post_page.dart';
import 'package:hospal/pages/test_page.dart';
import 'package:hospal/pages/user/jobseeker/js_login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: await_only_futures
  await Firebase.initializeApp;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: override_on_non_overriding_member
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'HosPal',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: dark, primarySwatch: darkTheme),
        home: const FrontPage());
  }
}
