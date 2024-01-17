import 'package:flutter/material.dart';


import 'package:flutter_svg/svg.dart';


import 'package:google_fonts/google_fonts.dart';


import 'package:sneaker_store/utilities/assets_constants.dart';


import 'package:sneaker_store/widgets/custom_text_popins.dart';


import '../utilities/app_colors.dart';


class CustomTextfieldCheckout extends StatelessWidget {

  const CustomTextfieldCheckout({

    this.controller,

    this.textInputType = TextInputType.name,

    required this.bottomText,

    required this.icon,

    this.isObscure = false,

    this.suffixIcon,

    this.readOnly = true,

    this.textOnTap,

    super.key,

  });


  final TextEditingController? controller;


  final String bottomText;


  final bool isObscure;


  final Widget? suffixIcon;


  final TextInputType textInputType;


  final bool readOnly;


  final Function()? textOnTap;


  final String icon;


  @override

  Widget build(BuildContext context) {

    return Row(

      crossAxisAlignment: CrossAxisAlignment.end,

      children: [

        Container(

            height: 40,

            width: 40,

            padding: const EdgeInsets.all(10.0),

            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(12),

              color: AppColors.kButtonGray,

            ),

            child: SvgPicture.asset(icon)),

        const SizedBox(

          width: 12,

        ),

        Expanded(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              TextFormField(

                onTap: textOnTap,

                readOnly: readOnly,

                keyboardType: textInputType,

                style: GoogleFonts.poppins(

                    fontSize: 14, fontWeight: FontWeight.w500),

                obscureText: isObscure,

                controller: controller,

                decoration: InputDecoration(

                    border: InputBorder.none,

                    fillColor: AppColors.kButtonGray,

                    focusColor: AppColors.kButtonGray,

                    contentPadding: const EdgeInsets.only(

                      top: 12,

                      left: 10,

                    ),

                    suffixIcon: suffixIcon),

              ),

              Padding(

                padding: const EdgeInsets.only(left: 10),

                child: CustomTextPopins(

                  text: bottomText,

                  fontSize: 12,

                  fontColor: AppColors.kLiteBlack,

                ),

              ),

            ],

          ),

        ),

      ],

    );

  }

}

