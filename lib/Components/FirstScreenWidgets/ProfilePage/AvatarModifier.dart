import 'dart:io';

import 'package:expense_tracker/Services/FilePickerService.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AvatarModifier extends StatelessWidget {
  void Function(File) callBack;

  AvatarModifier({required this.callBack});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        UiUtils.avatar(assetImageURL: "assets/images/demo.png", radius: 95),
        Positioned(
          child: _buildEditButton(context: context),
          bottom: 0,
          right: 0,
        ),
      ],
    );
  }

  Widget _buildEditButton({required BuildContext context}) {
    Brightness brightness = Theme.of(context).colorScheme.brightness;
    return GestureDetector(
      onTap: () async {
        File? file = await FilePickerService.getFileFromUser();
        if (file != null) callBack(file);
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (brightness == Brightness.dark)
              ? Colors.white60
              : Colors.black54,
        ),
        alignment: Alignment.center,
        child: Icon(Icons.edit, color: Colors.black, size: 20),
      ),
    );
  }
}
