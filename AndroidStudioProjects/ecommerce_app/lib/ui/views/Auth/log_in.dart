import 'package:ecommerce_app/bussiness_logic/controllers/auth_controller.dart';
import 'package:ecommerce_app/const/app_color.dart';
import 'package:ecommerce_app/ui/responsive/size_config.dart';
import 'package:ecommerce_app/widget/custom_ToastMsg.dart';
import 'package:ecommerce_app/widget/custom_buttom.dart';
import 'package:ecommerce_app/widget/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../route/route.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: SizeConfig.screenHeight,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    SizedBox(height: 60),
                    Image.asset('assets/icons/logo.png', width: 40.w),
                    SizedBox(height: 10),
                    Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20),
                    customFormField(
                      TextInputType.emailAddress,
                      _emailController,
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
                    customFormField(
                      TextInputType.text,
                      _passwordTextController,
                      context,
                      'Password',
                      (val) {
                        if (val.isEmpty) {
                          return 'this field can\'t empty ';
                        } else if (val.length < 6) {
                          return 'password must be at least 6 characters';
                        }
                      },
                      prefixIcon: Icons.remove_red_eye_outlined,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => Get.toNamed(forgetPassword),
                        child: Text(
                          'forget password?',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: customButton('Log in', () {
                        if (_formKey.currentState!.validate()) {
                          Get.find<AuthController>().login(
                            _emailController.text.trim(),
                            _passwordTextController.text.trim(),
                            context,
                          );
                        } else {
                          ToastWidget("Log in Failed", Colors.red);
                        }
                      }),
                    ),
                    SizedBox(height: 100),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(thickness: 1.0, color: Colors.black),
                        ),
                        Text('    Or    '),
                        Expanded(
                          child: Divider(thickness: 1, color: Colors.black),
                        ),
                      ],
                    ),

                    SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {},
                          child: Ink(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.grayColor.withOpacity(0.5),
                                  blurRadius: 7,
                                  spreadRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/icons/facebook.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 50),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {},
                          child: Ink(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.grayColor.withOpacity(0.5),
                                  blurRadius: 7,
                                  spreadRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset('assets/icons/search.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Don\'t have an account?',
                            style: TextStyle(color: AppColors.grayColor),
                          ),
                          TextSpan(
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () => Get.toNamed(registration),
                            text: 'Sing Up',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
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
