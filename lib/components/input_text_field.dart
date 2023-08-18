import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget{

  final TextEditingController controller;

  const InputTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Напишите ваше сообщение',
        hintStyle: TextStyle(
          color: Color(0xFF97A3BA),
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
