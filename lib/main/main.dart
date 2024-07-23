import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thuctap_bai1/main/student_details.dart';
import '../controller/all_controller_binding.dart';
import 'home_page.dart';

// main
void main() {
  runApp(
    GetMaterialApp(
      home: HomePage(),
      // initialBinding: AllControllerBinding(),
    ),
  );
}

