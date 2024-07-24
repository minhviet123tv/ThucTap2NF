import 'dart:math';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/student.dart';

//I. GetxController
class StudentController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    listStudent.sort((a, b) => a.age.compareTo(b.age)); // Sắp xếp thứ tự theo tuổi
  }

  //1. List đối tượng Sinh Viên
  RxList<Student> listStudent = <Student>[
    Student("Name 1", 23, "Sale", linkImageRandom[Random().nextInt(linkImageRandom.length)]),
    Student("Name 2", 21, "Media", linkImageRandom[Random().nextInt(linkImageRandom.length)]),
    Student("Name 3", 22, "Flutter developer", linkImageRandom[Random().nextInt(linkImageRandom.length)]),
    Student("Name 4", 25, "Android developer", linkImageRandom[Random().nextInt(linkImageRandom.length)]),
    Student("Name 5", 29, "ISO developer", linkImageRandom[Random().nextInt(linkImageRandom.length)]),
  ].obs;

  //2. Add student: add, sort, update
  void addStudent(Student student){
    listStudent.add(student);
    listStudent.sort((a, b) => a.age.compareTo(b.age));
    update();
  }

  //3. Kiểm tra trùng lặp dữ liệu (khác index đưa vào)
  RxBool checkStudent(int index, Student student) {
    for (int i = 0; i < listStudent.length; i++) {
      if (i != index && listStudent[i].name == student.name && listStudent[i].job == student.job) {
        return true.obs;
      }
    }
    return false.obs; // Giá trị mặc định
  }

  //4. Kiểm tra trùng lặp dữ liệu (toàn bộ list)
  RxBool checkAllStudent(Student student) {
    for (int i = 0; i < listStudent.length; i++) {
      if (listStudent[i].name == student.name && listStudent[i].job == student.job) {
        return true.obs;
      }
    }
    return false.obs; // Giá trị mặc định
  }

  //5. Update thông tin một đối tượng Student tại index
  updateStudent(int index, Student student) {
    listStudent[index].name = student.name;
    listStudent[index].age = student.age;
    listStudent[index].job = student.job;
    listStudent[index].linkImage = student.linkImage;

    update(); // Cập nhật, dùng GetBuidler do Obx không tự cập nhật được
  }

  //6. Sort list
  void sortListStudent(){
    listStudent.sort((a, b) => a.age.compareTo(b.age));
    update();
  }
}

//II. Link ảnh dùng cho GetxController
List<String> linkImageRandom = [
  "https://htmediagroup.vn/wp-content/uploads/2022/04/Anh-CV-chuyen-nghiep-min-1.jpg",
  "https://htmediagroup.vn/wp-content/uploads/2021/07/anh-profile-nam-min.jpg",
  "https://htmediagroup.vn/wp-content/uploads/2022/03/Anh-nghe-thuat-2.jpg",
  "https://chupanhthedep.com/wp-content/uploads/2022/10/chup-anh-profile-ca-nhan-tphcm-11.jpg",
];

//III. StudentBindings
class StudentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentController>(() => StudentController());
  }
}