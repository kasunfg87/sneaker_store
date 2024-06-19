// lib/screens/home/home.dart
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/screens/dashboard/dashboard.dart';
import 'package:sneaker_store/screens/favourite/favourite.dart';
import 'package:sneaker_store/screens/my_cart/my_cart.dart';
import 'package:sneaker_store/screens/orders/orders.dart';
import 'package:sneaker_store/screens/profile/profile.dart';
import 'package:sneaker_store/utilities/alert_helper.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/bnb_custom_point.dart';
import 'package:sneaker_store/utilities/navigation_function.dart';
import 'package:sneaker_store/utilities/size_config.dart';

class Home extends ConsumerStatefulWidget {
  static String routeName = "/home";
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int currentIndex = 0;

  void setBottomBarIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> screens = [
    const Dashboard(),
    const Favourite(),
    const Orders(),
    const Profile(),
  ];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SizedBox(
        width: SizeConfig.w(context),
        height: SizeConfig.h(context),
        child: Scaffold(
          backgroundColor: AppColors.kButtonGray,
          body: screens[currentIndex],
          bottomNavigationBar: buildBottomNavigationBar(context),
        ),
      ),
    );
  }

  Widget buildBottomNavigationBar(BuildContext context) {
    return SizedBox(
      width: SizeConfig.w(context),
      height: 80,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(SizeConfig.w(context), 80),
            painter: BNBCustomPainter(),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: AppColors.kLiteBlue,
              elevation: 2,
              child: SvgPicture.asset(AssetConstants.bagLarge),
              onPressed: () {
                final cartItems = ref.read(cartRiverPod).cartItems;
                if (cartItems.isNotEmpty) {
                  CustomNavigator.navigateTo(context, const MyCart());
                } else {
                  AlertHelper.showSanckBar(
                    context,
                    'Your Cart Is Currently Empty!',
                    AnimatedSnackBarType.info,
                  );
                }
              },
            ),
          ),
          buildIconButtons(context),
        ],
      ),
    );
  }

  Widget buildIconButtons(BuildContext context) {
    return SizedBox(
      width: SizeConfig.w(context),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildIconButton(
            iconPath: AssetConstants.home,
            index: 0,
          ),
          buildIconButton(
            iconPath: AssetConstants.heartLarge,
            index: 1,
            iconHeight: 29,
          ),
          const SizedBox(width: 20), // Spacer for the FAB
          buildIconButton(
            iconPath: AssetConstants.order,
            index: 2,
            iconHeight: 27,
          ),
          buildIconButton(
            iconPath: AssetConstants.profile,
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget buildIconButton({
    required String iconPath,
    required int index,
    double iconHeight = 24,
  }) {
    return IconButton(
      icon: SvgPicture.asset(
        iconPath,
        height: iconHeight,
        // ignore: deprecated_member_use
        color: currentIndex == index
            ? AppColors.kLiteBlue
            : AppColors.kLiteBlack.withOpacity(0.5),
      ),
      onPressed: () {
        setBottomBarIndex(index);
      },
      splashColor: Colors.white,
    );
  }
}
