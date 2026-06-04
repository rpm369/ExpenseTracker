import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/WalletTile.dart';
import 'package:expense_tracker/Models/Wallet.dart';
import 'package:flutter/material.dart';

class WalletList extends StatelessWidget {
  bool isScrollable;
  List<Wallet> listData;

  WalletList({this.isScrollable = false, required this.listData});

  @override
  Widget build(BuildContext context) {
    return (isScrollable) ? _buildScrollableList() : _buildNonScrollableList();
  }

  Widget _buildNonScrollableList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: listData.map((wallet) => WalletTile(wallet: wallet)).toList(),
    );
  }

  Widget _buildScrollableList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return WalletTile(wallet: listData[index]);
      },
      itemCount: listData.length,
    );
  }
}
