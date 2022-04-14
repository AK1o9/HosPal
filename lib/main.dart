import 'package:flutter/gestures.dart';
import 'package:gighub/constants/style.dart';
import 'package:gighub/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
        title: 'GigHub',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: dark,
            primarySwatch:
                Colors.blue /* TODO: Change to black or other dark colors */),
        home: const HomePage());
  }
}
