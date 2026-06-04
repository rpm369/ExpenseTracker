import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  String title;
  FormHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _backButton(context: context),
        const Spacer(),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        const Spacer(),
        const SizedBox(
          width: 48,
        ), // Spacer placeholder to balance the back button width and center the text
      ],
    );
  }

  Widget _backButton({required BuildContext context}) {
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    Color secondary = Theme.of(context).colorScheme.secondary;
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Icon(
        Icons.arrow_back_ios_new_outlined,
        color: onSurface,
        size: 25,
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0),
        backgroundColor: secondary,
        shape: CircleBorder(),
      ),
    );
  }
}
