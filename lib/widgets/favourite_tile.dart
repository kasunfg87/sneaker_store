import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/screens/details/details.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/navigation_function.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/small_fav_icon_widget.dart';

class FavouriteTile extends ConsumerWidget {
  const FavouriteTile({
    super.key,
    required this.model,
    this.addButton = true,
    this.isFavourite = false,
  });

  final ProductModel model;
  final bool addButton;
  final bool isFavourite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.topRight,
      fit: StackFit.loose,
      children: [
        InkWell(
          onTap: () {
            ref.read(productRiverPod).setProductModel(model);
            CustomNavigator.navigateTo(
              context,
              Details(productModel: model),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.kWhite.withOpacity(0.5),
                border: Border.all(
                    width: 1, color: AppColors.kLiteGray.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.all(10),
            height: 105,
            width: SizeConfig.w(context),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: 50,
                  child: Image.network(
                    model.img,
                    width: SizeConfig.w(context) * 0.19,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CustomTextPopins(
                      text: 'BEST SELLER',
                      fontColor: AppColors.kLiteBlue,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      width: SizeConfig.w(context) * 0.5,
                      child: CustomTextPopins(
                        text: model.title,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontColor: AppColors.kBlack,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomTextPopins(
                      text: '\$ ${model.price}'
                          '0',
                      fontSize: 14,
                      fontColor: AppColors.kBlack,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: SmallFavouriteIconWidget(model: model),
        ),
        Positioned(
          bottom: 1,
          right: 1,
          child: Container(
            height: 35,
            width: 35,
            decoration: const BoxDecoration(
              color: AppColors.kLiteBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: const Icon(
              Icons.add,
              color: AppColors.kWhite,
            ),
          ),
        ),
      ],
    );
  }
}
