import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utilities/app_colors.dart';

class CustomTextPopins extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const CustomTextPopins({
    required this.text,
    this.fontSize = 17,
    this.fontColor = AppColors.kLiteGray,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        color: fontColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
}
