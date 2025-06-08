import 'package:ecommerce_app/model/user_profile.dart';
import 'package:ecommerce_app/services/firestore_db.dart';
import 'package:ecommerce_app/widget/custom_buttom.dart';
import 'package:ecommerce_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _uidController = TextEditingController();

  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreDB().getUserProfile(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            UserProfile userProfile = snapshot.data as UserProfile;
            _emailController.text = userProfile.email;
            _nameController.text = userProfile.name;
            _uidController.text = userProfile.uid;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 100, right: 50, left: 50),
                child: Column(
                  children: [
                    customFormField(
                      TextInputType.emailAddress,
                      _emailController,
                      context,
                      'email',
                      (val) {},
                      prefixIcon: Icons.email_outlined,
                      readOnly: true,
                    ),
                    customFormField(
                      TextInputType.text,
                      _nameController,
                      context,
                      'name',
                      (val) {},
                      prefixIcon: Icons.person,
                    ),
                    customFormField(
                      TextInputType.text,
                      _uidController,
                      context,
                      'uid',
                      (val) {},
                      prefixIcon: Icons.verified_outlined,
                      readOnly: true,
                    ),

                    customButton('Update Profile', () {
                      final updatedata = UserProfile(
                        name: _nameController.text,
                        email: _emailController.text,
                        uid: _uidController.text,
                      );
                      FirestoreDB().userProfileUpdate(updatedata);
                    }),
                  ],
                ),
              ),
            );
          }
        }
        return Center(child: Text('Something is wrong!'));
      },
    );
  }
}
