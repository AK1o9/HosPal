import 'package:hospal/constants/style.dart';
import 'package:hospal/widgets/text_poppins_widget.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String label;
  final Function() onTap;
  final bool
      isInverted; //If TRUE => Button is colored white : FALSE => Button is colored black.
  const ElevatedButtonWidget(
      {Key? key,
      required this.label,
      required this.onTap,
      this.isInverted = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pad18,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: dark,
        ),
        child: PoppinsTextWidget(
            text: label, size: fontLabel, color: isInverted ? dark : light),
      ),
    );
  }
}
