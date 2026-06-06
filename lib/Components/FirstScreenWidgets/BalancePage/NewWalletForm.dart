import 'dart:io';
import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/WalletNameField.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/UploadImageButton.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/FormHeader.dart';
import 'package:expense_tracker/Models/Wallet.dart';
import 'package:expense_tracker/Services/WalletServices.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewWalletForm extends StatefulWidget {
  @override
  State<NewWalletForm> createState() => _NewWalletFormState();
}

class _NewWalletFormState extends State<NewWalletForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  FocusNode nameNode = FocusNode();

  bool isLoading = false;

  Wallet wallet = Wallet(title: "", totalAmount: 0);

  Widget build(BuildContext context) {
    Color primary = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: EdgeInsets.all(15),
      child: (isLoading)
          ? Center(child: CircularProgressIndicator(color: Colors.blue))
          : _buildForm(),
    );
  }

  Widget _buildForm() {
    Color primary = Theme.of(context).colorScheme.primary;
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Provider(create: (_) => wallet, child: _inputFields()),
          ),
          UiUtils.formFooter(
            context: context,
            child: UiUtils.formButton(
              primary: primary,
              title: "Add Wallet",
              onTap: onSubmission,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onSubmission() async {
    if (isLoading || !formKey.currentState!.validate()) return;
    if (nameNode.hasFocus) nameNode.unfocus();

    setState(() {
      isLoading = true;
    });

    WalletServices walletService = context.read<WalletServices>();
    bool successStatus = await walletService.createNewWallet(newWallet: wallet);

    setState(() {
      isLoading = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (successStatus) Navigator.pop(context);
    });
  }

  Widget _inputFields() {
    return ListView(
      children: [
        FormHeader(title: "New Wallet"),
        SizedBox(height: 30),
        _buildNewWalletField(),
        SizedBox(height: 20),
        _buildUploadImageButton(),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildUploadImageButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        _commonText(title: "Wallet Icon", fontSize: 22),
        UploadImageButton(),
      ],
    );
  }

  Widget _buildNewWalletField() {
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
