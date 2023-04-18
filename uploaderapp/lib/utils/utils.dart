import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  String title;
  String message;
  Utils({required this.title, required this.message});

  //Error function
  toastmessage(String title, String message) {
    return Get.snackbar(title, message);
  }
}
