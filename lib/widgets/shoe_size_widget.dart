import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_size_button.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';

class ShoeSizeWidget extends ConsumerWidget {
  const ShoeSizeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTextRaleway(
          text: 'Size',
          fontSize: 16,
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: SizeConfig.w(context),
            height: 55,
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CustomSizeButton(
                      fontColor: ref.read(productRiverPod).sizeIndex == index
                          ? AppColors.kWhite
                          : AppColors.kBlack,
                      buttonColor: ref.read(productRiverPod).sizeIndex == index
                          ? AppColors.kLiteBlack
                          : AppColors.kWhite,
                      buttonText: ref.read(productRiverPod).shoeSizeOnly[index],
                      onTap: () {
                        ref.read(productRiverPod).setSizeIndex(index);
                      });
                },
                separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                itemCount: ref.read(productRiverPod).shoeSizeOnly.length)),
      ],
    );
  }
}
