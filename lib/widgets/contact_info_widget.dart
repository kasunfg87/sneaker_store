import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:sneaker_store/widgets/custom_textfield_chekout.dart';

class OrderContactInfo extends ConsumerStatefulWidget {
  const OrderContactInfo({super.key});

  @override
  ConsumerState<OrderContactInfo> createState() => _OrderContactInfoState();
}

String dropdownValue = AssetConstants.addressList.first;

class _OrderContactInfoState extends ConsumerState<OrderContactInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            text: ref.read(userRiverPod).userModel!.mobileNo,
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
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
