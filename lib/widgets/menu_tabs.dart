// lib/widgets/menu_tabs.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';

class MenuTabs extends StatelessWidget {
  const MenuTabs({
    required this.buttonText,
    required this.iconImage,
    required this.ontap,
    required this.isSelected,
    super.key,
  });

  final String iconImage;
  final String buttonText;
  final Function() ontap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Stack(
        children: [
          AnimatedContainer(
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 500),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected
                    ? Colors.white.withOpacity(0.5)
                    : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
            ),
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
          ),
          if (isSelected)
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      width: 5.0,
                      style: BorderStyle.solid,
                      color: Colors
                          .transparent, // Make it transparent to allow gradient overlay
                    ),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 5.0,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.blue],
                        begin: Alignment.center,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
