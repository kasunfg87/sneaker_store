import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';

class PaymentMethod extends ConsumerWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedPaymentIndex = ref.watch(paymentRiverPod).selectedPaymentIndex;
    return Column(
      children: List.generate(
        ref.watch(paymentRiverPod).paymentButton.length,
        (index) {
          final paymentButton = ref.watch(paymentRiverPod).paymentButton[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedPaymentIndex == index
                    ? AppColors.kLiteBlue
                    : AppColors.kLiteBlack.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              splashColor: AppColors.kLiteBlue,
              splashFactory: InkRipple.splashFactory,
              onTap: () {
                ref.read(paymentRiverPod).setPaymentIndex(index);
              },
              child: ListTile(
                focusColor: AppColors.kLiteBlack,
                leading: Icon(
                  paymentButton.iconsName,
                  color: selectedPaymentIndex == index
                      ? AppColors.kLiteBlue
                      : AppColors.kLiteBlack,
                ),
                title: CustomTextRaleway(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  text: paymentButton.text,
                  fontColor: selectedPaymentIndex == index
                      ? AppColors.kLiteBlue
                      : AppColors.kLiteBlack,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
