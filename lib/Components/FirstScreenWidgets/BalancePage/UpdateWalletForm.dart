import 'dart:io';

import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/ErrorDialog.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/UploadImageButton.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/WalletNameField.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/FormHeader.dart';
import 'package:expense_tracker/Errors.dart';
import 'package:expense_tracker/Models/Wallet.dart';
import 'package:expense_tracker/Services/WalletServices.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Updatewalletform extends StatefulWidget {
  @override
  State<Updatewalletform> createState() => _UpdatewalletformState();
}

class _UpdatewalletformState extends State<Updatewalletform> {
  GlobalKey<FormState> formKey = GlobalKey();

  Wallet? newWallet;

  FocusNode nameNode = FocusNode();

  bool isLoading = false;

  Future<void> updateMethod() async {
    if (isLoading || !formKey.currentState!.validate()) return;
    if (nameNode.hasFocus) nameNode.unfocus();

    setState(() {
      isLoading = true;
    });

    bool successStatus = true;
    try {
      await context.read<WalletServices>().updateWallet(newWallet: newWallet!);
    } on DuplicateEntityException {
      successStatus = false;
      showDialog(
        context: context,
        builder: (_) => ErrorDialog(message: "Wallet already exist!"),
      );
    }

    setState(() {
      isLoading = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (successStatus) Navigator.pop(context);
    });
  }

  Future<void> onDelete() async {
    setState(() {
      isLoading = true;
    });

    bool successStatus = await context
        .read<WalletServices>()
        .deleteSelectedWallet();

    setState(() {
      isLoading = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (successStatus) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Wallet selectedWallet = context
        .read<WalletServices>()
        .selectedWalletForForm!;

    newWallet = Wallet(
      title: selectedWallet.title,
      totalAmount: selectedWallet.totalAmount,
      imageURL: selectedWallet.imageURL,
    );

    return Padding(
      padding: EdgeInsets.all(15),
      child: Provider(
        create: (_) => newWallet,
        child: (isLoading)
            ? Center(child: CircularProgressIndicator(color: Colors.blue))
            : _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    Color primary = Theme.of(context).colorScheme.primary;
    return Form(
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
    );
  }

  Widget _buildFooterContent({required Color primaryColor}) {
    return Row(
      spacing: 30,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _deleteButton(),
        UiUtils.formButton(
          primary: primaryColor,
          title: "Update Wallet",
          onTap: updateMethod,
        ),
      ],
    );
  }

  Widget _deleteButton() {
    return ElevatedButton(
      onPressed: onDelete,
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
        _buildWalletIcon(),
      ],
    );
  }

  Widget _buildWalletIcon() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        _commonText(title: "Wallet Icon", fontSize: 22),
        UploadImageButton(),
      ],
    );
  }

  Widget _buildUpdateWalletField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        _commonText(title: "Wallet Name", fontSize: 22),
        WalletNameField(node: nameNode),
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
