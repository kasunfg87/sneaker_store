import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';

class MenuTabs extends StatelessWidget {
  const MenuTabs({
    required this.buttonText,
    required this.iconImage,
    required this.ontap,
    super.key,
  });

  final String iconImage;
  final String buttonText;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Row(
        children: [
          SvgPicture.asset(
            iconImage,
            // ignore: deprecated_member_use
            color: AppColors.kButtonGray,
          ),
          const SizedBox(
            width: 27,
          ),
          CustomTextRaleway(
            text: buttonText,
            fontSize: 16,
            fontColor: AppColors.kButtonGray,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    );
  }
}
