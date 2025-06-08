import 'package:ecommerce_app/Cart.dart';
import 'package:ecommerce_app/Profile.dart';
import 'package:ecommerce_app/const/app_color.dart';
import 'package:ecommerce_app/fav.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'Home.dart';

class BottomNav extends StatelessWidget {
  BottomNav({super.key});

  RxInt _currentIndex = 0.obs;
  final _pages = [Home(), Favourite(), Cart(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: SalomonBottomBar(
          selectedItemColor: AppColors.mandarinColor,
          currentIndex: _currentIndex.value,
          onTap: (val){_currentIndex.value=val;},
          items: [
            customBottomBar(Icons.home, 'Home'),
            customBottomBar(Icons.favorite_outline, 'Favourite'),
            customBottomBar(Icons.shopping_bag_outlined, 'Cart'),
            customBottomBar(Icons.person_2_outlined, 'Person'),
          ],
        ),
    body: _pages[_currentIndex.value],  ),
    );
  }
}

SalomonBottomBarItem customBottomBar(icon, title) {
  return SalomonBottomBarItem(icon: Icon(icon), title: Text(title));
}
