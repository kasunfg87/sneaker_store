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
    return Scaffold(
        backgroundColor: AppColors.kButtonGray,
        body: Builder(builder: (context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ScreenHeader(
                    title: 'Sneaker Shop',
                    iconImage: AssetConstants.bag,
                    onTapLeft: () => Navigator.pop(context),
                    onTapRight: () {
                      ref.read(cartRiverPod).cartItems.isNotEmpty
                          ? CustomNavigator.navigateTo(context, const MyCart())
                          : AlertHelper.showSanckBar(
                              context,
                              'Your Cart Is Currently Empty!',
                              AnimatedSnackBarType.info);
                    },
                    showBadge: ref.read(cartRiverPod).cartItems.isNotEmpty
                        ? true
                        : false,
                    badgeText:
                        ref.read(cartRiverPod).cartItems.length.toString(),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: SizeConfig.w(context) * 0.50,
                            child: CustomTextRaleway(
                              text:
                                  ref.watch(productRiverPod).productModel.title,
                              fontSize: 26,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextRaleway(
                            text: ref
                                .watch(productRiverPod)
                                .productModel
                                .category,
                            fontSize: 16,
                            fontColor: AppColors.kLiteBlack,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextPopins(
                            text:
                                '\$${ref.watch(productRiverPod).productModel.price}',
                            fontColor: AppColors.kBlack,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                          Transform.rotate(
                            angle: 50.0,
                            child: Image.network(
                                ref.watch(productRiverPod).productModel.img),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              // width: SizeConfig.w(context),
                              height: 90,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return ReletedItemTile(
                                      model: ref
                                          .read(productRiverPod)
                                          .relatedProducts[index],
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        width: 10,
                                      ),
                                  itemCount: ref
                                      .watch(productRiverPod)
                                      .relatedProducts
                                      .length)),
                          const SizedBox(
                            height: 5,
                          ),
                          const ShoeSizeWidget(),
                          CustomParaReadMore(
                            inputData: ref
                                .watch(productRiverPod)
                                .productModel
                                .description,
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
        }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FavouriteIconWidget(
                  model: ref.watch(productRiverPod).productModel),
              const SizedBox(
                width: 40,
              ),
              CustomIconButton(
                buttonText: 'Add To Cart',
                buttonIcon: AssetConstants.bag,
                onTap: () {
                  ref.watch(cartRiverPod).addToCart(
                      ref.watch(productRiverPod).productModel,
                      context,
                      ref
                          .watch(productRiverPod)
                          .shoeSizeOnly[ref.watch(productRiverPod).sizeIndex]);
                },
              ),
            ],
          ),
        ));
  }
}
