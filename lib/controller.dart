import 'dart:math';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

//I. Đối tượng Sinh Viên
class SinhVien {
  String name;
  int age;
  String job;
  String linkImage;

  SinhVien(this.name, this.age, this.job, this.linkImage);
}

//II. Link ảnh chung (sẽ chọn ngẫu nhiên)
List<String> linkImageRandom = [
  "https://htmediagroup.vn/wp-content/uploads/2022/04/Anh-CV-chuyen-nghiep-min-1.jpg",
  "https://htmediagroup.vn/wp-content/uploads/2021/07/anh-profile-nam-min.jpg",
  "https://htmediagroup.vn/wp-content/uploads/2022/03/Anh-nghe-thuat-2.jpg",
  "https://chupanhthedep.com/wp-content/uploads/2022/10/chup-anh-profile-ca-nhan-tphcm-11.jpg",
];

//III. GetxController
class SinhVienController extends GetxController {

  RxBool showUpdate = false.obs; // Trạng thái nút update

  //1. List đối tượng Sinh Viên
  RxList<SinhVien> listSinhVien = <SinhVien>[
    SinhVien("Name 1", 23, "Sale", linkImageRandom[Random().nextInt(linkImageRandom.length)]),
    SinhVien("Name 2", 21, "Media", linkImageRandom[Random().nextInt(linkImageRandom.length)]),
    SinhVien("Name 3", 22, "Flutter developer", linkImageRandom[Random().nextInt(linkImageRandom.length)]),
    SinhVien("Name 4", 25, "Android developer", linkImageRandom[Random().nextInt(linkImageRandom.length)]),
    SinhVien("Name 5", 29, "ISO developer", linkImageRandom[Random().nextInt(linkImageRandom.length)]),
  ].obs;

  //2. Kiểm tra có trùng lặp dữ liệu: index đang check để loại trừ kiểm tra, dữ liệu đối tượng dùng để kiểm tra
  RxBool checkSinhVien(int index, SinhVien sinhVien){
    for(int i=0; i<listSinhVien.length; i++){
      if(i != index && listSinhVien[i].name == sinhVien.name && listSinhVien[i].job == sinhVien.job){
        return true.obs;
      }
    }
    return false.obs; // Giá trị mặc định
  }

  //3. Update thông tin một đối tượng: index theo list, dữ liệu đối tượng dùng để update
  updateSinhVien(int index, SinhVien sinhVien){
    listSinhVien[index].name = sinhVien.name;
    listSinhVien[index].age = sinhVien.age;
    listSinhVien[index].job = sinhVien.job;
    listSinhVien[index].linkImage = sinhVien.linkImage;

    update(); // Cập nhật, dùng GetBuidler do Obx không tự cập nhật được
  }

  void changeShowUpdate(){
    showUpdate.value = !showUpdate.value;
    update();
  }
}
