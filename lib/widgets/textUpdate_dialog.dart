import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

NDialog TextUpadateDialog(BuildContext context) {
  return NDialog(
    dialogStyle: DialogStyle(titleDivider: true),
    title: Text("NDialog"),
    content: Text("This is NDialog's content"),
    actions: <Widget>[
      TextButton(child: Text("OK"), onPressed: () => Navigator.pop(context)),
    ],
  );
}
