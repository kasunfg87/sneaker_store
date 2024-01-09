// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sneaker_store/controller/product_controller.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';

import '../../../models/objects.dart';

class SmallFavouriteIconWidget extends StatefulWidget {
  const SmallFavouriteIconWidget({required this.model, super.key});
  final ProductModel model;

  @override
  State<SmallFavouriteIconWidget> createState() =>
      _SmallFavouriteIconWidgetState();
}

class _SmallFavouriteIconWidgetState extends State<SmallFavouriteIconWidget> {
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
            return Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.kButtonGray,
              ),
              child: SvgPicture.asset(
                AssetConstants.hertfill,
                color: Colors.red,
              ),
            );
          } else {
            return Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.kButtonGray,
              ),
              child: SvgPicture.asset(
                AssetConstants.hertfill,
                color: AppColors.kLiteBlack.withOpacity(0.3),
              ),
            );
          }
        });
  }
}
