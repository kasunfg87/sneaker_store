import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import '../utilities/app_colors.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
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
        splashColor: const Color.fromARGB(255, 67, 161, 238),
        onTap: onTap,
        child: Container(
            height: 50,
            // width: SizeConfig.w(context) * 0.7,
            decoration: BoxDecoration(
              color: AppColors.kButtonGray,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetConstants.googleLogo),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  buttonText,
                  style: GoogleFonts.raleway(
                      color: AppColors.kBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ],
            )));
  }
}
