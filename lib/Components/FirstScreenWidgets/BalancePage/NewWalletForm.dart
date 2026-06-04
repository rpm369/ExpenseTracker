import 'dart:io';

import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/AddWalletButton.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/ImageViewer.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/UploadImageButton.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/WalletNameField.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/FormHeader.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';

class NewWalletForm extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  ValueNotifier<File?> selectedFile = ValueNotifier(null);

  Widget build(BuildContext context) {
    Color primary = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: selectedFile,
                builder: (_, _, _) {
                  return _inputFields();
                },
              ),
            ),
            UiUtils.formFooter(context: context, child: AddWalletButton()),
          ],
        ),
      ),
    );
  }

  Widget _inputFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FormHeader(title: "New Wallet"),
        SizedBox(height: 30),
        _buildNewWalletField(),
        SizedBox(height: 20),
        _buildUploadImageButton(),
        SizedBox(height: 20),
        if (selectedFile.value != null)
          ImageViewer(
            imageFile: selectedFile.value!,
            callBack: () {
              selectedFile.value = null;
            },
          ),
      ],
    );
  }

  Widget _buildUploadImageButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        _commonText(title: "Wallet Icon", fontSize: 22),
        UploadImageButton(
          callBack: (imageFile) {
            selectedFile.value = imageFile;
          },
        ),
      ],
    );
  }

  Widget _buildNewWalletField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        _commonText(title: "Wallet Name", fontSize: 22),
        WalletNameField(callBack: (value) {}),
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
