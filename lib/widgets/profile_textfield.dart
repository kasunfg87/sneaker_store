// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import '../utilities/app_colors.dart';

class ProfileTextfield extends StatefulWidget {
  const ProfileTextfield({
    this.controller,
    this.textInputType = TextInputType.name,
    required this.headerText,
    this.suffixIcon,
    this.readOnly = true,
    this.textOnTap,
    super.key,
  });

  final TextEditingController? controller;
  final String headerText;

  final Widget? suffixIcon;
  final TextInputType textInputType;
  final bool readOnly;
  final Function()? textOnTap;

  @override
  _ProfileTextfieldState createState() => _ProfileTextfieldState();
}

class _ProfileTextfieldState extends State<ProfileTextfield> {
  late bool isReadOnly;

  @override
  void initState() {
    super.initState();
    isReadOnly = widget.readOnly;
  }

  void toggleReadOnly() {
    setState(() {
      isReadOnly = !isReadOnly;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CustomTextRaleway(
            text: widget.headerText,
            fontSize: 17,
            fontColor: AppColors.kLiteBlack,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          onTap: widget.textOnTap,
          readOnly: isReadOnly,
          keyboardType: widget.textInputType,
          style: GoogleFonts.poppins(fontSize: 16),
          controller: widget.controller,
          decoration: InputDecoration(
            fillColor: AppColors.kButtonGray,
            focusColor: AppColors.kButtonGray,
            filled: true,
            // hintText: widget.hintText,
            hintStyle:
                GoogleFonts.poppins(fontSize: 16, color: AppColors.kLiteBlack),
            contentPadding:
                const EdgeInsets.only(left: 18, top: 12, bottom: 12),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.suffixIcon != null) widget.suffixIcon!,
                IconButton(
                  icon: Icon(
                    isReadOnly ? Icons.edit : Icons.check,
                    color: AppColors.kLiteBlack,
                  ),
                  onPressed: toggleReadOnly,
                ),
              ],
            ),
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
