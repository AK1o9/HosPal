// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../constants/style.dart';
import '../../widgets/text_poppins_widget.dart';
import '../job/job_post_page.dart';
import 'emp_about.dart';
import 'emp_post_page.dart';

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
            appBar: AppBar(
              title: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).pop();
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => const HomePage()));
                },
                child: PoppinsTextWidget(
                  text: 'GigHub',
                  color: light,
                  size: fontTitle,
                  isBold: true,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: dark,
              leading: Padding(
                  padding: EdgeInsets.only(
                      left: space18,
                      top: space12,
                      right: space12,
                      bottom: space12),
                  child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {},
                      child: Icon(Icons.menu_rounded, color: light, size: 28))),
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.pages_rounded), text: "About"),
                  Tab(icon: Icon(Icons.work), text: "Jobs")
                ],
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 400,
                  child: TabBarView(children: [
                    About(),
                    Jobs(),
                  ]),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(right: 20),
                //       child: SizedBox(
                //         height: 50,
                //         width: 50,
                //         child: FloatingActionButton(
                //           backgroundColor: dark,
                //           elevation: 16,
                //           child: Icon(
                //             Icons.add,
                //             color: light,
                //           ),
                //           onPressed: () {
                //             Navigator.of(context).push(MaterialPageRoute(
                //                 builder: (context) => JobPostPage()));
                //           },
                //         ),
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          )),
    );
  }
}
