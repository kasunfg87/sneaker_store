import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/provider/cart_provider.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';

class CartTile extends StatelessWidget {
  const CartTile({super.key, required this.model});
  final CartItemModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        width: SizeConfig.w(context),
        height: 90,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.kWhite,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 20,
                color: AppColors.kLiteBlack.withOpacity(0.4),
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    model.productModel.img.toString(),
                    width: 70,
                    height: 70,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextPopins(
                      text: model.productModel.title.toString(),
                      fontSize: 14,
                      fontColor: AppColors.kBlack,
                    ),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .decreaseCartItemQty(
                                      model.productModel, context);
                            },
                            child: const Icon(Icons.remove)),
                        const SizedBox(
                          width: 15,
                        ),
                        CustomTextPopins(
                          text: '${model.amount}',
                          fontColor: AppColors.kBlack,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        InkWell(
                            onTap: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .increaseCartItemQty(model.productModel);
                            },
                            child: const Icon(Icons.add))
                      ],
                    ),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Provider.of<CartProvider>(context, listen: false)
                      .removeCartItem(model.productModel.productId, context),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.kPink,
                  ),
                ),
                CustomTextPopins(
                  text: 'Rs.${model.subTotal}0',
                  fontSize: 15,
                  fontColor: AppColors.kBlack,
                  fontWeight: FontWeight.w700,
                ),
              ],
            )
          ],
        ));
  }
}
