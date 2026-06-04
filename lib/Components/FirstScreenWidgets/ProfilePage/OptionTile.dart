import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  VoidCallback? onClick;
  Color bgColor;
  IconData icon;
  String title;

  OptionTile({
    required this.bgColor,
    required this.icon,
    required this.title,
    this.onClick,
  });
  @override
  Widget build(BuildContext context) {
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onClick,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _leadingInfo(bgColor: bgColor, icon: icon, title: title),
            Icon(Icons.arrow_forward_ios_outlined, color: onSurface, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _leadingInfo({
    required Color bgColor,
    required IconData icon,
    required String title,
  }) {
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: bgColor,
          ),
          child: Icon(icon, size: 30, color: Colors.white),
        ),
        Text(title, style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
