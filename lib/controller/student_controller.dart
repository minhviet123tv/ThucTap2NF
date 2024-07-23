import 'dart:math';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/student.dart';

//I. GetxController
class StudentController extends GetxController {

  RxBool showUpdate = false.obs; // Trạng thái nút update

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

  //2. Kiểm tra trùng lặp dữ liệu
  RxBool checkStudent(int index, Student student) {
    for (int i = 0; i < listStudent.length; i++) {
      if (i != index && listStudent[i].name == student.name && listStudent[i].job == student.job) {
        return true.obs;
      }
    }
    return false.obs; // Giá trị mặc định
  }

  //3. Update thông tin một đối tượng Student tại index
  updateStudent(int index, Student student) {
    listStudent[index].name = student.name;
    listStudent[index].age = student.age;
    listStudent[index].job = student.job;
    listStudent[index].linkImage = student.linkImage;

    update(); // Cập nhật, dùng GetBuidler do Obx không tự cập nhật được
  }

  //4. Cập nhật trạng thái hiển thị edit thông tin Student
  void changeShowUpdate() {
    showUpdate.value = !showUpdate.value;
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