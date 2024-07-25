import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thuctap_bai1/home/add_student.dart';
import 'controller/all_controller_binding.dart';
import 'home/home_page.dart';

// main
void main() {

  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo đã khởi tạo

  runApp(
    GetMaterialApp(
      home: HomePage(),
      initialBinding: AllGetxControllerBinding(), // Khởi tạo cho các GetxController
      getPages: [
        GetPage(name: '/add_student', page: ()=> AddStudent(), transition: Transition.upToDown),
      ],
    ),
  );
}
