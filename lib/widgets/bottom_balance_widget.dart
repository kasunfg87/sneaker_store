import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store/provider/cart_provider.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:styled_divider/styled_divider.dart';

class BottomBalanceWidget extends ConsumerWidget {
  const BottomBalanceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CartProvider cartProvider = ref.watch(cartRiverPod);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextRaleway(
              text: 'Subtotal',
              fontSize: 16,
              fontColor: AppColors.kLiteBlack.withOpacity(0.5),
              fontWeight: FontWeight.w600,
            ),
            CustomTextPopins(
              text: '\$${cartProvider.getCartTotal.toString()}',
              fontSize: 16,
              fontColor: AppColors.kBlack,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextRaleway(
              text: 'Delivery',
              fontSize: 16,
              fontColor: AppColors.kLiteBlack.withOpacity(0.5),
              fontWeight: FontWeight.w600,
            ),
            CustomTextPopins(
              text: '\$${cartProvider.getDeliveryCharge.toString()}',
              fontSize: 16,
              fontColor: AppColors.kBlack,
            ),
          ],
        ),
        StyledDivider(
          color: AppColors.kLiteBlack.withOpacity(0.5),
          height: 50,
          thickness: 2,
          lineStyle: DividerLineStyle.dashed,
          indent: 0,
          endIndent: 0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomTextRaleway(
              text: 'Total Cost',
              fontSize: 16,
              fontColor: AppColors.kBlack,
              fontWeight: FontWeight.w600,
            ),
            CustomTextPopins(
              text: '\$${cartProvider.getGrandTotal.toString()}',
              fontSize: 16,
              fontColor: AppColors.kBlack,
            ),
          ],
        ),
      ],
    );
  }
}
