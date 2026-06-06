import 'dart:io';

import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  String imageUrl;
  VoidCallback? onCancel;

  ImageViewer({super.key, required this.imageUrl, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 14, left: 14),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: FileImage(File(imageUrl)),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(top: 0, left: 0, child: _buildCancelButton()),
      ],
    );
  }

  Widget _buildCancelButton() {
    return GestureDetector(
      onTap: onCancel,
      child: Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: const Icon(Icons.close, color: Colors.black, size: 18),
      ),
    );
  }
}
