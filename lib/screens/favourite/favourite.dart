import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/product_tile.dart';
import 'package:sneaker_store/widgets/screen_header.dart';

class Favourite extends ConsumerStatefulWidget {
  static String routeName = "/favourite";

  const Favourite({super.key});

  @override
  ConsumerState<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends ConsumerState<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kButtonGray,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ScreenHeader(
                title: 'Favourite',
                iconImage: AssetConstants.heartEmpty,
                onTapLeft: () {},
                onTapRight: () {},
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: SizeConfig.w(context),
                height: SizeConfig.h(context) * 0.77,
                child: ref.watch(productRiverPod).isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount:
                            ref.watch(productRiverPod).favouriteProduct.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 18,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          return ProductTile(
                            model: ref
                                .watch(productRiverPod)
                                .favouriteProduct[index],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
