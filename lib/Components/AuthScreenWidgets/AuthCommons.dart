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

  static Widget emailField({
    required Color onSurface,
    required Key key,
    required FocusNode node,
  }) {
    return TextFormField(
      key: key,
      cursorColor: onSurface,
      focusNode: node,
      style: TextStyle(fontSize: 20),
      decoration: AuthCommons.inputFieldDecoration(
        prefixIcon: Icons.mail,
        hintText: "Email",
        onSurface: onSurface,
      ),
    );
  }

  static Widget authButton({required Color primary, required bool isSignUp}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        (isSignUp) ? "Signup" : "Login",
        style: TextStyle(
          color: primary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
