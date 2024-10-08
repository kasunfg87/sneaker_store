// lib/screens/menu/menu.dart
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store/controller/auth_controller.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/screens/my_cart/my_cart.dart';
import 'package:sneaker_store/screens/profile/profile.dart';
import 'package:sneaker_store/screens/sign_in/sign_in.dart';
import 'package:sneaker_store/utilities/alert_helper.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/navigation_function.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:sneaker_store/widgets/menu_tabs.dart';
import 'package:styled_divider/styled_divider.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  int _selectedIndex = -1;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kButtonGray,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        height: SizeConfig.h(context),
        width: SizeConfig.w(context),
        decoration: BoxDecoration(color: AppColors.kLiteBlue.withOpacity(0.7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 65,
              backgroundImage: NetworkImage(
                  ref.watch(userRiverPod).userModel!.img.toString()),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextRaleway(
              text: ref.watch(userRiverPod).userModel!.fullName,
              fontSize: 20,
              fontColor: AppColors.kButtonGray,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(
              height: 50,
            ),
            MenuTabs(
              buttonText: 'Profile',
              iconImage: AssetConstants.profile,
              isSelected: _selectedIndex == 0,
              ontap: () {
                _onTabSelected(0);
                CustomNavigator.navigateTo(context, const Profile());
              },
            ),
            const SizedBox(
              height: 32,
            ),
            MenuTabs(
              buttonText: 'My Cart',
              iconImage: AssetConstants.bagLarge,
              isSelected: _selectedIndex == 1,
              ontap: () {
                _onTabSelected(1);
                ref.read(cartRiverPod).cartItems.isNotEmpty
                    ? CustomNavigator.navigateTo(context, const MyCart())
                    : AlertHelper.showSanckBar(
                        context,
                        'Your Cart Is Currently Empty!',
                        AnimatedSnackBarType.success);
              },
            ),
            const SizedBox(
              height: 32,
            ),
            MenuTabs(
              buttonText: 'Favourite',
              iconImage: AssetConstants.heartLarge,
              isSelected: _selectedIndex == 2,
              ontap: () {
                _onTabSelected(2);
              },
            ),
            const SizedBox(
              height: 32,
            ),
            MenuTabs(
              buttonText: 'Orders',
              iconImage: AssetConstants.order,
              isSelected: _selectedIndex == 3,
              ontap: () {
                _onTabSelected(3);
              },
            ),
            const SizedBox(
              height: 32,
            ),
            MenuTabs(
              buttonText: 'Notifications',
              iconImage: AssetConstants.bellIcon,
              isSelected: _selectedIndex == 4,
              ontap: () {
                _onTabSelected(4);
              },
            ),
            const SizedBox(
              height: 32,
            ),
            MenuTabs(
              buttonText: 'Settings',
              iconImage: AssetConstants.settingIcon,
              isSelected: _selectedIndex == 5,
              ontap: () {
                _onTabSelected(5);
              },
            ),
            const SizedBox(
              height: 32,
            ),
            const StyledDivider(
              color: AppColors.kButtonGray,
              height: 50,
              thickness: 2,
              lineStyle: DividerLineStyle.solid,
              indent: 0,
              endIndent: 0,
            ),
            const SizedBox(
              height: 20,
            ),
            MenuTabs(
              buttonText: 'Sign Out',
              iconImage: AssetConstants.signOutIcon,
              isSelected: _selectedIndex == 6,
              ontap: () {
                _onTabSelected(6);
                AuthController().logOut(context).whenComplete(
                    () => CustomNavigator.navigateTo(context, const SignIn()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
