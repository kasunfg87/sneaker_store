import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_store/controller/product_controller.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/widgets/product_tile.dart';

class FavouriteTileWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const FavouriteTileWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: ProductController().getFavouriteProductWithUID(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final List<FavouriteModel> favourite = snapshot.data!.docs
            .map((doc) =>
                FavouriteModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: favourite.length,
          itemBuilder: (context, index) {
            return StreamBuilder<QuerySnapshot>(
              stream: ProductController()
                  .getProductWithID(favourite[index].productId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final List<ProductModel> products = snapshot.data!.docs
                    .map((doc) => ProductModel.fromJson(
                        doc.data() as Map<String, dynamic>))
                    .toList();

                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: products.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 50,
                  ),
                  itemBuilder: (context, index) {
                    return ProductTile(model: products[index]);
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
