import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/screens/details/details.dart';
import 'package:sneaker_store/screens/search_screen/search_screen.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/navigation_function.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_cart_button.dart';
import 'package:sneaker_store/widgets/custom_category_button.dart';
import 'package:sneaker_store/widgets/custom_menu_button.dart';
import 'package:sneaker_store/widgets/custom_search.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:sneaker_store/widgets/new_arrival_banner.dart';
import 'package:sneaker_store/widgets/product_tile.dart';
import 'package:sneaker_store/widgets/product_tile_placeholder.dart';

class Dashboard extends ConsumerStatefulWidget {
  static String routeName = "/dashboard";

  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kButtonGray,
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomMenuButton(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(AssetConstants.highlight),
                      const CustomTextRaleway(text: 'Explore'),
                    ],
                  ),
                  const CustomCartButton(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.w(context) - 100,
                    child: CustomSearch(
                      controller: ref.watch(productRiverPod).searchController,
                      hintText: 'Looking for shoes',
                      textOnTap: () {
                        CustomNavigator.navigateTo(
                            context, const SearchScreen());
                      },
                      txtOnChange: (text) {
                        CustomNavigator.navigateTo(
                            context, const SearchScreen());
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Container(
                      height: 48,
                      width: 48,
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        color: AppColors.kDarkBlue,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(AssetConstants.slider)),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: CustomTextRaleway(
                  text: 'Select Category',
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  width: SizeConfig.w(context),
                  height: 40,
                  child: ListView.separated(
                      // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CustomCategoryButton(
                            fontColor:
                                ref.watch(productRiverPod).selectedIndex ==
                                        index
                                    ? AppColors.kWhite
                                    : AppColors.kBlack,
                            buttonColor:
                                ref.watch(productRiverPod).selectedIndex ==
                                        index
                                    ? AppColors.kLiteBlue
                                    : AppColors.kWhite,
                            buttonText: AssetConstants.categoryList[index],
                            onTap: () {
                              setState(() {
                                ref
                                    .watch(productRiverPod)
                                    .setSelectedIndex(index);

                                ref
                                    .watch(productRiverPod)
                                    .filterProdutsWithCategory(
                                        AssetConstants.categoryList[index]);
                              });
                            });
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 12,
                          ),
                      itemCount: AssetConstants.categoryList.length)),
              const SizedBox(
                height: 24,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextRaleway(
                    text: 'Popular Shoes',
                    fontSize: 16,
                  ),
                  CustomTextPopins(
                    text: 'See All',
                    fontColor: AppColors.kLiteBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: SizeConfig.w(context),
                  height: SizeConfig.h(context) * 0.30,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ref.watch(productRiverPod).isLoading
                          ? const ProductTilePlaceHolder()
                          : InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                ref.watch(productRiverPod).setSizeIndex(-1);
                                ref.watch(productRiverPod).setProductModel(
                                      ref
                                              .watch(productRiverPod)
                                              .filteredProduct
                                              .isEmpty
                                          ? ref
                                              .watch(productRiverPod)
                                              .allProduct[index]
                                          : ref
                                              .watch(productRiverPod)
                                              .filteredProduct[index],
                                    );
                                CustomNavigator.navigateTo(
                                    context,
                                    Details(
                                        productModel: ref
                                                .watch(productRiverPod)
                                                .filteredProduct
                                                .isEmpty
                                            ? ref
                                                .watch(productRiverPod)
                                                .allProduct[index]
                                            : ref
                                                .watch(productRiverPod)
                                                .filteredProduct[index]));
                              },
                              child: ProductTile(
                                model: ref
                                        .watch(productRiverPod)
                                        .filteredProduct
                                        .isEmpty
                                    ? ref
                                        .watch(productRiverPod)
                                        .allProduct[index]
                                    : ref
                                        .watch(productRiverPod)
                                        .filteredProduct[index],
                              ),
                            );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 22,
                    ),
                    itemCount:
                        ref.watch(productRiverPod).filteredProduct.isEmpty
                            ? ref.watch(productRiverPod).allProduct.length
                            : ref.watch(productRiverPod).filteredProduct.length,
                  )),
              const SizedBox(
                height: 24,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextRaleway(
                    text: 'New Arrivals',
                    fontSize: 16,
                  ),
                  CustomTextPopins(
                    text: 'See All',
                    fontColor: AppColors.kLiteBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const NewArrivalBanner()
            ],
          )),
    );
  }
}
