import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'package:sneaker_store/provider/favourite_provider.dart';
import 'package:sneaker_store/provider/product_provider.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/product_tile.dart';
import 'package:sneaker_store/widgets/screen_header.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  void initState() {
    super.initState();

    Provider.of<FavouriteProvider>(context, listen: false)
        .fetchFavouriteProducts();
  }

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
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: SizeConfig.w(context),
              height: SizeConfig.h(context) * 0.76,
              child:
                  Consumer<ProductProvider>(builder: (context, value, child) {
                if (value.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: value.favouriteProduct.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 9,
                              crossAxisSpacing: 19,
                              childAspectRatio: 0.70),
                      itemBuilder: (context, index) {
                        return ProductTile(
                            model: value.favouriteProduct[index]);
                      });
                }
              }),
            )
          ],
        )),
      ),
    );
  }
}
