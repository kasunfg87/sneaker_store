import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utilities/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.buttonText,
    required this.buttonIcon,
    required this.onTap,
    super.key,
  });
  final String buttonText;
  final Function() onTap;
  final String buttonIcon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(14),
        splashFactory: InkRipple.splashFactory,
        splashColor: Colors.blue.shade100,
        onTap: onTap,
        child: Material(
          borderRadius: BorderRadius.circular(14),
          elevation: 3,
          shadowColor: AppColors.kLiteBlack.withOpacity(0.4),
          child: AnimatedContainer(
              curve: Curves.linear,
              duration: const Duration(milliseconds: 100),
              height: 50,
              width: 208,
              // width: SizeConfig.w(context) * 0.7,
              decoration: BoxDecoration(
                color: AppColors.kLiteBlue,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    buttonIcon,
                    // ignore: deprecated_member_use
                    color: AppColors.kWhite,
                  ),
                  Text(
                    buttonText,
                    style: GoogleFonts.raleway(
                        color: AppColors.kWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )),
        ));
  }
}
