import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatorController extends GetxController {
  static NavigatorController instance = Get.find();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  Future<dynamic> navigateTo(String routeName) {
    return navigationKey.currentState.pushNamed(routeName);
  }
}
