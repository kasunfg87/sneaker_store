import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import '../../../models/objects.dart';

class SmallFavouriteIconWidget extends ConsumerWidget {
  const SmallFavouriteIconWidget({required this.model, super.key});
  final ProductModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue =
        ref.watch(favouriteProductStreamProvider(model.productId));

    return asyncValue.when(
      data: (snapshot) {
        final isFavourite = snapshot.docs.isNotEmpty;

        return Container(
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.kButtonGray,
          ),
          child: SvgPicture.asset(
            AssetConstants.hertfill,
            // ignore: deprecated_member_use
            color: isFavourite
                ? Colors.red
                : AppColors.kLiteBlack.withOpacity(0.3),
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => const Text('Error loading data'),
    );
  }
}
