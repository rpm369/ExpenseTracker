import 'dart:io';

import 'package:flutter/material.dart';

class UiUtils {
  static void displayBottomSheet({
    required Widget sheetContent,
    required BuildContext context,
  }) {
    Color primary = Theme.of(context).colorScheme.primary;
    showModalBottomSheet(
      context: context,
      backgroundColor: primary,
      isScrollControlled:
          true, // Crucial for forms so it can resize with the keyboard
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.87,
            child: sheetContent,
          ),
        );
      },
    );
  }

  static Widget FormTextField({
    Key? key,
    required BuildContext context,
    String? hintText,
    TextEditingController? controller,
    FocusNode? node,
    TextInputType? keyboardType,
    void Function(String?)? onSaved,
    void Function(String)? onChange,
    String? Function(String?)? validator,
  }) {
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    return TextFormField(
      key: key,
      cursorColor: onSurface,
      onSaved: onSaved,
      style: TextStyle(fontSize: 20),
      controller: controller,
      onChanged: onChange,
      focusNode: node,
      validator: validator,
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

  static Widget formFooter({
    required BuildContext context,
    required Widget child,
  }) {
    Color primary = Theme.of(context).colorScheme.primary;
    Color onSurface = Theme.of(context).colorScheme.onSurface;

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 2),
      decoration: BoxDecoration(color: primary),
      alignment: Alignment.center,
      child: child,
    );
  }

  static Widget formButton({
    required Color primary,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.deepOrange,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 26,
            color: primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static Widget avatar({String? fileImageURL, required double radius}) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: radius,
      backgroundImage: (fileImageURL == null)
          ? AssetImage("assets/images/defaultUser.jpg")
          : FileImage(File(fileImageURL)),
    );
  }
}
