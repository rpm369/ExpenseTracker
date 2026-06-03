import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AmountField extends StatelessWidget {
  void Function(double) callBack;

  AmountField({required this.callBack}) {
    callBack(0);

    node.addListener(() {
      if (!node.hasFocus) {
        String userAmount = (controller.text.isEmpty) ? "0" : controller.text;
        double newAmount = double.parse(userAmount);
        callBack(newAmount);
      }
    });
  }

  FocusNode node = FocusNode();
  TextEditingController controller = TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    return TextField(
      cursorColor: onSurface,
      style: TextStyle(fontSize: 20),
      controller: controller,
      focusNode: node,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "Default 0",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        focusedBorder: _decorationWidget(onSurface),
        enabledBorder: _decorationWidget(onSurface),
      ),
    );
  }

  OutlineInputBorder _decorationWidget(Color onSurface) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(width: 1, color: onSurface),
    );
  }
}
