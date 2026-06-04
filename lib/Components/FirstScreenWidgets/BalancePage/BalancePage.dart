import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/NewWalletForm.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/WalletList.dart';
import 'package:expense_tracker/Database/DummyWallets.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';

class BalancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalHeight = constraints.maxHeight;
        final headerHeight = totalHeight * 0.3;
        const overlap = 20.0;

        return Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: headerHeight,
              child: _buildPageHeader(context: context, amount: 300),
            ),
            Positioned(
              top: headerHeight - overlap,
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildWalletsSheet(context: context),
            ),
          ],
        );
      },
    );
  }

  Widget _buildWalletsSheet({required BuildContext context}) {
    Color primary = Theme.of(context).colorScheme.primary;
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: primary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _walletHeader(primary: primary, context: context),
          SizedBox(height: 3),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: WalletList(listData: dummyWallets, isScrollable: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _walletHeader({
    required Color primary,
    required BuildContext context,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _commonTextWidget(
          title: "My Wallets",
          textSize: 23,
          fontWeight: FontWeight.bold,
        ),
        _buildAddNewButton(primaryColor: primary, context: context),
      ],
    );
  }

  Widget _buildAddNewButton({
    required Color primaryColor,
    required BuildContext context,
  }) {
    return ElevatedButton(
      onPressed: () {
        UiUtils.displayBottomSheet(
          sheetContent: NewWalletForm(),
          context: context,
        );
      },
      child: Icon(Icons.add, color: primaryColor, size: 28),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0),
        backgroundColor: Colors.deepOrange,
        shape: CircleBorder(eccentricity: 0),
      ),
    );
  }

  Widget _buildPageHeader({
    required BuildContext context,
    required double amount,
  }) {
    Color surface = Theme.of(context).colorScheme.surface;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: surface),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _commonTextWidget(
            title: "\$ ${amount.toStringAsFixed(2)}",
            textSize: 35,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
          _commonTextWidget(
            title: "Total Balance",
            textSize: 15,
            textColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _commonTextWidget({
    required String title,
    Color? textColor,
    required double textSize,
    double? letterSpacing,
    FontWeight? fontWeight,
  }) {
    return Text(
      title,
      style: TextStyle(
        color: textColor,
        fontSize: textSize,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight,
      ),
    );
  }
}
