import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/provider/product_provider.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_size_button.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';

class ShoeSizeWidget extends StatelessWidget {
  const ShoeSizeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            child: Consumer<ProductProvider>(builder: (context, value, child) {
              return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CustomSizeButton(
                        fontColor: value.sizeIndex == index
                            ? AppColors.kWhite
                            : AppColors.kBlack,
                        buttonColor: value.sizeIndex == index
                            ? AppColors.kLiteBlack
                            : AppColors.kWhite,
                        buttonText: value.shoeSizeOnly[index],
                        onTap: () {
                          value.setSizeIndex(index);
                        });
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                  itemCount: value.shoeSizeOnly.length);
            })),
      ],
    );
  }
}
