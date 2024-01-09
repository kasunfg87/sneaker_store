import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utilities/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.buttonText,
    required this.onTap,
    super.key,
  });
  final String buttonText;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(14),
        splashFactory: InkRipple.splashFactory,
        splashColor: Colors.blue.shade100,
        onTap: onTap,
        child: Container(
            height: 50,
            // width: SizeConfig.w(context) * 0.7,
            decoration: BoxDecoration(
              color: AppColors.kLiteBlue,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
                child: Text(
              buttonText,
              style: GoogleFonts.raleway(
                  color: AppColors.kWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ))));
  }
}
