import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thuctap_bai1/home/add_student.dart';
import 'package:thuctap_bai1/home/student_details.dart';
import 'controller/all_controller_binding.dart';
import 'home/home_page.dart';

// main
void main() {
  runApp(
    GetMaterialApp(
      home: HomePage(),
      getPages: [
        GetPage(name: '/add_student', page: ()=> AddStudent()),
      ],
    ),
  );
}
