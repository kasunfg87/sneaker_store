import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sneaker_store/utilities/size_config.dart';

import '../utilities/app_colors.dart';

class ProductTilePlaceHolder extends StatefulWidget {
  const ProductTilePlaceHolder({super.key});

  @override
  State<ProductTilePlaceHolder> createState() => _ProductTilePlaceHolderState();
}

class _ProductTilePlaceHolderState extends State<ProductTilePlaceHolder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 4.0,
        shadowColor: AppColors.kBlack.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.only(left: 15, top: 15),
          width: SizeConfig.w(context) / 2 - 32,
          decoration: BoxDecoration(
            color: AppColors.kDarkGray,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Shimmer.fromColors(
            baseColor: const Color.fromARGB(192, 224, 223, 223),
            highlightColor: AppColors.kWhite.withOpacity(0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 33,
                  height: 33,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(192, 224, 223, 223),
                      shape: BoxShape.circle),
                ),
                Container(
                  width: 140,
                  height: 90,
                  color: const Color.fromARGB(192, 224, 223, 223),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 90,
                      height: 20,
                      color: const Color.fromARGB(192, 224, 223, 223),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      width: 150,
                      height: 20,
                      color: const Color.fromARGB(192, 224, 223, 223),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60,
                          height: 20,
                          color: const Color.fromARGB(192, 224, 223, 223),
                        ),
                        Container(
                          height: 35,
                          width: 35,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(192, 224, 223, 223),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              )),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
