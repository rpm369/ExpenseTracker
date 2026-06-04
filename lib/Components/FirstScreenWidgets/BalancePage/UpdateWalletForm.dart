import 'dart:io';

import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/ImageViewer.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/UploadImageButton.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/WalletNameField.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/FormHeader.dart';
import 'package:expense_tracker/Models/Wallet.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';

class Updatewalletform extends StatelessWidget {
  Wallet wallet;
  ValueNotifier<File?> imageFile;

  Updatewalletform({required this.wallet})
    : imageFile = ValueNotifier(File(wallet.imageURL!));

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FormHeader(title: "Updated Wallet"),
            SizedBox(height: 30),
            Expanded(child: _formFields()),
            UiUtils.formFooter(
              context: context,
              child: _buildFooterContent(primaryColor: primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterContent({required Color primaryColor}) {
    return Row(
      spacing: 30,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _deleteButton(),
        UiUtils.formButton(primary: primaryColor, title: "Update Wallet"),
      ],
    );
  }

  Widget _deleteButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15),
        ),
      ),
      child: Icon(Icons.delete, color: Colors.white, size: 25),
    );
  }

  Widget _formFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildUpdateWalletField(),
        SizedBox(height: 20),
        ValueListenableBuilder(
          valueListenable: imageFile,
          builder: (_, _, _) {
            return _buildWalletIcon();
          },
        ),
      ],
    );
  }

  Widget _buildWalletIcon() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        _commonText(title: "Wallet Icon", fontSize: 22),
        (imageFile.value != null)
            ? ImageViewer(
                imageFile: File("assets/images/demo.png"),
                callBack: () {
                  imageFile.value = null;
                },
              )
            : UploadImageButton(callBack: (file) => imageFile.value = file),
      ],
    );
  }

  Widget _buildUpdateWalletField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        _commonText(title: "Wallet Name", fontSize: 22),
        WalletNameField(callBack: (value) {}, existingText: wallet.title),
      ],
    );
  }

  Widget _commonText({
    required String title,
    required double fontSize,
    Color? textColor,
  }) {
    return Text(
      title,
      style: TextStyle(color: textColor, fontSize: fontSize),
    );
  }
}
