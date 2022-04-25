import 'package:flutter/material.dart';
import 'package:gighub/constants/style.dart';
import 'package:gighub/pages/js_home_page.dart';
import 'package:gighub/widgets/button_widget.dart';

import 'emp_home_page.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: pad20,
        child: Row(children: [
          Expanded(
            child: ButtonWidget(
                label: 'Jobseeker',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const JobseekerHomePage()));
                }),
          ),
          x20,
          Expanded(
            child: ButtonWidget(
                label: 'Employer',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const EmployerHomePage()));
                }),
          )
        ]),
      ),
    );
  }
}
