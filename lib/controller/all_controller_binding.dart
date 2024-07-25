import 'package:get/get.dart';
import 'student_controller.dart';

// Bindings : Tạo Get.put tất cả các GetxController ở đây -> initialBinding ở GetMaterialApp
// => Các nơi sử dụng chỉ việc gọi Get.find<>();
class AllGetxControllerBinding extends Bindings {
  @override
  void dependencies() {
    // lazyPut: Chỉ tạo một GetxController khi gọi đến chứ không tạo tất cả GetxController (Có thể dùng khi chỉ mở 1 lần từ main)
    // (fenix: Duy trì trong bộ nhớ)
    Get.lazyPut<StudentController>(() => StudentController(), fenix: true);
    // Get.put(StudentController()); // Tạo ngay cả khi chưa gọi đến
  }
}
