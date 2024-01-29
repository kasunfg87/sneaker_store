import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/provider/cart_provider.dart';
import 'package:sneaker_store/screens/checkout/checkout.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/navigation_function.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_button.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:sneaker_store/widgets/screen_header.dart';
import 'package:sneaker_store/widgets/slidable_cart_tile.dart';
import 'package:styled_divider/styled_divider.dart';
import '../../widgets/custom_text_popins.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kButtonGray,
        body: Consumer<CartProvider>(builder: (context, value, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: SizeConfig.w(context),
            height: SizeConfig.h(context) * 0.70,
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                ScreenHeader(
                  title: 'My Cart',
                  iconImage: AssetConstants.bag,
                  onTapLeft: () => Navigator.pop(context),
                  onTapRight: () {},
                  rightButton: false,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextPopins(
                  text: '${value.cartItems.length} Item',
                  fontSize: 16,
                  fontColor: AppColors.kBlack,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: SizeConfig.w(context),
                  height: SizeConfig.h(context) * .52,
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        // return CartTile(
                        //     model: Provider.of<CartProvider>(context)
                        //         .cartItems[index]);
                        return SlidableCartTile(
                            cartItemModel: value.cartItems[index]);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 14,
                          ),
                      itemCount: value.cartItems.length),
                )
              ],
            )),
          );
        }),
        //-------- Bottom Pannel
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          height: 275,
          width: SizeConfig.w(context),
          decoration: const BoxDecoration(color: AppColors.kWhite),
          child: Consumer<CartProvider>(builder: (context, value, child) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextRaleway(
                      text: 'Subtotal',
                      fontSize: 16,
                      fontColor: AppColors.kLiteBlack.withOpacity(0.5),
                      fontWeight: FontWeight.w600,
                    ),
                    CustomTextPopins(
                      text: '\$${value.getCartTotal.toString()}',
                      fontSize: 16,
                      fontColor: AppColors.kBlack,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextRaleway(
                      text: 'Delivery',
                      fontSize: 16,
                      fontColor: AppColors.kLiteBlack.withOpacity(0.5),
                      fontWeight: FontWeight.w600,
                    ),
                    CustomTextPopins(
                      text: '\$${value.getCartTotal * 0.05}',
                      fontSize: 16,
                      fontColor: AppColors.kBlack,
                    )
                  ],
                ),
                StyledDivider(
                  color: AppColors.kLiteBlack.withOpacity(0.5),
                  height: 50,
                  thickness: 2,
                  lineStyle: DividerLineStyle.dashed,
                  indent: 0,
                  endIndent: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomTextRaleway(
                      text: 'Total Cost',
                      fontSize: 16,
                      fontColor: AppColors.kBlack,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomTextPopins(
                      text:
                          '\$${value.getCartTotal + (value.getCartTotal * 0.05)}',
                      fontSize: 16,
                      fontColor: AppColors.kBlack,
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  buttonText: 'Checkout',
                  onTap: () => NavigationFunction.navigateTo(
                      BuildContext,
                      context,
                      Widget,
                      Checkout(
                        orderModel: OrderModel(
                          orderId: 001,
                          cartTotal: value.getCartTotal,
                          delivery: value.getCartTotal * 0.5,
                          grandTotal:
                              value.getCartTotal + value.getCartTotal * 0.5,
                          cartItems: value.cartItems,
                          createdBy: FirebaseAuth.instance.currentUser!.uid,
                        ),
                      )),
                )
              ],
            );
          }),
        ));
  }
}
