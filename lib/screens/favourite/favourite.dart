import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/favourite_tile.dart';
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
              const SizedBox(height: 20),
              SizedBox(
                height: SizeConfig.h(context) * 0.77,
                width: SizeConfig.w(context),
                child: ref.watch(productRiverPod).favouriteProduct.isNotEmpty
                    ? ListView.builder(
                        itemCount:
                            ref.watch(productRiverPod).favouriteProduct.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: FavouriteTile(
                                model: ref
                                    .watch(productRiverPod)
                                    .favouriteProduct[index]),
                          );
                        },
                      )
                    : const Center(
                        child: CustomTextPopins(text: 'No Favourite Item yet')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
