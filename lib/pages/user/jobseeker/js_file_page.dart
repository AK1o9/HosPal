import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../widgets/text_poppins_widget.dart';

class JobseekerFileStoragePage extends StatefulWidget {
  const JobseekerFileStoragePage({Key? key}) : super(key: key);

  @override
  State<JobseekerFileStoragePage> createState() =>
      _JobseekerFileStoragePageState();
}

class _JobseekerFileStoragePageState extends State<JobseekerFileStoragePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: space18),
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          y20,
          PoppinsTextWidget(
              text: "My Files", size: 64, isBold: true, color: midBlue),
          Divider(
            height: space40,
          ),
        ],
      )),
    );
  }
}
