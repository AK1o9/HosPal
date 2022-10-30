import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../widgets/text_poppins_widget.dart';

class EmployerPostHistoryPage extends StatefulWidget {
  const EmployerPostHistoryPage({Key? key}) : super(key: key);

  @override
  State<EmployerPostHistoryPage> createState() =>
      _EmployerPostHistoryPageState();
}

class _EmployerPostHistoryPageState extends State<EmployerPostHistoryPage> {
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
                  text: "My Job Posts",
                  size: 64,
                  isBold: true,
                  color: midOrange),
              Divider(
                height: space40,
              ),
            ],
          ),
        ));
  }
}
