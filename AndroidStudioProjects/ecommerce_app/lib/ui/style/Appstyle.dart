import 'package:flutter/material.dart';

class AppStyles{
  progressDialog(context){
    showDialog(context: context, builder: (_){return
      Dialog(elevation: 0,backgroundColor: Colors.transparent,
      child:Image.asset("assets/files/loading(1).gif"),);
  });}}