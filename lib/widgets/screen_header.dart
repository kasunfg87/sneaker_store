import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:badges/badges.dart' as badges;

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    required this.title,
    required this.iconImage,
    required this.onTapRight,
    required this.onTapLeft,
    this.rightButton = true,
    this.showBadge = false,
    this.badgeText = '0',
    this.backButton = true,
    super.key,
  });

  final String title;
  final String iconImage;
  final Function() onTapRight;
  final Function() onTapLeft;
  final bool rightButton;
  final bool showBadge;
  final String badgeText;
  final bool backButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        backButton
            ? InkWell(
                onTap: onTapLeft,
                child: Material(
                  borderRadius: BorderRadius.circular(25),
                  elevation: 3,
                  shadowColor: AppColors.kLiteBlack.withOpacity(0.4),
                  child: Container(
                    height: 44,
                    width: 44,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      color: AppColors.kButtonGray,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 24,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        CustomTextRaleway(
          text: title,
          fontSize: 16,
          fontColor: AppColors.kBlack,
          fontWeight: FontWeight.w600,
        ),
        rightButton
            ? Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(25),
                  onTap: onTapRight,
                  child: Material(
                    borderRadius: BorderRadius.circular(25),
                    elevation: 3,
                    shadowColor: AppColors.kLiteBlack.withOpacity(0.4),
                    child: badges.Badge(
                      badgeStyle: const badges.BadgeStyle(
                          badgeColor: AppColors.kLiteBlue,
                          padding: EdgeInsets.all(6)),
                      showBadge: showBadge,
                      badgeContent: CustomTextPopins(
                        fontSize: 13,
                        text: badgeText,
                        fontColor: AppColors.kWhite,
                      ),
                      child: Container(
                          height: 44,
                          width: 44,
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            color: AppColors.kWhite,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(iconImage)),
                    ),
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
