import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sneaker_store/screens/walk_through/walk_through.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // ------ to remove top icon bar from splash screen

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    // ------ to delay in splach screen and nevigate to walkthrough

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WalkThrough()),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kLiteBlue,
      body: ZoomIn(
        duration: const Duration(seconds: 1),
        child: const Center(
          child: Image(
            image: AssetImage(AssetConstants.nikeLogo),
          ),
        ),
      ),
    );
  }
}
