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
    this.rightIconButton = true,
    this.rightTextButton = false,
    this.showBadge = false,
    this.badgeText = '0',
    this.backButton = true,
    this.rightButtonText = '0',
    super.key,
  });

  final String title;
  final String iconImage;
  final VoidCallback onTapRight;
  final VoidCallback onTapLeft;
  final bool rightIconButton;
  final bool showBadge;
  final String badgeText;
  final bool backButton;
  final bool rightTextButton;
  final String rightButtonText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (backButton)
          InkWell(
            borderRadius: BorderRadius.circular(15),
            splashFactory: InkRipple.splashFactory,
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
          ),
        CustomTextRaleway(
          text: title,
          fontSize: 20,
          fontColor: AppColors.kBlack,
          fontWeight: FontWeight.w500,
        ),
        if (rightIconButton)
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              splashFactory: InkRipple.splashFactory,
              onTap: onTapRight,
              child: Material(
                borderRadius: BorderRadius.circular(25),
                elevation: 3,
                shadowColor: AppColors.kLiteBlack.withOpacity(0.4),
                child: badges.Badge(
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: AppColors.kLiteBlue,
                    padding: EdgeInsets.all(6),
                  ),
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
                      color: AppColors.kButtonGray,
                      shape: BoxShape.circle,
                    ),
                    child: rightTextButton
                        ? Center(
                            child: CustomTextPopins(
                              text: rightButtonText,
                              fontColor: AppColors.kBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : SvgPicture.asset(iconImage),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
