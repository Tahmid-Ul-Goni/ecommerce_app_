import 'package:ecommerce_app/model/intro.dart';
import 'package:ecommerce_app/ui/route/route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';


class onBoarding extends StatelessWidget {
  const onBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: IntroductionScreen(
          pages:
              introData.map((e) {
                return PageViewModel(
                  titleWidget: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      e.title,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  bodyWidget: Column(
                    children: [
                      Text(
                        e.description,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  image: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Image.asset(e.image, height: 230.h),
                    ],
                  ),
                );
              }).toList(),

          showDoneButton: true,
          done: Text("Done"),
          onDone: () => Get.toNamed(login),
          showNextButton: true,
          next: const Text("Next"),
        ),
      ),
    );
  }
}
