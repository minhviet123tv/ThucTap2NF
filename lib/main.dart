import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thuctap_bai1/controller.dart';
import 'package:thuctap_bai1/sinhvien_details.dart';

import 'custom_widget.dart';

// main
void main() {
  runApp(
    GetMaterialApp(
      home: HomePageBai1(),
    ),
  );
}

//I. Home Page
class HomePageBai1 extends StatelessWidget{

  //A. Tạo Getx Controller
  final sinhVienController = Get.put(SinhVienController());

  //D. Trang
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Danh sách Sinh Viên"),
          backgroundColor: Colors.blue,
        ),
        body: HomePageBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            addSinhVien(context);
          },
          child: const Icon(Icons.add),
        ),
      ),

    );
  }

  //E. Dialog thêm Sinh Viên mới
  void addSinhVien(BuildContext context){

    // Tạo controller cho các TextField
    TextEditingController textName = TextEditingController();
    TextEditingController textAge = TextEditingController();
    TextEditingController textJob = TextEditingController();
    TextEditingController textLinkImage = TextEditingController();

    // Hiển thị Dialog
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Thêm sinh viên mới', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                const SizedBox(height: 15),
          
                //1. Điền thông tin
                CustomTextFeild1(textControl: textName, maxLength: null, keyboardType: TextInputType.name, hintText: 'Name', prefixIcon: const Icon(Icons.account_circle_outlined), obscureText: false,),
                const SizedBox(height: 8,),
                CustomTextFeild1(textControl: textAge, maxLength: null, keyboardType: TextInputType.number, hintText: 'Age', prefixIcon: const Icon(Icons.support_agent), obscureText: false,),
                const SizedBox(height: 8,),
                CustomTextFeild1(textControl: textJob, maxLength: null, keyboardType: TextInputType.text, hintText: 'Job', prefixIcon: const Icon(Icons.account_balance), obscureText: false,),
                const SizedBox(height: 8,),
                CustomTextFeild1(textControl: textLinkImage, maxLength: null, keyboardType: TextInputType.text, hintText: 'Link Image', prefixIcon: const Icon(Icons.image), obscureText: false,),
                const SizedBox(height: 10,),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
          
                    //2. Chọn thêm đối tượng Sinh Viên
                    ElevatedButton(
                      onPressed: () {
          
                        // Kiểm tra điều kiện: Phải có dữ liệu
                        if(textName.text.isEmpty || textAge.text.isEmpty || textJob.text.isEmpty || textLinkImage.text.isEmpty){
                          Get.snackbar("Thông báo", "Vui lòng điền đủ dữ liệu");
                        } else {
                          sinhVienController.listSinhVien.forEach((element){

                            // Kiểm tra điều kiện của dữ liệu: Không trùng tên (name) và nghề nghiệp (job)
                            if(element.name.toLowerCase() == textName.text.toString().trim().toLowerCase() && element.job.toLowerCase() == textJob.text.toString().trim().toLowerCase()){
                              Get.snackbar("Thông báo", "Đã tồn tại: ${textName.text.toString().trim()} - ${textJob.text.toString().trim()}");
                            } else {
                              // Thêm dữ liệu mới
                              String name = textName.text.toString().trim();
                              int age = int.parse(textAge.text.toString().trim());
                              String job = textJob.text.toString().trim();
                              String linkImage = textLinkImage.text.toString().trim();

                              sinhVienController.listSinhVien.add(SinhVien(name, age, job, linkImage));
                              sinhVienController.update(); // Cập nhật dữ liệu cho list

                              // Đóng cửa sổ
                              Navigator.pop(context);
                            }
                          });
                        }
          
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      child: const Text('Add', style: TextStyle(color: Colors.white),),
                    ),
                    const SizedBox(width: 10,),
          
                    //3. Đóng cửa sổ
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                      ),
                      child: const Text('Close', style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//II. Body
class HomePageBody extends StatelessWidget{

  // Tìm Getx Controller
  final SinhVienController sinhVienController = Get.find();

  // Trang ListView
  @override
  Widget build(BuildContext context) {

    return GetBuilder<SinhVienController>(
      builder: (context){

        //I. Sắp xếp dữ liệu
        sinhVienController.listSinhVien.sort((a,b) => a.age.compareTo(b.age));

        //II. ListView danh sách Sinh Viên
        return ListView.builder(
          itemCount: sinhVienController.listSinhVien.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.green,
                child: InkWell(
                  onTap: (){
                    // Sự kiện khi click item -> Xem details
                    Get.to(() => SinhvienDetails(indexSinhVien: index));
                  },
                  child: Row(
                    children: [

                      //1. Ảnh
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          sinhVienController.listSinhVien[index].linkImage,
                          fit: BoxFit.cover,
                          width: 160,
                          height: 220,
                        ),
                      ),

                      //2. Thông tin tên, tuổi, nghề nghiệp
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(sinhVienController.listSinhVien[index].name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700), textAlign: TextAlign.start,),
                            Text('Age: ${sinhVienController.listSinhVien[index].age}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400), textAlign: TextAlign.start,),
                            Text('Job: ${sinhVienController.listSinhVien[index].job}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400), textAlign: TextAlign.start,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}



