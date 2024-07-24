import 'package:flutter/material.dart';

//I. Wiget TextFeild tạo kiểu chung, nhập dữ liệu kiểu riêng khi khởi tạo
class TextInput extends StatelessWidget {
  TextEditingController textControl;
  int? maxLength;
  TextInputType keyboardType;
  String hintText;
  final Widget prefixIcon;
  bool obscureText;
  bool enable;
  bool error;

  TextInput(
      {required this.textControl,
      required this.maxLength,
      required this.keyboardType,
      required this.hintText,
      required this.prefixIcon,
      required this.obscureText,
      required this.enable,
      required this.error});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textControl,
      maxLines: 1,
      //dòng
      maxLength: maxLength,
      //số lượng ký tự
      enabled: enable,
      //cho phép sử dụng
      keyboardType: keyboardType,
      // Kiểu dữ liệu sẽ nhập vào
      textAlign: TextAlign.start,
      //Căn vị trí chữ gợi ý và chữ gõ vào
      style: const TextStyle(color: Colors.black),
      //kiểu dáng chữ sẽ gõ vào
      obscureText: obscureText,
      //Ẩn dạng password sau mỗi lần gõ

      decoration: InputDecoration(
        hintText: hintText,
        // Chữ gợi ý (Khi gõ chữ vào sẽ biến mất)
        hintStyle: const TextStyle(color: Colors.grey),
        // style chữ gợi ý
        // icon: Icon(Icons.email), //icon đầu dòng không nằm trong ô gõ
        prefixIcon: prefixIcon,
        //icon đầu dòng nằm trong ô gõ chữ
        contentPadding: const EdgeInsets.all(10),

        focusedBorder: OutlineInputBorder(
          //Viền ngoài của TextField -> Khi có focus
          borderSide: BorderSide(color: error ? Colors.red : Colors.blue, width: error ? 2 : 1),
          borderRadius: const BorderRadius.all(Radius.circular(10)), //Bo góc viền
        ),
        enabledBorder: OutlineInputBorder(
          //Viền ngoài của TextField -> Khi được phép gõ vào (enabled: true) nhưng chưa focus vào
          borderSide: BorderSide(color: error ? Colors.red : Colors.green, width: error ? 2 : 1),
          borderRadius: const BorderRadius.all(Radius.circular(10)), //Bo góc viền
        ),
      ),
      // focusNode: _focus,
    );
  }
}
