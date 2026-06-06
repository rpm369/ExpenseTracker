import 'dart:io';

import 'package:expense_tracker/Models/User.dart';
import 'package:expense_tracker/Services/ImageProcessService.dart';
import 'package:expense_tracker/Services/UserService.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarModifier extends StatefulWidget {
  AvatarModifier();
  @override
  State<AvatarModifier> createState() => _AvatarModifierState();
}

class _AvatarModifierState extends State<AvatarModifier> {
  User? user;

  @override
  Widget build(BuildContext context) {
    user = context.read<User>();
    return Stack(
      children: [
        UiUtils.avatar(fileImageURL: user?.imageURL, radius: 95),
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
        String? tempPath = await ImageProcessingService.getImageFromUser();
        if (tempPath != null) {
          setState(() {
            user?.imageURL = tempPath;
          });
        }
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
