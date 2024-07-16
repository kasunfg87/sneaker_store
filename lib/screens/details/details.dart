import 'package:animate_do/animate_do.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/provider/riverpod.dart';
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
import 'package:carousel_slider/carousel_slider.dart';

class Details extends ConsumerStatefulWidget {
  static String routeName = "/details";

  const Details({
    required this.productModel,
    super.key,
  });

  final ProductModel productModel;

  @override
  ConsumerState<Details> createState() => _DetailsState();
}

class _DetailsState extends ConsumerState<Details> {
  @override
  Widget build(BuildContext context) {
    // Watched values
    final productModel = ref.watch(productRiverPod).productModel;
    final relatedProducts = ref.watch(productRiverPod).relatedProducts;
    final shoeSizes = ref.watch(productRiverPod).shoeSizeOnly;
    final sizeIndex = ref.watch(productRiverPod).sizeIndex;
    final cartItems = ref.watch(cartRiverPod).cartItems;

    return Scaffold(
      backgroundColor: AppColors.kButtonGray,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ScreenHeader(
                title: 'Sneaker Shop',
                iconImage: AssetConstants.bag,
                onTapLeft: () => Navigator.pop(context),
                onTapRight: () {
                  if (cartItems.isNotEmpty) {
                    CustomNavigator.navigateTo(context, const MyCart());
                  } else {
                    AlertHelper.showSanckBar(
                      context,
                      'Your Cart Is Currently Empty!',
                      AnimatedSnackBarType.info,
                    );
                  }
                },
                showBadge: cartItems.isNotEmpty,
                badgeText: cartItems.length.toString(),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        width: SizeConfig.w(context) * 0.50,
                        child: CustomTextRaleway(
                          text: productModel.title,
                          fontSize: 26,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextRaleway(
                        text: productModel.category,
                        fontSize: 16,
                        fontColor: AppColors.kLiteBlack,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 10),
                      CustomTextPopins(
                        text: '\$${productModel.price}',
                        fontColor: AppColors.kBlack,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      Transform.rotate(
                        angle: 50.0,
                        child: Image.network(productModel.img),
                      ),
                      const SizedBox(height: 50),
                      const CustomTextRaleway(
                        text: 'Similar Products',
                        fontSize: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        height: 90,
                        child: CarouselSlider.builder(
                          itemCount: relatedProducts.length,
                          itemBuilder: (context, index, realIndex) {
                            return FadeInRight(
                                child: ReletedItemTile(
                                    model: relatedProducts[index]));
                          },
                          options: CarouselOptions(
                              height: 90,
                              autoPlay: true,
                              autoPlayCurve: Curves.linear,
                              viewportFraction: 0.20,
                              pageSnapping: true,
                              scrollPhysics: const BouncingScrollPhysics()),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const ShoeSizeWidget(),
                      CustomParaReadMore(
                        inputData: productModel.description,
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FavouriteIconWidget(model: productModel),
            const SizedBox(width: 40),
            CustomIconButton(
              buttonText: 'Add To Cart',
              buttonIcon: AssetConstants.bag,
              onTap: () {
                ref.watch(cartRiverPod).addToCart(
                      productModel,
                      context,
                      shoeSizes[sizeIndex],
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
