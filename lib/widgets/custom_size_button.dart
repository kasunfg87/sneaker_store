import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utilities/app_colors.dart';

class CustomSizeButton extends StatelessWidget {
  const CustomSizeButton({
    required this.buttonText,
    required this.onTap,
    this.buttonColor = AppColors.kLiteBlack,
    this.fontColor = AppColors.kWhite,
    super.key,
  });

  final String buttonText;
  final Function() onTap;
  final Color buttonColor;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(8),
        splashFactory: InkRipple.splashFactory,
        splashColor: AppColors.kBlack,
        onTap: onTap,
        child: Container(
            // height: 20,
            width: 108,
            // width: SizeConfig.w(context) * 0.7,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Text(
              buttonText,
              style: GoogleFonts.poppins(
                  color: fontColor, fontSize: 14, fontWeight: FontWeight.w300),
            ))));
  }
}
