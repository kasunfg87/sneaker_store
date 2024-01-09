import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_button.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:sneaker_store/widgets/custom_textfield_chekout.dart';
import 'package:sneaker_store/widgets/screen_header.dart';
import 'package:styled_divider/styled_divider.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String dropdownValue = AssetConstants.addressList.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kButtonGray,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: SizeConfig.w(context),
          height: SizeConfig.h(context),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              ScreenHeader(
                title: 'Checkout',
                iconImage: AssetConstants.bag,
                onTapRight: () {},
                onTapLeft: () => Navigator.pop(context),
                rightButton: false,
              ),
              const SizedBox(
                height: 26,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                height: SizeConfig.h(context) * 0.78,
                width: SizeConfig.w(context),
                decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextRaleway(
                      text: 'Contact Information',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomTextfieldCheckout(
                      icon: AssetConstants.email,
                      bottomText: 'Email',
                      controller: TextEditingController(
                          text: 'emmanueloyboke@gamil.com'),
                    ),
                    CustomTextfieldCheckout(
                      icon: AssetConstants.call,
                      bottomText: 'Phone',
                      controller:
                          TextEditingController(text: '+234-811-732-5298'),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const CustomTextRaleway(
                      text: 'Address',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    DropdownButton<String>(
                      isDense: false,
                      isExpanded: true,
                      value: dropdownValue,
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: AppColors.kLiteBlack),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: AssetConstants.addressList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 101,
                      decoration: BoxDecoration(
                          color: AppColors.kLiteBlue,
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(AssetConstants.mapImage))),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const CustomTextRaleway(
                      text: 'Payment Method',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              )
            ],
          )),
        ),
        //-------- Bottom Pannel
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
                  const CustomTextPopins(
                    text: '\$753.95',
                    fontSize: 16,
                    fontColor: AppColors.kBlack,
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextRaleway(
                    text: 'Delivery',
                    fontSize: 16,
                    fontColor: AppColors.kLiteBlack.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                  ),
                  const CustomTextPopins(
                    text: '\$60.20',
                    fontSize: 16,
                    fontColor: AppColors.kBlack,
                  )
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextRaleway(
                    text: 'Total Cost',
                    fontSize: 16,
                    fontColor: AppColors.kBlack,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomTextPopins(
                    text: '\$814.15',
                    fontSize: 16,
                    fontColor: AppColors.kBlack,
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(buttonText: 'Checkout', onTap: () {})
            ],
          ),
        ));
  }
}
