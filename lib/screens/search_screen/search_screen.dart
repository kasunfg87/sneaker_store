import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_search.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/screen_header.dart';
import 'package:sneaker_store/widgets/search_result_tile.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kButtonGray,
      body: SafeArea(
        child: Container(
            width: SizeConfig.w(context),
            height: SizeConfig.h(context),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ScreenHeader(
                      rightIconButton: true,
                      title: 'Search Products',
                      iconImage: AssetConstants.searchIcon,
                      onTapLeft: () => Navigator.pop(context),
                      onTapRight: () {}),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomSearch(
                    focus: true,
                    hintText: 'Looking for shoes',
                    controller: ref.read(productRiverPod).searchController,
                    txtOnChange: (text) {
                      ref.watch(productRiverPod).updateSearchResults(text);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: SizeConfig.w(context),
                    height: SizeConfig.h(context) * 0.80,
                    child: ref.read(productRiverPod).searchProduct.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                ref.read(productRiverPod).searchProduct.length,
                            itemBuilder: (context, index) {
                              return SearchResultTile(
                                  model: ref
                                      .read(productRiverPod)
                                      .searchProduct[index]);
                            })
                        : const Center(
                            child: CustomTextPopins(
                                text: "Sorry, we couldn't find any results")),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
