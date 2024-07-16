// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/bnb_custom_point.dart';

class BottomNavBarV2 extends StatefulWidget {
  const BottomNavBarV2({super.key});

  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State();
}

class _BottomNavBarV2State extends State<BottomNavBarV2> {
  int currentIndex = 0;

  void setBottomBarIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            width: size.width,
            height: 80,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(size.width, 80),
                  painter: BNBCustomPainter(),
                ),
                Center(
                  heightFactor: 0.6,
                  child: FloatingActionButton(
                    shape: const CircleBorder(),
                    backgroundColor: AppColors.kLiteBlue,
                    elevation: 2,
                    child: SvgPicture.asset(AssetConstants.bagLarge),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIcon(Icons.home, 0),
                      _buildIcon(Icons.restaurant_menu, 1),
                      SizedBox(width: size.width * 0.20), // Space for FAB
                      _buildIcon(Icons.bookmark, 2),
                      _buildIcon(Icons.notifications, 3),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: currentIndex == index ? Colors.orange : Colors.grey.shade400,
      ),
      onPressed: () {
        setBottomBarIndex(index);
      },
      splashColor: Colors.white,
    );
  }
}
