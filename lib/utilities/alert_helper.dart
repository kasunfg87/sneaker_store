import 'package:animate_do/animate_do.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/screens/drawer_screen/drawer_screen.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_button.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';

class AlertHelper {
  static Future<dynamic> showAlert(BuildContext context, DialogType dialogType,
      String title, String description) async {
    return AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.bottomSlide,
      title: title,
      desc: description,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }

  static void showSanckBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    AnimatedSnackBar.material(
      msg,
      type: type,
      duration: const Duration(seconds: 2),
    ).show(context);
  }

  static Future openDialog(
          BuildContext context, OrderModel orderModel, WidgetRef ref) =>
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => ZoomIn(
          child: AlertDialog(
            content: SizedBox(
              height: SizeConfig.h(context) * 0.3,
              width: SizeConfig.w(context) - 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.kLiteBlue.withOpacity(0.1)),
                      child: Image.asset(AssetConstants.celebrationImage)),
                  const SizedBox(
                    height: 24,
                  ),
                  const CustomTextRaleway(
                    text: 'Your Payment Is \n Successful',
                    textAlign: TextAlign.center,
                    fontSize: 20,
                  )
                ],
              ),
            ),
            actions: [
              CustomButton(
                  buttonText: 'Back To Shopping',
                  onTap: () {
                    //---- Save orders to firestore DB
                    ref.read(orderRiverPod).saveOrderData(orderModel);

                    //---- Clear cart after save orders
                    ref.read(cartRiverPod).cartItems.clear();
                    //---- Fetch orders
                    ref
                        .read(orderRiverPod)
                        .fetchOrders(FirebaseAuth.instance.currentUser!.uid);

                    Navigator.pushNamed(context, DrawerScreen.routeName);
                  })
            ],
          ),
        ),
      );
}
