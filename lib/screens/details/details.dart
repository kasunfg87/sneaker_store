import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/provider/cart_provider.dart';
import 'package:sneaker_store/provider/product_provider.dart';
import 'package:sneaker_store/screens/my_cart/my_cart.dart';
import 'package:sneaker_store/utilities/alert_helper.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/navigation_function.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_icon_button.dart';
import 'package:sneaker_store/widgets/custom_para_readmore.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:sneaker_store/widgets/fav_icon_widget.dart';
import 'package:sneaker_store/widgets/releted_item_tile.dart';
import 'package:sneaker_store/widgets/screen_header.dart';
import 'package:sneaker_store/widgets/shoe_size_widget.dart';

class Details extends StatefulWidget {
  const Details({
    required this.productModel,
    super.key,
  });

  final ProductModel productModel;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kButtonGray,
      body: Consumer<ProductProvider>(builder: (context, value, child) {
        return Builder(builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            // height: SizeConfig.h(context),
            // width: SizeConfig.w(context),
            child: Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  ScreenHeader(
                    title: 'Sneaker Shop',
                    iconImage: AssetConstants.bag,
                    onTapLeft: () => Navigator.pop(context),
                    onTapRight: () {
                      Provider.of<CartProvider>(context, listen: false)
                              .cartItems
                              .isNotEmpty
                          ? NavigationFunction.navigateTo(
                              BuildContext, context, Widget, const MyCart())
                          : AlertHelper.showSanckBar(
                              context,
                              'Your Cart Is Currently Empty!',
                              AnimatedSnackBarType.info);
                    },
                    showBadge:
                        Provider.of<CartProvider>(context).cartItems.isNotEmpty
                            ? true
                            : false,
                    badgeText: Provider.of<CartProvider>(context)
                        .cartItems
                        .length
                        .toString(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: SizeConfig.w(context) * 0.50,
                            child: CustomTextRaleway(
                              text: value.productModel.title,
                              fontSize: 26,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextRaleway(
                            text: value.productModel.category,
                            fontSize: 16,
                            fontColor: AppColors.kLiteBlack,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextPopins(
                            text: '\$${value.productModel.price}',
                            fontColor: AppColors.kBlack,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                          Transform.rotate(
                            angle: 50.0,
                            child: Image.network(value.productModel.img),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              // width: SizeConfig.w(context),
                              height: 90,
                              child: Consumer<ProductProvider>(
                                  builder: (context, value, child) {
                                return ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return ReletedItemTile(
                                        model: value.relatedProducts[index],
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          width: 10,
                                        ),
                                    itemCount: value.relatedProducts.length);
                              })),
                          const SizedBox(
                            height: 5,
                          ),
                          const ShoeSizeWidget(),
                          CustomParaReadMore(
                            inputData: value.productModel.description,
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      }),
      bottomNavigationBar:
          Consumer<ProductProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FavouriteIconWidget(model: value.productModel),
              const SizedBox(
                width: 40,
              ),
              CustomIconButton(
                buttonText: 'Add To Cart',
                buttonIcon: AssetConstants.bag,
                onTap: () {
                  Provider.of<CartProvider>(context, listen: false)
                      .addToCart(value.productModel, context);
                  Logger().f(value.productModel.title);
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
