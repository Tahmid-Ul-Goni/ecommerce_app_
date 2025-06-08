import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../const/app_color.dart';

class CustomText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final String Page;
  const CustomText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.Page,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style: TextStyle(color: AppColors.grayColor),
          ),
          TextSpan(
            recognizer:
                TapGestureRecognizer()..onTap = () => Get.toNamed(Page),
            text: secondText,
            style: TextStyle(color:Colors.black, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
