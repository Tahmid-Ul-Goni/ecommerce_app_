import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void ToastWidget(String msg, Color backgroundColor) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: backgroundColor,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_LONG,
  );
}
