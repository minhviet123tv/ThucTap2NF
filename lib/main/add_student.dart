import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thuctap_bai1/controller/student_controller.dart';
import '../model/student.dart';
import '../widget/text_input_widget.dart';
import 'home_page_body.dart';

class AddStudent extends StatefulWidget {
  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

  //I. Tạo Getx Controller
  final StudentController studentController = Get.find<StudentController>();

  // Tạo controller cho các TextField
  TextEditingController textName = TextEditingController();
  TextEditingController textAge = TextEditingController();
  TextEditingController textJob = TextEditingController();
  TextEditingController textLinkImage = TextEditingController();

  // error input
  bool errorName = false;
  bool errorAge = false;
  bool errorJob = false;
  bool errorLinkImage = false;

  //II. Trang
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add student", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),),
          backgroundColor: Colors.blue[300],
        ),
        body: AddStudentBody(context),
      ),
    );
  }

  //III. Body
  Widget AddStudentBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Type information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 15),

            //1. Điền thông tin
            TextInput(
              textControl: textName,
              maxLength: null,
              keyboardType: TextInputType.name,
              hintText: 'Name',
              prefixIcon: const Icon(Icons.account_circle_outlined),
              obscureText: false,
              enable: true,
              error: errorName,
            ),
            const SizedBox(
              height: 8,
            ),
            TextInput(
              textControl: textAge,
              maxLength: null,
              keyboardType: TextInputType.number,
              hintText: 'Age',
              prefixIcon: const Icon(Icons.calendar_today),
              obscureText: false,
              enable: true,
              error: errorAge,
            ),
            const SizedBox(
              height: 8,
            ),
            TextInput(
              textControl: textJob,
              maxLength: null,
              keyboardType: TextInputType.text,
              hintText: 'Job',
              prefixIcon: const Icon(Icons.settings_sharp),
              obscureText: false,
              enable: true,
              error: errorJob,
            ),
            const SizedBox(
              height: 8,
            ),
            TextInput(
              textControl: textLinkImage,
              maxLength: null,
              keyboardType: TextInputType.text,
              hintText: 'Link Image',
              prefixIcon: const Icon(Icons.image),
              obscureText: false,
              enable: true,
              error: errorLinkImage,
            ),
            const SizedBox(
              height: 10,
            ),

            //2. Nút chọn thêm đối tượng Sinh Viên
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    addStudent(textName, textAge, textJob, textLinkImage, context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),

                //3. Đóng cửa sổ
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  //IV. Add Student
  void addStudent(TextEditingController textName, TextEditingController textAge, TextEditingController textJob,
      TextEditingController textLinkImage, BuildContext context) {

    // Kiểm tra điều kiện phải có dữ liệu
    if (textName.text.isEmpty || textAge.text.isEmpty || textJob.text.isEmpty || textLinkImage.text.isEmpty) {
      String notifyString = "";
      if (textName.text.isEmpty) {
        errorName = true;
        notifyString += "Name. ";
      } else {
        errorName = false;
      }
      if (textAge.text.isEmpty) {
        errorAge = true;
        notifyString += "Age. ";
      } else {
        errorAge = false;
      }
      if (textJob.text.isEmpty) {
        errorJob = true;
        notifyString += "Job. ";
      } else {
        errorJob = false;
      }
      if (textLinkImage.text.isEmpty) {
        errorLinkImage = true;
        notifyString += "Link Image";
      } else {
        errorLinkImage = false;
      }

      // Hiện thông báo
      Get.snackbar(
        "Please type:",
        notifyString,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
      );

      studentController.update();
      setState(() {}); // Cập nhật giao diện trong trang
      return;
    }

    // Kiểm tra dữ liệu của Age
    if (int.parse(textAge.text) <= 0) {
      errorAge = true;
      Get.snackbar(
        "Notify",
        "Age can not <= 0",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
      );
      studentController.update();
      return;
    }

    // Add Student
    studentController.listStudent.forEach((element) {
      // Kiểm tra điều kiện của dữ liệu: Không trùng tên (name) và nghề nghiệp (job)
      if (element.name.toLowerCase() == textName.text.toString().trim().toLowerCase() &&
          element.job.toLowerCase() == textJob.text.toString().trim().toLowerCase()) {
        Get.snackbar(
          "Notify:",
          "Already exists: ${textName.text.toString().trim()} - ${textJob.text.toString().trim()}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
        );
      } else {
        // Thêm dữ liệu mới
        String name = textName.text.toString().trim();
        int age = int.parse(textAge.text.toString().trim());
        String job = textJob.text.toString().trim();
        String linkImage = textLinkImage.text.toString().trim();

        studentController.listStudent.add(Student(name, age, job, linkImage));
        studentController.update(); // Cập nhật dữ liệu cho list

        // Đóng cửa sổ
        Navigator.pop(context);
      }
    });
  }
}
