import 'package:ecommerce_app/bussiness_logic/controllers/auth_controller.dart';
import 'package:ecommerce_app/widget/custom_ToastMsg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widget/custom_buttom.dart';
import '../../../widget/custom_text_field.dart';
import '../../responsive/size_config.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: SizeConfig.screenHeight,
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    SizedBox(height: 60),
                    Image.asset('assets/icons/logo.png', width: 40.w),
                    SizedBox(height: 10),
                    Text(
                      "Forget Password?",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20),
                    customFormField(
                      TextInputType.emailAddress,
                      emailController,
                      context,
                      'Email',
                      (val) {
                        if (val.isEmpty) {
                          return 'this field can\'t be empty';
                        }
                        if (!val.contains(RegExp(r'@'))) {
                          return 'enter a valid email address';
                        }
                      },
                      prefixIcon: Icons.email_outlined,
                    ),

                    SizedBox(height: 30),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: customButton('Send OTP', () {
                        if (formKey.currentState!.validate()) {
                          Get.find<AuthController>().forgetPassword(
                            emailController,
                            context,
                          );
                        } else {
                          ToastWidget("Try again", Colors.red);
                        }
                        ;
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
