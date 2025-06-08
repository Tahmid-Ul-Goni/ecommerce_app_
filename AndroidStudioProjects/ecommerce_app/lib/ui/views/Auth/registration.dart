import 'package:ecommerce_app/bussiness_logic/controllers/auth_controller.dart';
import 'package:ecommerce_app/widget/custom_ToastMsg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../const/app_color.dart';
import '../../../widget/custom_buttom.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/custom_text_field.dart';
import '../../responsive/size_config.dart';
import '../../route/route.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    RxBool value = false.obs;
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
                      "Sing Up",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20),
                    customFormField(
                      TextInputType.text,
                      nameController,
                      context,
                      'Write your name',
                      (val) {
                        if (val.isEmpty) {
                          return 'this field can\'t empty ';
                        }
                      },
                      prefixIcon: Icons.person_2_outlined,
                      obscureText: true,
                    ),
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
                    customFormField(
                      TextInputType.text,
                      passwordController,
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
                      obscureText: false,
                    ),
                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: value.value,
                            checkColor: AppColors.mandarinColor,
                            onChanged: (val) {
                              value.value = val!;
                            },
                          ),
                        ),
                        CustomText(
                          firstText: 'I accept all the',
                          secondText: 'Terms & Condition',
                          Page: terms,
                        ),
                      ],
                    ),

                    SizedBox(height: 30),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: customButton('Sign Up', () async {
                        if (formKey.currentState!.validate() &&
                            value.value == true) {
                          Get.find<AuthController>().signUp(
                            nameController.text,
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            context,
                          );
                          ToastWidget("SingUp Successful", Colors.green);
                        } else {
                          ToastWidget("Sing Up Failed", Colors.red);
                        }
                        ;
                      }),
                    ),
                    SizedBox(height: 70),
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
                    CustomText(
                      firstText: 'You have an account already?',
                      secondText: 'log in',
                      Page: 'login',
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
