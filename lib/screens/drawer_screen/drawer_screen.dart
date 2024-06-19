// lib/screens/drawer_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/screens/home/home.dart';
import 'package:sneaker_store/screens/menu/menu.dart';
import 'package:sneaker_store/utilities/size_config.dart';

class DrawerScreen extends ConsumerWidget {
  static String routeName = "/drawerscreen";
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zoomDrawerController = ref.read(zoomDrawerControllerProvider);
    return ZoomDrawer(
      controller: zoomDrawerController,
      menuScreen: const MenuScreen(),
      mainScreen: const Home(),
      showShadow: true,
      borderRadius: 24.0,
      angle: -6.0,
      mainScreenScale: 0.2,
      menuScreenWidth: SizeConfig.w(context),
    );
  }
}
