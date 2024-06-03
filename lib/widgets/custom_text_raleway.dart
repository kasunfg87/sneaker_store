import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utilities/app_colors.dart';

class CustomTextRaleway extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const CustomTextRaleway({
    required this.text,
    this.fontSize = 33,
    this.fontColor = AppColors.kBlack,
    this.fontWeight = FontWeight.bold,
    this.textAlign = TextAlign.left,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // overflow: TextOverflow.ellipsis,
      style: GoogleFonts.raleway(
        color: fontColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      overflow: TextOverflow.clip,

      textAlign: textAlign,
    );
  }
}
