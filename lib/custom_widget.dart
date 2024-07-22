import 'package:flutter/material.dart';

//I. Wiget TextFeild tạo kiểu chung, nhập dữ liệu kiểu riêng khi khởi tạo
class CustomTextFeild1 extends StatelessWidget{

  TextEditingController textControl;
  int? maxLength;
  TextInputType keyboardType;
  String hintText;
  final Widget prefixIcon;
  bool obscureText;

  CustomTextFeild1({required this.textControl, required this.maxLength, required this.keyboardType, required this.hintText,
    required this.prefixIcon, required this.obscureText});

  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: textControl,
      maxLines: 1, //dòng
      maxLength: maxLength, //số lượng ký tự
      enabled: true, //cho phép sử dụng
      keyboardType: keyboardType, // Kiểu dữ liệu sẽ nhập vào
      textAlign: TextAlign.start, //Căn vị trí chữ gợi ý và chữ gõ vào
      style: const TextStyle(color: Colors.blue), //kiểu dáng chữ sẽ gõ vào
      obscureText: obscureText, //Ẩn dạng password sau mỗi lần gõ

      decoration: InputDecoration(

        hintText: hintText, // Chữ gợi ý (Khi gõ chữ vào sẽ biến mất)
        hintStyle: const TextStyle(color: Colors.grey), // style chữ gợi ý
        // icon: Icon(Icons.email), //icon đầu dòng không nằm trong ô gõ
        prefixIcon: prefixIcon, //icon đầu dòng nằm trong ô gõ chữ
        contentPadding: const EdgeInsets.all(10),

        focusedBorder: const OutlineInputBorder( //Viền ngoài của TextField -> Khi có focus
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10)), //Bo góc viền
        ),
        enabledBorder: const OutlineInputBorder( //Viền ngoài của TextField -> Khi được phép gõ vào (enabled: true) nhưng chưa focus vào
          borderSide: BorderSide(color: Colors.green),
          borderRadius: BorderRadius.all(Radius.circular(10)), //Bo góc viền
        ),
      ),

    );
  }
}