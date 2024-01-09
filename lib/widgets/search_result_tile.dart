import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/provider/product_provider.dart';
import 'package:sneaker_store/screens/details/details.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/navigation_function.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';

class SearchResultTile extends StatefulWidget {
  const SearchResultTile(
      {required this.model,
      this.addButton = true,
      this.isFavourite = false,
      super.key});

  final ProductModel model;
  final bool addButton;
  final bool isFavourite;

  @override
  State<SearchResultTile> createState() => _SearchResultTileState();
}

class _SearchResultTileState extends State<SearchResultTile> {
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
            height: 100,
            width: SizeConfig.w(context),
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Transform.rotate(
                    angle: 50.0,
                    child: Image.network(
                      widget.model.img,
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                        return child;
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.kLiteBlue,
                            ),
                          );
                        }
                      },
                      width: 100,
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15, top: 10),
                        child: CustomTextPopins(
                          text: 'BEST SELLER',
                          fontColor: AppColors.kLiteBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: CustomTextRaleway(
                            text: widget.model.title,
                            fontSize: 15,
                            fontColor: AppColors.kLiteBlack,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
