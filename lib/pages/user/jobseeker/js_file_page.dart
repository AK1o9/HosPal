import 'package:flutter/material.dart';
import 'package:hospal/widgets/custom_button_widget.dart';

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
    return Scaffold(
      backgroundColor: softGrey,
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: space18),
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
            y10,
            CustomButtonWidget(
              label: 'Upload from Google Drive',
              onTap: () {},
              icon: Icons.add_to_drive_outlined,
              color: darkBlue,
            ),
            y20,
            Container(
              padding: pad12,
              height: 250, //TODO: May remove/change
              decoration: BoxDecoration(
                  borderRadius: bRadius20, border: Border.all(color: midBlue)),
              // child: Column(children: [
              //   //TODO: Column may be replaced w gridlayout
              // ]),
            )
          ],
        ),
      )),
    );
  }
}
