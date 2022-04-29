import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NunitoTextWidget extends StatelessWidget {
  final String text;

  //Font properties
  final double size;
  final Color color;
  final bool isBold;
  final bool isCenter;

  const NunitoTextWidget(
      {Key? key,
      required this.text,
      required this.size,
      required this.color,
      this.isBold = false,
      this.isCenter = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: isCenter ? TextAlign.center : null,
      style: GoogleFonts.getFont('Nunito',
          textStyle: TextStyle(
              color: color,
              fontSize: size,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
    );
  }
}
