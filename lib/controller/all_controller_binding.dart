import 'package:get/get.dart';
import 'student_controller.dart';

// Bindings
class AllControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentController>(() => StudentController());
  }
}
