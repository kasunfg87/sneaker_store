import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/provider/cart_provider.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:sneaker_store/widgets/releted_item_tile.dart';

class SlidableCartTile extends StatelessWidget {
  const SlidableCartTile({
    required this.cartItemModel,
    super.key,
  });

  final CartItemModel cartItemModel;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      closeOnScroll: true,
      key: const ValueKey(0),
      endActionPane: ActionPane(
        extentRatio: 0.2,
        dragDismissible: false,
        motion: const ScrollMotion(),
        children: [
          InkWell(
            onTap: () => Provider.of<CartProvider>(context, listen: false)
                .removeCartItem(cartItemModel.productModel.productId, context),
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(left: 12),
              height: 104,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
              child: SvgPicture.asset(
                AssetConstants.rBin,
              ),
            ),
          )
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 3,
        shadowColor: AppColors.kLiteBlack.withOpacity(0.2),
        child: Container(
          padding:
              const EdgeInsets.only(left: 10, right: 15, top: 10, bottom: 10),
          height: 104,
          width: SizeConfig.w(context) - 40,
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              ReletedItemTile(
                model: cartItemModel.productModel,
                backColor: AppColors.kButtonGray,
                tileHeight: 80,
                tilewidth: 80,
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.w(context) * 0.5,
                    child: CustomTextRaleway(
                      text: cartItemModel.productModel.title.toString(),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextPopins(
                    text: '\$${cartItemModel.subTotal}',
                    fontColor: AppColors.kBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  )
                ],
              ),
              const Expanded(
                child: SizedBox(
                  width: double.infinity,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () =>
                        Provider.of<CartProvider>(context, listen: false)
                            .increaseCartItemQty(cartItemModel.productModel),
                    child: Container(
                      height: 25,
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.kLiteBlack.withOpacity(0.15)),
                        color: AppColors.kButtonGray,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 20,
                      ),
                    ),
                  ),
                  Container(
                    height: 25,
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              color: AppColors.kLiteBlack.withOpacity(0.15)),
                          right: BorderSide(
                              color: AppColors.kLiteBlack.withOpacity(0.15))),
                      color: AppColors.kButtonGray,
                      borderRadius: const BorderRadius.only(),
                    ),
                    child: Center(
                        child: CustomTextPopins(
                      text: '${cartItemModel.amount}',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Provider.of<CartProvider>(context, listen: false)
                            .decreaseCartItemQty(
                                cartItemModel.productModel, context),
                    child: Container(
                      height: 25,
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.kLiteBlack.withOpacity(0.15)),
                        color: AppColors.kButtonGray,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      child: const Icon(
                        Icons.remove,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
