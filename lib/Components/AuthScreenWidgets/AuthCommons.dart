import 'package:flutter/material.dart';

class AuthCommons {
  static InputDecoration inputFieldDecoration({
    required Color onSurface,
    required String hintText,
    required IconData prefixIcon,
    bool? isTextHidden,
    void Function()? changeVisibility,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      prefixIcon: Icon(prefixIcon, color: onSurface, size: 35),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 18),

      suffixIcon: _visibilityButton(
        isTextHidden: isTextHidden,
        changeVisibility: changeVisibility,
      ),
      errorStyle: TextStyle(color: Colors.red),
      errorMaxLines: 6,
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.red),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(width: 2, color: Colors.deepOrange),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(width: 1, color: onSurface),
      ),
    );
  }

  static Widget? _visibilityButton({
    bool? isTextHidden,
    void Function()? changeVisibility,
  }) {
    if (isTextHidden == null) return null;

    return IconButton(
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsetsGeometry.all(0)),
      ),
      onPressed: () {
        changeVisibility!();
      },
      icon: Icon(
        (isTextHidden) ? Icons.visibility_off : Icons.visibility,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  static Widget formTitle({required String txt}) {
    return Text(
      txt,
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  static Widget formSubtitle({required String txt, required Color txtColor}) {
    return Text(txt, style: TextStyle(color: txtColor, fontSize: 15));
  }
}
