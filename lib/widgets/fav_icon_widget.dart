import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/widgets/favourite_icon.dart';
import '../../../models/objects.dart';

class FavouriteIconWidget extends ConsumerWidget {
  const FavouriteIconWidget({required this.model, super.key});
  final ProductModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue =
        ref.watch(favouriteProductStreamProvider(model.productId));

    return asyncValue.when(
      data: (snapshot) {
        final isFavourite = snapshot.docs.isNotEmpty;
        return FavouiriteIcon(
          isfavourite: isFavourite,
          model: model,
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => const Text('Error loading data'),
    );
  }
}
