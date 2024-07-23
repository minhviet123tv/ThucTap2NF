import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thuctap_bai1/controller/student_controller.dart';
import 'package:thuctap_bai1/main/student_details.dart';

// HomePageBody
class HomePageBody extends StatelessWidget {

  final StudentController studentController = Get.find<StudentController>(); // Tìm Getx Controller

  //I. Trang ListView
  @override
  Widget build(BuildContext context) {

    return GetBuilder<StudentController>(
      builder: (context) {

        // Sắp xếp dữ liệu
        studentController.listStudent.sort((a, b) => a.age.compareTo(b.age));
        // ListView danh sách Sinh Viên
        return ListView.builder(
          itemCount: studentController.listStudent.length,
          itemBuilder: (context, index) {
            return itemStudent(index);
          },
        );
      },
    );
  }

  //II. Item Student của ListView
  Widget itemStudent(int index) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          shape: BoxShape.rectangle, // Có thể tạo hình chữ nhật, tròn cho container (Hình tròn thì không dùng borderRadius)
          borderRadius: const BorderRadius.all(Radius.circular(16)), //Bo góc
          // border: Border.all(width: 3, color: Colors.black), //Viền bao ngoài
          boxShadow: const [BoxShadow(
            color: Colors.black26,
            spreadRadius: 1, //chiều rộng của bóng
            blurRadius: 3, // Độ nhoè, lan rộng của bóng
            offset: Offset(1, 2), //Độ nghiêng bóng trục x và y
          )],
        ),
      child: InkWell(
        onTap: () {
          Get.to(() => StudentDetails(indexStudent: index)); // Sự kiện khi click item -> Xem details
        },
        child: Row(
          children: [

            //1. Ảnh
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                studentController.listStudent[index].linkImage,
                fit: BoxFit.cover,
                width: 160,
                height: 220,
              ),
            ),

            //2. Thông tin tên, tuổi, nghề nghiệp
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Container(
                  height: 220,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white), //Viền bao ngoài
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        studentController.listStudent[index].name,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        'Age: ${studentController.listStudent[index].age}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        'Job: ${studentController.listStudent[index].job}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}