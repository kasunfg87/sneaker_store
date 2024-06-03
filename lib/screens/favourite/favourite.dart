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
      body: Container(
        width: SizeConfig.w(context),
        height: SizeConfig.h(context),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            ScreenHeader(
              title: 'Favourite',
              iconImage: AssetConstants.heartEmpty,
              onTapLeft: () {},
              onTapRight: () {},
            ),
            SizedBox(
                width: SizeConfig.w(context),
                height: SizeConfig.h(context) * 0.90,
                child: ref.watch(productRiverPod).isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount:
                            ref.watch(productRiverPod).favouriteProduct.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 9,
                                crossAxisSpacing: 19,
                                childAspectRatio: 0.70),
                        itemBuilder: (context, index) {
                          return ProductTile(
                              model: ref
                                  .watch(productRiverPod)
                                  .favouriteProduct[index]);
                        }))
          ],
        )),
      ),
    );
  }
}
