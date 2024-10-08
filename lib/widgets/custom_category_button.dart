import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utilities/app_colors.dart';

class CustomCategoryButton extends StatelessWidget {
  const CustomCategoryButton({
    required this.buttonText,
    required this.onTap,
    this.buttonColor = AppColors.kLiteBlue,
    this.fontColor = AppColors.kWhite,
    super.key,
  });

  final String buttonText;
  final VoidCallback onTap;
  final Color buttonColor;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      splashFactory: InkRipple.splashFactory,
      splashColor: AppColors.kBlack,
      onTap: onTap,
      child: AnimatedContainer(
        curve: Curves.linearToEaseOut,
        duration: const Duration(milliseconds: 500),
        width: 108,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              style: BorderStyle.solid,
              color: AppColors.kLiteBlack.withOpacity(0.4),
              width: 0.8),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.poppins(
              color: fontColor,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
