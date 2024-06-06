import 'package:flutter/material.dart';
import 'package:sneaker_store/provider/product_provider.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_category_button.dart';

class CategoryList extends StatelessWidget {
  final ProductProvider productProvider;

  const CategoryList({required this.productProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.w(context),
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CustomCategoryButton(
            fontColor: productProvider.selectedIndex == index
                ? AppColors.kWhite
                : AppColors.kBlack,
            buttonColor: productProvider.selectedIndex == index
                ? AppColors.kLiteBlue
                : AppColors.kWhite,
            buttonText: AssetConstants.categoryList[index],
            onTap: () {
              productProvider.setSelectedIndex(index);
              productProvider.filterProdutsWithCategory(
                  AssetConstants.categoryList[index]);
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemCount: AssetConstants.categoryList.length,
      ),
    );
  }
}
