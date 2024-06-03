import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import '../utilities/app_colors.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch(
      {this.controller,
      this.textInputType = TextInputType.name,
      required this.hintText,
      this.isObscure = false,
      this.prefixIcon,
      this.readOnly = false,
      this.textOnTap,
      super.key,
      this.txtOnChange,
      this.focus = false});
  final TextEditingController? controller;

  final String hintText;
  final bool isObscure;
  final Widget? prefixIcon;
  final TextInputType textInputType;
  final bool readOnly;
  final Function()? textOnTap;
  final Function(String value)? txtOnChange;
  final bool focus;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(14),
      elevation: 4.0,
      shadowColor: AppColors.kBlack.withOpacity(0.1),
      child: TextField(
        autofocus: focus,
        onTap: textOnTap,
        onChanged: txtOnChange,
        readOnly: readOnly,
        keyboardType: textInputType,
        style: GoogleFonts.poppins(fontSize: 16),
        obscureText: isObscure,
        controller: controller,
        decoration: InputDecoration(
          fillColor: AppColors.kWhite,
          focusColor: AppColors.kWhite,
          filled: true,
          hintText: hintText,
          hintStyle:
              GoogleFonts.poppins(fontSize: 16, color: AppColors.kLiteBlack),
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.only(left: 18, top: 12, bottom: 12),

          prefixIcon: Padding(
            padding:
                const EdgeInsets.only(left: 30, top: 12, bottom: 12, right: 12),
            child: SvgPicture.asset(
              AssetConstants.searchIcon,
            ),
          ),

          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
            borderSide: BorderSide(
              width: 0,
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
    );
  }
}
