import 'package:hospal/constants/style.dart';
import 'package:hospal/widgets/text_nunito_widget.dart';
import 'package:hospal/widgets/text_poppins_widget.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String label;
  final Function() onTap;
  final double? fontSize;
  final IconData? icon;
  final Color? color;
  const CustomButtonWidget(
      {Key? key,
      required this.label,
      required this.onTap,
      this.color,
      this.fontSize,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          padding: pad18,
          decoration: BoxDecoration(
              borderRadius: bRadius30, color: color, border: null),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Icon(icon, color: light, size: 18)
                  : Container(width: 0),
              icon != null ? x4 : Container(width: 0),
              NunitoTextWidget(
                  text: label,
                  size: fontSize != null ? fontSize! : fontLabel,
                  color: light),
            ],
          ),
        ),
      ),
    );
  }
}
