import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/screens/details/details.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/navigation_function.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:sneaker_store/widgets/product_tile.dart';
import 'package:sneaker_store/widgets/product_tile_placeholder.dart';

class PopularShoesSection extends ConsumerWidget {
  const PopularShoesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productProvider = ref.watch(productRiverPod);

    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextRaleway(text: 'Popular Shoes', fontSize: 16),
            CustomTextPopins(
                text: 'See All',
                fontColor: AppColors.kLiteBlue,
                fontSize: 13,
                fontWeight: FontWeight.w700),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: SizeConfig.w(context),
          height: SizeConfig.h(context) * 0.28,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (productProvider.allProduct.isNotEmpty) {
                return productProvider.isLoading
                    ? const ProductTilePlaceHolder()
                    : InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          productProvider.setSizeIndex(-1);
                          productProvider.setProductModel(
                            productProvider.filteredProduct.isEmpty
                                ? productProvider.allProduct[index]
                                : productProvider.filteredProduct[index],
                          );
                          CustomNavigator.navigateTo(
                              context,
                              Details(
                                  productModel:
                                      productProvider.filteredProduct.isEmpty
                                          ? productProvider.allProduct[index]
                                          : productProvider
                                              .filteredProduct[index]));
                        },
                        child: ProductTile(
                          model: productProvider.filteredProduct.isEmpty
                              ? productProvider.allProduct[index]
                              : productProvider.filteredProduct[index],
                        ),
                      );
              }
              return null;
            },
            separatorBuilder: (context, index) => const SizedBox(width: 22),
            itemCount: productProvider.filteredProduct.isEmpty
                ? productProvider.allProduct.length
                : productProvider.filteredProduct.length,
          ),
        ),
      ],
    );
  }
}
