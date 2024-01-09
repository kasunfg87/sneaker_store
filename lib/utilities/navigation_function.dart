// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';

class NavigationFunction {
  static void navigateTo(BuildContext, context, Widget, widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}
