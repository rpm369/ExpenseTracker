import 'package:flutter/material.dart';

class HomeCommons {
  static Widget FormTextField({
    required BuildContext context,
    String? hintText,
    TextEditingController? controller,
    FocusNode? node,
    TextInputType? keyboardType,
    void Function(String)? onChange,
  }) {
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    return TextField(
      cursorColor: onSurface,
      style: TextStyle(fontSize: 20),
      controller: controller,
      onChanged: onChange,
      focusNode: node,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        focusedBorder: _decorationWidget(onSurface: onSurface),
        enabledBorder: _decorationWidget(onSurface: onSurface),
      ),
    );
  }

  static OutlineInputBorder _decorationWidget({required Color onSurface}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(width: 1, color: onSurface),
    );
  }
}
