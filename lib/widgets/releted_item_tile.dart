import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/provider/product_provider.dart';
import 'package:sneaker_store/utilities/app_colors.dart';

class ReletedItemTile extends StatelessWidget {
  const ReletedItemTile({
    required this.model,
    this.backColor = AppColors.kWhite,
    this.tileHeight = 70,
    this.tilewidth = 70,
    super.key,
  });

  final ProductModel model;
  final Color backColor;
  final double tileHeight;
  final double tilewidth;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, value, child) {
      return InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          value.setProductModel(model);
        },
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Material(
            type: MaterialType.card,
            elevation: 2,
            shadowColor: AppColors.kLiteBlack.withOpacity(0.4),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(5),
              width: tilewidth,
              height: tileHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: backColor),
              child: Transform.rotate(
                angle: 50.0,
                child: Image.network(
                  model.img,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
