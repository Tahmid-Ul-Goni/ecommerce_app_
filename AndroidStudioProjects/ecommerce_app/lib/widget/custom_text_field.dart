import 'dart:ffi';

import 'package:ecommerce_app/const/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customFormField(
  keyboardtype,
  controller,
  context,
  hinttext,
  validator, {
  bool obscureText = false,
  prefixIcon,
  readOnly = false,
       Function(String)? onTap,onChanged
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: TextFormField(
      keyboardType: keyboardtype,
      readOnly: readOnly,
      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
      controller: controller,
      obscureText: obscureText,
      textInputAction: TextInputAction.next,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 10),
          child: Container(
            width: 40,
            decoration: BoxDecoration(
              color: Color(0xFFFDF2EE),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(prefixIcon, color: AppColors.mandarinColor, size: 20),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8.r),
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hinttext,
        hintStyle: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400),
      ),
    ),
  );
}
