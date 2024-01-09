import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_store/controller/product_controller.dart';
import 'package:sneaker_store/widgets/favourite_icon.dart';

import '../../../models/objects.dart';

class FavouriteIconWidget extends StatefulWidget {
  const FavouriteIconWidget({required this.model, super.key});
  final ProductModel model;

  @override
  State<FavouriteIconWidget> createState() => _FavouriteIconWidgetState();
}

class _FavouriteIconWidgetState extends State<FavouriteIconWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: ProductController()
            .getFavouriteProductStream(widget.model.productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While data is being fetched, show a loading indicator
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            // If there's an error in fetching the data, handle it accordingly
            return const Text('Error loading data');
          }

          // Check if there are any documents in the snapshot
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return FavouiriteIcon(
              isfavourite: true,
              model: widget.model,
            );
          } else {
            return FavouiriteIcon(
              model: widget.model,
            );
          }
        });
  }
}
