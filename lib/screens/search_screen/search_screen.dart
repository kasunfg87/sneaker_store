import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/provider/product_provider.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_search.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/screen_header.dart';
import 'package:sneaker_store/widgets/search_result_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kButtonGray,
      body: Container(
          width: SizeConfig.w(context),
          height: SizeConfig.h(context),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Consumer<ProductProvider>(builder: (context, value, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  ScreenHeader(
                      rightButton: false,
                      title: 'Search Products',
                      iconImage: AssetConstants.bag,
                      onTapLeft: () => Navigator.pop(context),
                      onTapRight: () {}),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomSearch(
                    focus: true,
                    hintText: 'Looking for shoes',
                    controller: value.searchController,
                    txtOnChange: (text) {
                      if (text.isEmpty) {
                        value.searchProduct.clear();
                      } else {
                        value.updateSearchResults(text);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: SizeConfig.w(context),
                    height: SizeConfig.h(context) * 0.69,
                    child: value.searchProduct.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: value.searchProduct.length,
                            itemBuilder: (context, index) {
                              return SearchResultTile(
                                  model: value.searchProduct[index]);
                            })
                        : const Center(
                            child: CustomTextPopins(
                                text: "Sorry, we couldn't find any results")),
                  )
                ],
              ),
            );
          })),
    );
  }
}
