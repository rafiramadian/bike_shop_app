import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Radius borderRadius = Radius.circular(16.0);
const double sizeRadius = 16.0;

const Color primaryColor100 = Color(0xFFCFD8DC);
const Color primaryColor300 = Color(0xFF90A4AE);
const Color primaryColor500 = Color(0xFF607D8B);
const Color primaryColor700 = Color(0xFF455A64);
Color colorYellow = Colors.yellow.shade700;
const Color colorWhite = Colors.white;
const Color colorBlack = Colors.black;
const Color backgroundColor = Color(0xffF5F9FF);
const Color darkBlue300 = Color(0xff526983);
const Color darkBlue500 = Color(0xff293948);
const Color darkBlue700 = Color(0xff17212B);

TextStyle greetingTextStyle = GoogleFonts.poppins(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  color: darkBlue500,
);

TextStyle titleTextStyle = GoogleFonts.poppins(
  fontSize: 20,
  fontWeight: FontWeight.w700,
  color: darkBlue500,
);

TextStyle subtitleTextStyle = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: darkBlue300,
);

TextStyle normalTextStyle = GoogleFonts.poppins(
  color: primaryColor500,
);

TextStyle buttonTextStyle = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: colorWhite,
);

TextStyle bottomNavTextStyle = GoogleFonts.poppins(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: darkBlue500,
);

TextStyle descTextStyle = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: darkBlue300,
);

TextStyle tabBarTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: primaryColor500,
);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
