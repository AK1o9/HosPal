// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EmployerProfilePage extends StatefulWidget {
  const EmployerProfilePage({Key? key}) : super(key: key);

  @override
  State<EmployerProfilePage> createState() => _EmployerProfileState();
}

class _EmployerProfileState extends State<EmployerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            body: Column(
              children: const [
                Text("Employer Profile")
              ], //TODO: Design Profile page.
            ),
          )),
    );
  }
}
