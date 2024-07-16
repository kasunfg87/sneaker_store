import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/bottom_balance_widget.dart';
import 'package:sneaker_store/widgets/contact_info_widget.dart';
import 'package:sneaker_store/widgets/custom_button.dart';
import 'package:sneaker_store/widgets/payment_method_widget.dart';
import 'package:sneaker_store/widgets/screen_header.dart';

class Checkout extends ConsumerStatefulWidget {
  const Checkout({
    super.key,
  });

  @override
  ConsumerState<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends ConsumerState<Checkout> {
  @override
  Widget build(BuildContext context) {
    int selectedPaymentIndex = ref.watch(paymentRiverPod).selectedPaymentIndex;
    return Scaffold(
      backgroundColor: AppColors.kButtonGray,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ScreenHeader(
                title: 'Checkout',
                iconImage: AssetConstants.bag,
                onTapRight: () {},
                onTapLeft: () => Navigator.pop(context),
                rightIconButton: false,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 26),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        children: [
                          OrderContactInfo(),
                          SizedBox(height: 20),
                          PaymentMethod()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        height: 275,
        width: SizeConfig.w(context),
        decoration: const BoxDecoration(color: AppColors.kWhite),
        child: Column(
          children: [
            const BottomBalanceWidget(),
            const SizedBox(height: 30),
            CustomButton(
              buttonText: 'Proceed',
              onTap: () {
                if (selectedPaymentIndex == 0) {
                  ref.watch(paymentRiverPod).makePayment(
                        context,
                        ref,
                      );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
