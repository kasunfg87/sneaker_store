import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/provider/cart_provider.dart';
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

class Home extends StatefulWidget {
  static String routeName = "/home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    super.initState();
  }

  int currentIndex = 0;

  setBottomBarIndex(index) {
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
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SizedBox(
        width: SizeConfig.w(context),
        height: SizeConfig.h(context),
        child: Scaffold(
          backgroundColor: AppColors.kButtonGray,
          body: screens[currentIndex],
          bottomNavigationBar: SizedBox(
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
                          Provider.of<CartProvider>(context, listen: false)
                                  .cartItems
                                  .isNotEmpty
                              ? NavigationFunction.navigateTo(
                                  BuildContext, context, Widget, const MyCart())
                              : AlertHelper.showSanckBar(
                                  context,
                                  'Your Cart Is Currently Empty!',
                                  AnimatedSnackBarType.info);
                        })),
                SizedBox(
                  width: SizeConfig.w(context),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          AssetConstants.home,
                          // ignore: deprecated_member_use
                          color: currentIndex == 0
                              ? AppColors.kLiteBlue
                              : AppColors.kLiteBlack.withOpacity(0.5),
                        ),
                        onPressed: () {
                          setBottomBarIndex(0);
                        },
                        splashColor: Colors.white,
                      ),
                      IconButton(
                          icon: SvgPicture.asset(
                            height: 29,
                            AssetConstants.heartLarge,
                            // ignore: deprecated_member_use
                            color: currentIndex == 1
                                ? AppColors.kLiteBlue
                                : AppColors.kLiteBlack.withOpacity(0.5),
                          ),
                          onPressed: () {
                            setBottomBarIndex(1);
                          }),
                      Container(
                        width: SizeConfig.w(context) * 0.20,
                      ),
                      IconButton(
                          icon: SvgPicture.asset(
                            AssetConstants.order,
                            height: 27,
                            // ignore: deprecated_member_use
                            color: currentIndex == 2
                                ? AppColors.kLiteBlue
                                : AppColors.kLiteBlack.withOpacity(0.5),
                          ),
                          onPressed: () {
                            setBottomBarIndex(2);
                          }),
                      IconButton(
                          icon: SvgPicture.asset(
                            AssetConstants.profile,
                            // ignore: deprecated_member_use
                            color: currentIndex == 3
                                ? AppColors.kLiteBlue
                                : AppColors.kLiteBlack.withOpacity(0.5),
                          ),
                          onPressed: () {
                            setBottomBarIndex(3);
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
