import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';

import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_text_lilita.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';

class NewArrivalBanner extends StatelessWidget {
  const NewArrivalBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      fit: StackFit.loose,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          height: 130,
          width: SizeConfig.w(context),
          decoration: BoxDecoration(
              border: Border.all(
                  style: BorderStyle.solid,
                  color: AppColors.kLiteBlack.withOpacity(0.3),
                  width: 1),
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(16)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextRaleway(
                text: 'Summer Sale',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 4,
              ),
              CustomTextLilita(
                text: '15% OFF',
                fontColor: AppColors.kPink,
                fontSize: 36,
              )
            ],
          ),
        ),
        Positioned(
          right: 5,
          child: Transform.rotate(
            angle: 50,
            child: Image.asset(
              AssetConstants.shoe6,
              width: 210,
              height: 100,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
            bottom: 12,
            left: 10,
            child: SvgPicture.asset(
              AssetConstants.star,
              height: 25,
            )),
        Positioned(
            top: 5,
            left: SizeConfig.w(context) * 0.35,
            child: SvgPicture.asset(
              AssetConstants.star,
              // ignore: deprecated_member_use
              color: AppColors.kLiteBlack.withOpacity(0.7),
              height: 25,
            )),
        Positioned(
            top: 20,
            right: SizeConfig.w(context) * 0.39,
            child: SvgPicture.asset(
              AssetConstants.newv,
              // ignore: deprecated_member_use
              color: AppColors.kBlack,
              height: 30,
            ))
      ],
    );
  }
}
