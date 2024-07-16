import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/utilities/app_colors.dart';

class ReletedItemTile extends ConsumerWidget {
  const ReletedItemTile({
    required this.model,
    this.backColor = AppColors.kButtonGray,
    this.tileHeight = 70,
    this.tilewidth = 70,
    super.key,
  });

  final ProductModel model;
  final Color backColor;
  final double tileHeight;
  final double tilewidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        ref.read(productRiverPod).setProductModel(model);
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: AnimatedContainer(
          curve: Curves.linearToEaseOut,
          duration: const Duration(milliseconds: 500),
          padding: const EdgeInsets.all(5),
          width: tilewidth,
          height: tileHeight,
          decoration: BoxDecoration(
              border: Border.all(
                  style: BorderStyle.solid,
                  color: AppColors.kLiteBlack.withOpacity(0.4),
                  width: 0.8),
              borderRadius: BorderRadius.circular(16),
              color: backColor),
          child: Transform.rotate(
            angle: 50.0,
            child: Image.network(
              model.img,
            ),
          ),
        ),
      ),
    );
  }
}
