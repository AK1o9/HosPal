import 'package:flutter/material.dart';

//Colors
Color dark = Colors.black;
Color light = Colors.white;
Color silver = const Color.fromARGB(255, 230, 230, 230);
Color grey = Colors.black38; //Color.fromARGB(255, 139, 139, 139);
Color aqua = Colors.blue;
Color softBlue = Colors.blue.shade300;
Color midBlue = const Color.fromARGB(255, 77, 85, 200);
Color darkBlue = const Color.fromARGB(255, 59, 75, 163);
Color softOrange = const Color.fromARGB(255, 255, 191, 27);
Color midOrange = const Color.fromARGB(255, 223, 147, 33);
Color darkOrange = const Color.fromARGB(255, 215, 128, 0);

Map<int, Color> darkColors = {
  50: dark,
  100: Colors.black87,
  200: Colors.black54,
  300: Colors.black45,
  400: Colors.black38,
  500: Colors.black26,
  600: Colors.black12,
  700: Colors.white10,
  800: Colors.white12,
  900: Colors.white24,
};

Map<int, Color> blueColors = {
  50: Colors.blue.shade50,
  100: Colors.blue.shade100,
  200: Colors.blue.shade200,
  300: Colors.blue.shade300,
  400: Colors.blue.shade400,
  500: Colors.blue.shade500,
  600: Colors.blue.shade600,
  700: Colors.blue.shade700,
  800: Colors.blue.shade800,
  900: Colors.blue.shade900,
};

Map<int, Color> orangeColors = {
  50: Colors.orange.shade50,
  100: Colors.orange.shade100,
  200: Colors.orange.shade200,
  300: Colors.orange.shade300,
  400: Colors.orange.shade400,
  500: Colors.orange.shade500,
  600: Colors.orange.shade600,
  700: Colors.orange.shade700,
  800: Colors.orange.shade800,
  900: Colors.orange.shade900,
};

MaterialColor darkTheme =
    MaterialColor(0xFF000000, darkColors); //Primary swatch
MaterialColor blueTheme =
    MaterialColor(0xFF0547cb, blueColors); //Primary swatch
MaterialColor orangeTheme =
    MaterialColor(0xFFffaa00, orangeColors); //Primary swatch

//Font sizes
double fontTitle = 24,
    fontSubtitle = 20,
    fontHeader = 18,
    fontSubheader = 16,
    fontLabel = 14,
    fontBody = 12;

//Spacing
double space4 = 4,
    space8 = 8,
    space10 = 10,
    space12 = 12,
    space18 = 18,
    space20 = 20,
    space30 = 30,
    space40 = 40,
    space50 = 50;

//Padding
const EdgeInsets pad5 = EdgeInsets.all(5),
    pad8 = EdgeInsets.all(8),
    pad10 = EdgeInsets.all(10),
    pad12 = EdgeInsets.all(12),
    pad18 = EdgeInsets.all(18),
    pad20 = EdgeInsets.all(20);

//Border Radii
BorderRadius bRadius12 = BorderRadius.circular(12),
    bRadius18 = BorderRadius.circular(18),
    bRadius20 = BorderRadius.circular(20),
    bRadius30 = BorderRadius.circular(30);

//Sized Boxes [x = horizontal (width); y = vertical (height)]
const SizedBox x4 = SizedBox(width: 4),
    x8 = SizedBox(width: 8),
    x10 = SizedBox(width: 10),
    x16 = SizedBox(width: 16),
    x20 = SizedBox(width: 20),
    x30 = SizedBox(width: 30);
const SizedBox y4 = SizedBox(height: 4),
    y8 = SizedBox(height: 8),
    y10 = SizedBox(height: 10),
    y16 = SizedBox(height: 16),
    y20 = SizedBox(height: 20),
    y30 = SizedBox(height: 30);
