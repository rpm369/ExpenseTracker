import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/ImageViewer.dart';
import 'package:expense_tracker/Models/User.dart';
import 'package:expense_tracker/Models/Wallet.dart';
import 'package:expense_tracker/Services/ImageProcessService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadImageButton extends StatefulWidget {
  @override
  State<UploadImageButton> createState() => _UploadImageButtonState();
}

class _UploadImageButtonState extends State<UploadImageButton> {
  Wallet? wallet;

  @override
  Widget build(BuildContext context) {
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    wallet = context.read<Wallet>();

    return GestureDetector(
      child: _buildButtonUI(onSurface: onSurface),
      onTap: () async {
        String? imageUrl = await ImageProcessingService.getImageFromUser();
        if (imageUrl != null)
          setState(() {
            wallet!.imageURL = imageUrl;
          });
      },
    );
  }

  Widget _buildButtonUI({required Color onSurface}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _uploadButton(),
          (wallet!.imageURL != null)
              ? ImageViewer(
                  imageUrl: wallet!.imageURL!,
                  onCancel: () => setState(() {
                    wallet!.imageURL = null;
                  }),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _uploadButton() {
    return DottedBorder(
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
        child: _buildButtonContent(),
      ),
    );
  }

  Widget _buildButtonContent() {
    Color onSurface = Theme.of(context).colorScheme.onSurface;
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
