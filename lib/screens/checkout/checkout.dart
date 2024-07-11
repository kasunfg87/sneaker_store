import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_button.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:sneaker_store/widgets/custom_textfield_chekout.dart';
import 'package:sneaker_store/widgets/payment_method_widget.dart';
import 'package:sneaker_store/widgets/screen_header.dart';
import 'package:styled_divider/styled_divider.dart';

class Checkout extends ConsumerStatefulWidget {
  const Checkout({
    required this.orderModel,
    super.key,
  });

  final OrderModel orderModel;

  @override
  ConsumerState<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends ConsumerState<Checkout> {
  String dropdownValue = AssetConstants.addressList.first;

  @override
  Widget build(BuildContext context) {
    int selectedPaymentIndex = ref.watch(paymentRiverPod).selectedPaymentIndex;
    return Scaffold(
      backgroundColor: AppColors.kButtonGray,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: SizeConfig.w(context),
          height: SizeConfig.h(context),
          child: Column(
            children: [
              ScreenHeader(
                title: 'Checkout',
                iconImage: AssetConstants.bag,
                onTapRight: () {},
                onTapLeft: () => Navigator.pop(context),
                rightIconButton: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 26),
                      Container(
                        padding: const EdgeInsets.all(16),
                        width: SizeConfig.w(context),
                        decoration: BoxDecoration(
                          color: AppColors.kWhite,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTextRaleway(
                              text: 'Contact Information',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomTextfieldCheckout(
                              icon: AssetConstants.email,
                              bottomText: 'Email',
                              controller: TextEditingController(
                                text: ref.read(userRiverPod).userModel!.email,
                              ),
                            ),
                            CustomTextfieldCheckout(
                              icon: AssetConstants.call,
                              bottomText: 'Phone',
                              controller: TextEditingController(
                                text:
                                    ref.read(userRiverPod).userModel!.mobileNo,
                              ),
                              textOnTap: () {},
                            ),
                            const SizedBox(height: 12),
                            const CustomTextRaleway(
                              text: 'Address',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            DropdownButton<String>(
                              isDense: false,
                              isExpanded: true,
                              value: dropdownValue,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: AppColors.kLiteBlack,
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              items: AssetConstants.addressList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 20),
                            const CustomTextRaleway(
                              text: 'Payment Method',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 20),
                            const PaymentMethod()
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
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        height: 275,
        width: SizeConfig.w(context),
        decoration: const BoxDecoration(color: AppColors.kWhite),
        child: Column(
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
                  text: '\$${widget.orderModel.cartTotal}',
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
                  text: '\$${widget.orderModel.delivery}',
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
                  text: '\$${widget.orderModel.grandTotal}',
                  fontSize: 16,
                  fontColor: AppColors.kBlack,
                ),
              ],
            ),
            const SizedBox(height: 30),
            CustomButton(
              buttonText: 'Proceed',
              onTap: () {
                if (selectedPaymentIndex == 0) {
                  ref.watch(paymentRiverPod).makePayment(
                        context,
                        widget.orderModel.grandTotal.toString(),
                        widget.orderModel,
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
