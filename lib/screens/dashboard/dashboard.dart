import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/provider/cart_provider.dart';
import 'package:sneaker_store/provider/product_provider.dart';
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

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kButtonGray,
      body: SingleChildScrollView(
          child: Consumer<CartProvider>(builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: SizeConfig.w(context),
          // height: SizeConfig.h(context),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
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
                      controller: Provider.of<ProductProvider>(context)
                          .searchController,
                      hintText: 'Looking for shoes',
                      textOnTap: () {
                        NavigationFunction.navigateTo(BuildContext, context,
                            Widget, const SearchScreen());
                      },
                      txtOnChange: (text) {
                        NavigationFunction.navigateTo(BuildContext, context,
                            Widget, const SearchScreen());
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
                  child: Consumer<ProductProvider>(
                      builder: (context, value, child) {
                    return ListView.separated(
                        // shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CustomCategoryButton(
                              fontColor: value.selectedIndex == index
                                  ? AppColors.kWhite
                                  : AppColors.kBlack,
                              buttonColor: value.selectedIndex == index
                                  ? AppColors.kLiteBlue
                                  : AppColors.kWhite,
                              buttonText: AssetConstants.categoryList[index],
                              onTap: () {
                                setState(() {
                                  value.setSelectedIndex(index);

                                  value.filterProdutsWithCategory(
                                      AssetConstants.categoryList[index]);
                                });
                              });
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 12,
                            ),
                        itemCount: AssetConstants.categoryList.length);
                  })),
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
                  child: Consumer<ProductProvider>(
                    builder: (context, value, child) {
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              value.setSizeIndex(-1);
                              value.setProductModel(
                                value.filteredProduct.isEmpty
                                    ? value.allProduct[index]
                                    : value.filteredProduct[index],
                              );
                              NavigationFunction.navigateTo(
                                  BuildContext,
                                  context,
                                  Widget,
                                  Details(
                                      productModel:
                                          value.filteredProduct.isEmpty
                                              ? value.allProduct[index]
                                              : value.filteredProduct[index]));
                            },
                            child: ProductTile(
                              model: value.filteredProduct.isEmpty
                                  ? value.allProduct[index]
                                  : value.filteredProduct[index],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 22,
                        ),
                        itemCount: value.filteredProduct.isEmpty
                            ? value.allProduct.length
                            : value.filteredProduct.length,
                      );
                    },
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
          ),
        );
      })),
    );
  }
}
