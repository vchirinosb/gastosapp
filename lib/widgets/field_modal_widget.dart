import 'package:flutter/material.dart';

class FieldModalWidget extends StatelessWidget {
  String hint;
  TextEditingController controller;
  bool isNumberKeyBoard;
  bool isDatePicker;
  VoidCallback? function;
  FieldModalWidget({super.key, 
    required this.hint,
    required this.controller,
    this.isNumberKeyBoard = false,
    this.isDatePicker = false,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        onTap: function,
        readOnly: isDatePicker,
        keyboardType:
            isNumberKeyBoard ? TextInputType.number : TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.4),
            fontSize: 14,
          ),
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          contentPadding: const EdgeInsets.all(16),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}