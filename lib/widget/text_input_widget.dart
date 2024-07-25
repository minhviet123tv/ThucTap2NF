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
      maxLength: maxLength,
      enabled: enable,
      keyboardType: keyboardType,
      textAlign: TextAlign.start,
      //kiểu dáng chữ sẽ gõ vào
      style: const TextStyle(color: Colors.black),
      //Ẩn dạng password sau mỗi lần gõ
      obscureText: obscureText,

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.all(10),
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: error ? Colors.red : Colors.blue, width: error ? 2 : 1),
          borderRadius: const BorderRadius.all(Radius.circular(10)), //Bo góc viền
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: error ? Colors.red : Colors.green, width: error ? 2 : 1),
          borderRadius: const BorderRadius.all(Radius.circular(10)), //Bo góc viền
        ),
      ),
    );
  }
}
