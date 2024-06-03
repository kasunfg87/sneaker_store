import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import '../utilities/app_colors.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    required this.onTap,
    super.key,
  });

  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(14),
        splashFactory: InkRipple.splashFactory,
        splashColor: const Color.fromRGBO(187, 222, 251, 1),
        onTap: onTap,
        child: Material(
          borderRadius: BorderRadius.circular(14),
          shadowColor: AppColors.kLiteBlack.withOpacity(0.3),
          elevation: 2,
          child: Container(
              width: SizeConfig.w(context) * 0.6,
              height: 50,
              // width: SizeConfig.w(context) * 0.7,
              decoration: BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                  child: Text(
                'Get Started >',
                style: GoogleFonts.raleway(
                    color: AppColors.kBlack,
                    fontSize: 17,
                    fontWeight: FontWeight.w700),
              ))),
        ));
  }
}
