import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AlertHelper {
  static Future<dynamic> showAlert(BuildContext context, DialogType dialogType,
      String title, String description) async {
    return AwesomeDialog(
      context: context,
      dialogType: dialogType,
      // ignore: deprecated_member_use
      animType: AnimType.BOTTOMSLIDE,
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
}
