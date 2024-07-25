import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thuctap_bai1/controller/student_controller.dart';
import 'add_student.dart';
import 'home_page_body.dart';

// Home Page
class HomePage extends StatelessWidget {

  // Trang
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Student list", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),),
          backgroundColor: Colors.white,
        ),
        body: HomePageBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/add_student');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
