import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/provider/product_provider.dart';
import 'package:sneaker_store/screens/details/details.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/navigation_function.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:sneaker_store/widgets/small_fav_icon_widget.dart';

class ProductTile extends StatefulWidget {
  const ProductTile(
      {required this.model,
      this.addButton = true,
      this.isFavourite = false,
      super.key});

  final ProductModel model;
  final bool addButton;
  final bool isFavourite;

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 4.0,
        shadowColor: AppColors.kBlack.withOpacity(0.1),
        child: InkWell(
          onTap: () {
            Provider.of<ProductProvider>(context, listen: false)
                .setProductModel(widget.model);
            NavigationFunction.navigateTo(BuildContext, context, Widget,
                Details(productModel: widget.model));
          },
          child: Container(
            width: SizeConfig.w(context) / 2 - 32,
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: SmallFavouriteIconWidget(
                          model: widget.model,
                        ),
                      ),
                      Transform.rotate(
                        angle: 50.0,
                        child: Image.network(widget.model.img, frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                          return child;
                        }, loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Transform.rotate(
                              angle: 50.0,
                              child: Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(192, 224, 223, 223),
                                highlightColor:
                                    AppColors.kWhite.withOpacity(0.5),
                                child:
                                    Image.asset(AssetConstants.shoePlaceHolder),
                              ),
                            );
                          }
                        }),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: CustomTextPopins(
                        text: 'BEST SELLER',
                        fontColor: AppColors.kLiteBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: CustomTextRaleway(
                        text: widget.model.title,
                        fontSize: 14.5,
                        fontColor: AppColors.kLiteBlack,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: CustomTextPopins(
                            text: "\$ ${widget.model.price}",
                            fontSize: 14,
                            fontColor: AppColors.kBlack,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        widget.addButton
                            ? Container(
                                height: 35,
                                width: 35,
                                decoration: const BoxDecoration(
                                    color: AppColors.kLiteBlue,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    )),
                                child: const Icon(
                                  Icons.add,
                                  color: AppColors.kWhite,
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                    widget.addButton
                        ? const SizedBox()
                        : const SizedBox(
                            height: 10,
                          )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
