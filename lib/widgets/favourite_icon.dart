import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/firebase_helper.dart';

class FavouiriteIcon extends ConsumerWidget {
  const FavouiriteIcon({
    this.isfavourite = false,
    required this.model,
    super.key,
  });

  final bool isfavourite;
  final ProductModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 2,
      shadowColor: AppColors.kBlack.withOpacity(0.4),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        splashFactory: InkSparkle.splashFactory,
        splashColor: AppColors.kLiteBlue,
        onTap: () {
          ref.read(favouriteRiverPod).initAddToFav(
              FavouriteModel(
                  category: model.category,
                  productId: model.productId,
                  uid: FirebaseHelper.auth.currentUser!.uid),
              context,
              ref);
        },
        child: Container(
            height: 48,
            width: 48,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: AppColors.kDarkGray.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: isfavourite
                ? SvgPicture.asset(
                    AssetConstants.heartFill,
                    // ignore: deprecated_member_use
                    color: const Color.fromARGB(255, 219, 52, 40),
                    height: 40,
                  )
                : SvgPicture.asset(
                    AssetConstants.heartLarge,
                    // ignore: deprecated_member_use
                    color: AppColors.kBlack,
                  )),
      ),
    );
  }
}
