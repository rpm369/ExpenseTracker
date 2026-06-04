import 'dart:io';

import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/UpdateWalletForm.dart';
import 'package:expense_tracker/Models/Wallet.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';

class WalletTile extends StatelessWidget {
  Wallet wallet;

  WalletTile({required this.wallet});

  @override
  Widget build(BuildContext context) {
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    return GestureDetector(
      onTap: () {
        UiUtils.displayBottomSheet(
          sheetContent: Updatewalletform(wallet: wallet),
          context: context,
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _buildWalletInfo()),
            Icon(Icons.arrow_forward_ios_outlined, size: 20, color: onSurface),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 10,
      children: [
        _buildWalletImage(),
        Expanded(child: _buildWalletLabels()),
      ],
    );
  }

  Widget _buildWalletLabels() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        _commondTextWidget(title: wallet.title, textSize: 20),
        _commondTextWidget(
          title: "\$${wallet.totalAmount.toStringAsFixed(2)}",
          textColor: Colors.grey,
          textSize: 15,
        ),
      ],
    );
  }

  Widget _buildWalletImage() {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: (wallet.imageURL != null)
              ? FileImage(File(wallet.imageURL!))
              : AssetImage("assets/images/demo.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _commondTextWidget({
    required String title,
    required double textSize,
    Color? textColor,
  }) {
    return Text(
      title,
      style: TextStyle(color: textColor, fontSize: textSize, height: 1),
    );
  }
}
