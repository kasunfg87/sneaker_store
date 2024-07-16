import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_uuids/short_uuids.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/screens/checkout/checkout.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/navigation_function.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/bottom_balance_widget.dart';
import 'package:sneaker_store/widgets/custom_button.dart';
import 'package:sneaker_store/widgets/screen_header.dart';
import 'package:sneaker_store/widgets/slidable_cart_tile.dart';
import '../../widgets/custom_text_popins.dart';

class MyCart extends ConsumerStatefulWidget {
  static String routeName = "/mycart";

  const MyCart({super.key});

  @override
  ConsumerState<MyCart> createState() => _MyCartState();
}

const short = ShortUuid();

class _MyCartState extends ConsumerState<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kButtonGray,
        body: SafeArea(
          child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScreenHeader(
                    title: 'My Cart',
                    iconImage: AssetConstants.bag,
                    onTapLeft: () => Navigator.pop(context),
                    onTapRight: () {},
                    rightIconButton: false,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextPopins(
                    text: '${ref.watch(cartRiverPod).cartItems.length} Item',
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
                              cartItemModel:
                                  ref.watch(cartRiverPod).cartItems[index]);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 14,
                            ),
                        itemCount: ref.watch(cartRiverPod).cartItems.length),
                  )
                ],
              )),
        ),
        //-------- Bottom Pannel
        bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            height: 275,
            width: SizeConfig.w(context),
            decoration: const BoxDecoration(color: AppColors.kWhite),
            child: Column(
              children: [
                const BottomBalanceWidget(),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  buttonText: 'Checkout',
                  onTap: () =>
                      CustomNavigator.navigateTo(context, const Checkout()),
                )
              ],
            )));
  }
}
