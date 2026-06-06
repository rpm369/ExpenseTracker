import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:expense_tracker/Services/ImageProcessService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageButton extends StatelessWidget {
  void Function(File) callBack;

  UploadImageButton({required this.callBack});

  @override
  Widget build(BuildContext context) {
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    return GestureDetector(
      child: _buildButtonUI(onSurface: onSurface),
      onTap: () async {
        String? imageUrl = await ImageProcessingService.getImageFromUser();
        if (imageUrl != null) callBack(File(imageUrl));
      },
    );
  }

  Widget _buildButtonUI({required Color onSurface}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(15),
          color: Colors.grey.shade300,
          dashPattern: [4, 4],
          strokeWidth: 2,
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.shade600,
          ),
          child: _buildButtonContent(onSurface: onSurface),
        ),
      ),
    );
  }

  Widget _buildButtonContent({required Color onSurface}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.file_upload_outlined, color: onSurface, size: 25),
        Text("Upload Image", style: TextStyle(fontSize: 25)),
      ],
    );
  }
}
