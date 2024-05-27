import 'package:flutter/material.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:styled_divider/styled_divider.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({required this.orderModel, super.key});
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const CustomTextPopins(
              text: 'Order# : ',
              fontColor: AppColors.kBlack,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              width: SizeConfig.w(context) * 0.7,
              child: CustomTextPopins(
                fontColor: AppColors.kBlack,
                text: orderModel.orderId,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const CustomTextPopins(
              text: 'Delivery : ',
              fontColor: AppColors.kBlack,
            ),
            CustomTextPopins(
              fontColor: AppColors.kBlack,
              text: orderModel.delivery.toString(),
            ),
            const SizedBox(
              width: 50,
            ),
            const CustomTextPopins(
              text: 'Total : ',
              fontColor: AppColors.kBlack,
            ),
            CustomTextPopins(
              fontColor: AppColors.kBlack,
              text: orderModel.grandTotal.toString(),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        StyledDivider(
          color: AppColors.kLiteBlack.withOpacity(0.5),
          height: 15,
          thickness: 1,
          lineStyle: DividerLineStyle.dashed,
          indent: 0,
          endIndent: 0,
        ),
        Column(
          children: List.generate(orderModel.cartItems.length, (index) {
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: AppColors.kLiteGray.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(10),
              height: 100,
              width: SizeConfig.w(context),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: 50,
                    child: Image.network(
                      orderModel.cartItems[index].productModel.img,
                      width: SizeConfig.w(context) * 0.2,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: SizeConfig.w(context) * 0.4,
                            child: CustomTextPopins(
                              text: orderModel
                                  .cartItems[index].productModel.title,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontColor: AppColors.kBlack,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CustomTextPopins(
                            text:
                                'Qty: ${orderModel.cartItems[index].amount.toString()}',
                            fontSize: 14,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CustomTextPopins(
                            text:
                                'Size: ${orderModel.cartItems[index].size.toString()}',
                            fontSize: 14,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CustomTextPopins(
                            text:
                                '\$ ${orderModel.cartItems[index].subTotal.toString()}'
                                '0',
                            fontSize: 14,
                            fontColor: AppColors.kBlack,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          }),
        )
      ],
    );
  }
}
