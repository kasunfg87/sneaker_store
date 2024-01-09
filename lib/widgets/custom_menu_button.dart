import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';

class CustomMenuButton extends StatelessWidget {
  const CustomMenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      splashFactory: InkRipple.splashFactory,
      onTap: () {
        if (ZoomDrawer.of(context)!.isOpen()) {
          ZoomDrawer.of(context)!.close();
        } else {
          ZoomDrawer.of(context)!.open();
        }
      },
      child: Material(
        borderRadius: BorderRadius.circular(25),
        elevation: 3,
        shadowColor: AppColors.kLiteBlack.withOpacity(0.4),
        child: Container(
            height: 44,
            width: 44,
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              color: AppColors.kWhite,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(AssetConstants.menu)),
      ),
    );
  }
}
