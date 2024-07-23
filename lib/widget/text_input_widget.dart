import 'package:flutter/material.dart';

//I. Wiget TextFeild tạo kiểu chung, nhập dữ liệu kiểu riêng khi khởi tạo
class TextInput extends StatefulWidget {

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
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textControl,
      maxLines: 1,
      //dòng
      maxLength: widget.maxLength,
      //số lượng ký tự
      enabled: widget.enable,
      //cho phép sử dụng
      keyboardType: widget.keyboardType,
      // Kiểu dữ liệu sẽ nhập vào
      textAlign: TextAlign.start,
      //Căn vị trí chữ gợi ý và chữ gõ vào
      style: const TextStyle(color: Colors.black),
      //kiểu dáng chữ sẽ gõ vào
      obscureText: widget.obscureText,
      //Ẩn dạng password sau mỗi lần gõ

      decoration: InputDecoration(
        hintText: widget.hintText,
        // Chữ gợi ý (Khi gõ chữ vào sẽ biến mất)
        hintStyle: const TextStyle(color: Colors.grey),
        // style chữ gợi ý
        // icon: Icon(Icons.email), //icon đầu dòng không nằm trong ô gõ
        prefixIcon: widget.prefixIcon,
        //icon đầu dòng nằm trong ô gõ chữ
        contentPadding: const EdgeInsets.all(10),

        focusedBorder: OutlineInputBorder(
          //Viền ngoài của TextField -> Khi có focus
          borderSide: BorderSide(color: widget.error ? Colors.red : Colors.blue),
          borderRadius: const BorderRadius.all(Radius.circular(10)), //Bo góc viền
        ),
        enabledBorder: OutlineInputBorder(
          //Viền ngoài của TextField -> Khi được phép gõ vào (enabled: true) nhưng chưa focus vào
          borderSide: BorderSide(color: widget.error ? Colors.red : Colors.green),
          borderRadius: const BorderRadius.all(Radius.circular(10)), //Bo góc viền
        ),
      ),
      // focusNode: _focus,
    );
  }
}
