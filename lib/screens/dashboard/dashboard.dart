import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/screens/dashboard/widgets/category_list.dart';
import 'package:sneaker_store/screens/dashboard/widgets/popular_shoes_section.dart';
import 'package:sneaker_store/screens/search_screen/search_screen.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/navigation_function.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_cart_button.dart';
import 'package:sneaker_store/widgets/custom_menu_button.dart';
import 'package:sneaker_store/widgets/custom_search.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:sneaker_store/widgets/new_arrival_banner.dart';

class Dashboard extends ConsumerStatefulWidget {
  static String routeName = "/dashboard";

  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final productProvider = ref.watch(productRiverPod);
    return Scaffold(
      backgroundColor: AppColors.kButtonGray,
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
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
                        controller: productProvider.searchController,
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
                  child:
                      CustomTextRaleway(text: 'Select Category', fontSize: 16),
                ),
                const SizedBox(height: 16),
                CategoryList(productProvider: productProvider),
                const SizedBox(
                  height: 24,
                ),
                const PopularShoesSection(),
                const SizedBox(height: 24),
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
      ),
    );
  }
}
