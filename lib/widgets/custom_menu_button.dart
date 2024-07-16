// lib/widgets/custom_menu_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';

class CustomMenuButton extends ConsumerWidget {
  const CustomMenuButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zoomDrawerController = ref.read(zoomDrawerControllerProvider);

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      splashFactory: InkRipple.splashFactory,
      onTap: () {
        zoomDrawerController.toggle?.call();
      },
      child: Material(
        borderRadius: BorderRadius.circular(25),
        elevation: 3,
        shadowColor: AppColors.kLiteBlack.withOpacity(0.3),
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
