import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parsed_readmore/parsed_readmore.dart';
import 'package:sneaker_store/utilities/app_colors.dart';

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
          //Package widget using custom values
          ParsedReadMore(
            inputData,
            textAlign: TextAlign.justify,
            trimMode: TrimMode.line,
            trimLines: 7,
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
