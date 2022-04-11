import 'package:gighub/constants/style.dart';
import 'package:gighub/widgets/text_poppins_widget.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final bool
      isInverted; //If TRUE => Button is colored white : FALSE => Button is colored black.
  const ButtonWidget(
      {Key? key,
      required this.label,
      required this.onTap,
      this.isInverted = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: pad20,
        decoration: BoxDecoration(
            borderRadius: bRadius30,
            color: isInverted ? light : dark,
            border: isInverted ? Border.all(color: dark, width: 0.5) : null),
        child: PoppinsTextWidget(
            text: label, size: fontLabel, color: isInverted ? dark : light),
      ),
    );
  }
}
