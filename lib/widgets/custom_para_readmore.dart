import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parsed_readmore/parsed_readmore.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';

class CustomParaReadMore extends StatelessWidget {
  const CustomParaReadMore({
    required this.inputData,
    super.key,
  });

  final String inputData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomTextRaleway(
            text: 'Product Details',
            fontSize: 16,
          ),
          const SizedBox(
            height: 10,
          ),
          ParsedReadMore(
            inputData,
            textAlign: TextAlign.justify,
            trimMode: TrimMode.line,
            trimLines: 5,
            delimiter: '........ ',
            delimiterStyle: GoogleFonts.poppins(
              fontSize: 15,
              color: AppColors.kLiteBlack,
            ),
            style: GoogleFonts.poppins(
                fontSize: 15,
                color: AppColors.kLiteBlack,
                textStyle: const TextStyle(wordSpacing: 1)),
            trimCollapsedText: 'Read More',
            trimExpandedText: 'Read Less',
            moreStyle:
                GoogleFonts.poppins(fontSize: 15, color: AppColors.kLiteBlue),
            lessStyle:
                GoogleFonts.poppins(fontSize: 15, color: AppColors.kLiteBlue),
          ),
        ],
      ),
    );
  }
}
