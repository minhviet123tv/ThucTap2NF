import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thuctap_bai1/controller/student_controller.dart';

import '../widget/text_input_widget.dart';
import '../model/student.dart';

class StudentDetails extends StatefulWidget {
  final int indexStudent;

  StudentDetails({super.key, required this.indexStudent});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  //A. Dữ liệu
  StudentController studentController = Get.find<StudentController>();

  // Text controller
  TextEditingController textName = TextEditingController();
  TextEditingController textAge = TextEditingController();
  TextEditingController textJob = TextEditingController();
  TextEditingController textLinkImage = TextEditingController();

  // error input
  late bool errorName;
  late bool errorAge;
  late bool errorJob;
  late bool errorLinkImage;

  @override
  void initState() {
    super.initState();
    _initTextField(); // Gán giá trị ban đầu cho TextField
    _initErrorTextField(); // Giá trị ban đầu của error các TextField
  }

  // Gán giá trị ban đầu cho TextField
  void _initTextField() {
    textName.text = studentController.listStudent[widget.indexStudent].name;
    textAge.text = '${studentController.listStudent[widget.indexStudent].age}';
    textJob.text = studentController.listStudent[widget.indexStudent].job;
    textLinkImage.text = studentController.listStudent[widget.indexStudent].linkImage;
  }

  // Giá trị ban đầu của error các TextField
  void _initErrorTextField() {
    errorName = false;
    errorAge = false;
    errorJob = false;
    errorLinkImage = false;
  }

  //D. Trang
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${studentController.listStudent[widget.indexStudent].name} Details", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<StudentController>(
            builder: (context1) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //1. Ảnh
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        studentController.listStudent[widget.indexStudent].linkImage,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //2. Thông tin tên, tuổi, nghề nghiệp
                    // if (studentController.showUpdate.value == false)
                    //   Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         studentController.listStudent[widget.indexStudent].name,
                    //         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    //         textAlign: TextAlign.start,
                    //       ),
                    //       Text(
                    //         'Age: ${studentController.listStudent[widget.indexStudent].age}',
                    //         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    //         textAlign: TextAlign.start,
                    //       ),
                    //       Text(
                    //         'Job: ${studentController.listStudent[widget.indexStudent].job}',
                    //         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    //         textAlign: TextAlign.start,
                    //       ),
                    //     ],
                    //   ),
                    // const SizedBox(
                    //   height: 10,
                    // ),

                    //3. Thay đổi thông tin (khi show)
                    // if (studentController.showUpdate.value == true)
                    Column(
                      children: [
                        TextInput(
                          textControl: textName,
                          maxLength: null,
                          keyboardType: TextInputType.name,
                          hintText: 'Name',
                          prefixIcon: const Icon(Icons.account_circle_outlined),
                          obscureText: false,
                          enable: studentController.showUpdate.value,
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
                          enable: studentController.showUpdate.value,
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
                          enable: studentController.showUpdate.value,
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
                          enable: studentController.showUpdate.value,
                          error: errorLinkImage,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),

                    //4. Update dữ liệu hoặc back
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //4.1 Update đối tượng Sinh Viên
                        ElevatedButton(
                          onPressed: () {
                            updateStudent();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          child: Text(
                            studentController.showUpdate.value ? 'Update' : "Edit",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),

                        //4.2. Trả về màn hình trước
                        ElevatedButton(
                          onPressed: () {
                            if (studentController.showUpdate.value) {
                              _initTextField(); // Đặt lại giá trị như ban đầu của Student
                              _initErrorTextField();
                              studentController.changeShowUpdate();
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          ),
                          child: Text(
                            studentController.showUpdate.value ? "Cancel" : 'Close',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // update Student
  void updateStudent() {
    if (studentController.showUpdate.value == true) {
      // Kiểm tra điều kiện: Phải có dữ liệu
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

        Get.snackbar(
          "Please type:",
          notifyString,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
        );

        studentController.update();
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

      // Lấy dữ liệu từ TextField -> Tạo đối tượng Student
      String name = textName.text.toString().trim();
      int age = int.parse(textAge.text.toString().trim());
      String job = textJob.text.toString().trim();
      String linkImage = textLinkImage.text.toString().trim();
      Student student = Student(name, age, job, linkImage);

      // Kiểm tra sự tồn tại so với các index khác
      if (studentController.checkStudent(widget.indexStudent, student).value) {
        Get.snackbar(
          "Thông báo",
          "Đã tồn tại: ${textName.text.toString().trim()} - ${textJob.text.toString().trim()}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
        );
      } else {
        // Update nếu không trùng
        studentController.updateStudent(widget.indexStudent, student);
        studentController.changeShowUpdate(); // Cập nhật sang nút edit
        setState(() {});
      }

    } else {
      studentController.changeShowUpdate(); // Cập nhật sang nút edit
    }
  }
}
