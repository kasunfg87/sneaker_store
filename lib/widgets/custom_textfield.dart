import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import '../utilities/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    this.controller,
    this.textInputType = TextInputType.name,
    required this.headerText,
    required this.hintText,
    this.isObscure = false,
    this.suffixIcon,
    this.readOnly = false,
    this.textOnTap,
    super.key,
  });
  final TextEditingController? controller;

  final String headerText;
  final String hintText;
  final bool isObscure;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  final bool readOnly;
  final Function()? textOnTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CustomTextRaleway(
            text: headerText,
            fontSize: 17,
            fontColor: AppColors.kLiteBlack,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          onTap: textOnTap,
          readOnly: readOnly,
          keyboardType: textInputType,
          style: GoogleFonts.poppins(fontSize: 16),
          obscureText: isObscure,
          controller: controller,
          decoration: InputDecoration(
            fillColor: AppColors.kButtonGray,
            focusColor: AppColors.kButtonGray,
            filled: true,
            hintText: hintText,
            hintStyle:
                GoogleFonts.poppins(fontSize: 16, color: AppColors.kLiteBlack),
            // floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.only(left: 18, top: 12, bottom: 12),
            suffixIcon: suffixIcon,

            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
              borderSide: BorderSide(
                width: 1,
                color: AppColors.kLiteBlack,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
              borderSide: BorderSide(color: AppColors.kButtonGray),
            ),
          ),
        ),
      ],
    );
  }
}
