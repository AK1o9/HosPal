import 'package:hospal/constants/style.dart';
import 'package:hospal/widgets/text_nunito_widget.dart';
import 'package:hospal/widgets/text_poppins_widget.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String label;
  final Function() onTap;
  final double? fontSize;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? fontColor;
  final bool isFontBold;
  const CustomButtonWidget({
    Key? key,
    required this.label,
    required this.onTap,
    this.backgroundColor,
    this.fontColor,
    this.fontSize,
    this.icon,
    this.isFontBold = false,
  }) : super(key: key);

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
              borderRadius: bRadius30, color: backgroundColor, border: null),
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
                color: fontColor != null ? fontColor! : light,
                isBold: isFontBold ? true : false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
