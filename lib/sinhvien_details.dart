import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thuctap_bai1/controller.dart';

import 'custom_widget.dart';

class SinhvienDetails extends StatefulWidget {

  final int indexSinhVien;
  SinhvienDetails({super.key, required this.indexSinhVien});

  @override
  State<SinhvienDetails> createState() => _SinhvienDetailsState();
}

class _SinhvienDetailsState extends State<SinhvienDetails> {

  //A. Dữ liệu
  SinhVienController sinhVienController = Get.find();

 // Text controller
  TextEditingController textName = TextEditingController();
  TextEditingController textAge = TextEditingController();
  TextEditingController textJob = TextEditingController();
  TextEditingController textLinkImage = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Gán giá trị ban đầu cho TextField
    textName.text = sinhVienController.listSinhVien[widget.indexSinhVien].name;
    textAge.text = '${sinhVienController.listSinhVien[widget.indexSinhVien].age}';
    textJob.text = sinhVienController.listSinhVien[widget.indexSinhVien].job;
    textLinkImage.text = sinhVienController.listSinhVien[widget.indexSinhVien].linkImage;

    // Tình trạng ban đầu của chọn update
    // showUpdate = false;
  }

 //D. Trang
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("${sinhVienController.listSinhVien[widget.indexSinhVien].name} Details"),
            backgroundColor: Colors.green,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<SinhVienController>(
              builder: (context1){
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      //1. Ảnh
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(sinhVienController.listSinhVien[widget.indexSinhVien].linkImage, width: double.infinity,),
                      ),
                      const SizedBox(height: 10,),

                      //2. Thông tin tên, tuổi, nghề nghiệp
                      if(sinhVienController.showUpdate.value == false)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(sinhVienController.listSinhVien[widget.indexSinhVien].name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700), textAlign: TextAlign.start,),
                            Text('Age: ${sinhVienController.listSinhVien[widget.indexSinhVien].age}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400), textAlign: TextAlign.start,),
                            Text('Job: ${sinhVienController.listSinhVien[widget.indexSinhVien].job}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400), textAlign: TextAlign.start,),
                          ],
                        ),
                      const SizedBox(height: 10,),

                      //3. Thay đổi thông tin (khi show)
                      if(sinhVienController.showUpdate.value == true)
                        Column(children: [
                          CustomTextFeild1(textControl: textName, maxLength: null, keyboardType: TextInputType.name, hintText: 'Name', prefixIcon: const Icon(Icons.account_circle_outlined), obscureText: false,),
                          const SizedBox(height: 8,),
                          CustomTextFeild1(textControl: textAge, maxLength: null, keyboardType: TextInputType.number, hintText: 'Age', prefixIcon: const Icon(Icons.support_agent), obscureText: false,),
                          const SizedBox(height: 8,),
                          CustomTextFeild1(textControl: textJob, maxLength: null, keyboardType: TextInputType.text, hintText: 'Job', prefixIcon: const Icon(Icons.account_balance), obscureText: false,),
                          const SizedBox(height: 8,),
                          CustomTextFeild1(textControl: textLinkImage, maxLength: null, keyboardType: TextInputType.text, hintText: 'Link Image', prefixIcon: const Icon(Icons.image), obscureText: false,),
                          const SizedBox(height: 10,),
                        ],),

                      //4. Update dữ liệu hoặc back
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          //4.1 Update đối tượng Sinh Viên
                            ElevatedButton(
                              onPressed: () {

                                if(sinhVienController.showUpdate.value == true){
                                  //1. Kiểm tra điều kiện: Phải có dữ liệu
                                  if(textName.text.isEmpty || textAge.text.isEmpty || textJob.text.isEmpty || textLinkImage.text.isEmpty){
                                    Get.snackbar("Thông báo", "Vui lòng điền đủ dữ liệu");
                                  } else {

                                    //2. Lấy dữ liệu từ TextField -> Tạo đối tượng Sinh Viên
                                    String name = textName.text.toString().trim();
                                    int age = int.parse(textAge.text.toString().trim());
                                    String job = textJob.text.toString().trim();
                                    String linkImage = textLinkImage.text.toString().trim();
                                    SinhVien sinhVien = SinhVien(name, age, job, linkImage);

                                    //3. Kiểm tra sự tồn tại so với các index khác
                                    if(sinhVienController.checkSinhVien(widget.indexSinhVien, sinhVien).value){
                                      Get.snackbar("Thông báo", "Đã tồn tại: ${textName.text.toString().trim()} - ${textJob.text.toString().trim()}");

                                    //4. Update nếu không trùng
                                    } else {
                                      sinhVienController.updateSinhVien(widget.indexSinhVien, sinhVien);
                                      sinhVienController.changeShowUpdate(); // Cập nhật sang nút edit
                                    }
                                  }
                                } else {
                                  setState(() {
                                    sinhVienController.changeShowUpdate(); // Cập nhật sang nút edit
                                  });
                                }

                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              child: Text( sinhVienController.showUpdate.value ? 'Update': "Edit", style: TextStyle(color: Colors.white),),
                            ),
                          const SizedBox(width: 10,),

                          //4.2. Trả về màn hình trước
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
                          ),
                        ],
                      ),

                      const SizedBox(height: 10,)

                    ],
                  ),
                );
              },
            ),
          ),
        ),
    );
  }
}