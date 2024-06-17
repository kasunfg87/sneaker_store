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
    final productProvider = ref.watch(productRiverPod);
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
                      fontColor: productProvider.sizeIndex == index
                          ? AppColors.kWhite
                          : AppColors.kBlack,
                      buttonColor: productProvider.sizeIndex == index
                          ? AppColors.kLiteBlue
                          : AppColors.kButtonGray,
                      buttonText: productProvider.shoeSizeOnly[index],
                      onTap: () {
                        productProvider.setSizeIndex(index);
                      });
                },
                separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                itemCount: productProvider.shoeSizeOnly.length)),
      ],
    );
  }
}
