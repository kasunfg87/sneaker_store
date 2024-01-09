import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/provider/cart_provider.dart';
import 'package:sneaker_store/screens/my_cart/my_cart.dart';
import 'package:sneaker_store/utilities/alert_helper.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/navigation_function.dart';
import 'package:badges/badges.dart' as badges;
import 'package:sneaker_store/widgets/custom_text_popins.dart';

class CustomCartButton extends StatelessWidget {
  const CustomCartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, value, child) {
      return InkWell(
        borderRadius: BorderRadius.circular(15),
        splashFactory: InkRipple.splashFactory,
        onTap: () => value.cartItems.isEmpty
            ? AlertHelper.showSanckBar(context, 'Your Cart Is Currently Empty!',
                AnimatedSnackBarType.info)
            : NavigationFunction.navigateTo(
                BuildContext, context, Widget, const MyCart()),
        child: Material(
          borderRadius: BorderRadius.circular(25),
          elevation: 3,
          shadowColor: AppColors.kLiteBlack.withOpacity(0.4),
          child: badges.Badge(
            badgeStyle: const badges.BadgeStyle(
                badgeColor: AppColors.kLiteBlue, padding: EdgeInsets.all(6)),
            showBadge: value.cartItems.isEmpty ? false : true,
            badgeContent: CustomTextPopins(
              fontSize: 13,
              text: value.cartItems.length.toString(),
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
                child: SvgPicture.asset(AssetConstants.bag)),
          ),
        ),
      );
    });
  }
}
