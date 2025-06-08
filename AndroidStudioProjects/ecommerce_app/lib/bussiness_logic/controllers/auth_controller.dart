import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../ui/route/route.dart';
import '../../ui/style/Appstyle.dart';
import '../../widget/custom_ToastMsg.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final box = GetStorage();

  signUp(name, email, password, context) async {
    AppStyles().progressDialog(context);
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user!.uid.isNotEmpty) {
        CollectionReference collectionReference = FirebaseFirestore.instance
            .collection('users');
        collectionReference.doc(email).set({
          'uid': credential.user!.uid,
          'email': email,
          'name': name,
        });

        Map user = {'uid': credential.user!.uid, 'email': email, 'name': name};
        box.write('user', user);
        print(box.read('user'));
        Get.back();
        Get.offAndToNamed(bottomNav);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ToastWidget('SingUp Failed', Colors.red);
        Get.back();
      } else if (e.code == 'email-already-in-use') {
        ToastWidget('SingUp Failed', Colors.red);
        Get.back();
      }
    } catch (e) {
      Get.back();
    }
  }

  login(email, password, context) async {
    AppStyles().progressDialog(context);
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user!.uid.isNotEmpty) {
        FirebaseFirestore.instance.collection('users').doc(email).get().then((
          DocumentSnapshot<Map<String, dynamic>> doc,
        ) {
          var data = doc.data();
          print(data);
          Map user = {
            'uid': data!['uid'],
            'email': data['email'],
            'name': data['name'],
          };
          box.write('user', user);
          Get.back();
          Get.toNamed(bottomNav);
          ToastWidget('Login Successful', Colors.green);
        });
      } else {
        ToastWidget('Login Failed', Colors.red);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ToastWidget('User not found', Colors.red);
      } else if (e.code == 'wrong-password') {
        ToastWidget('Wrong password provided for that user.', Colors.red);
      }
    }
  }

  forgetPassword(email, context) async {
    try {
      AppStyles().progressDialog(context);
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.back();
      ToastWidget('email has been sent to $email', Colors.green);
    } catch (e) {
      Get.back();
      ToastWidget('Something is wrong', Colors.red);
    }
  }

  logOut() {
    _auth.signOut();
  }
}
