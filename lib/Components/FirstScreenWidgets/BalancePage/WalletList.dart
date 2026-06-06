import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/WalletTile.dart';
import 'package:expense_tracker/Models/Wallet.dart';
import 'package:expense_tracker/Services/WalletServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletList extends StatefulWidget {
  bool isScrollable;

  WalletList({this.isScrollable = false});

  @override
  State<WalletList> createState() => _WalletListState();
}

class _WalletListState extends State<WalletList> {
  List<Wallet>? walletList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    walletList = null;
    final walletServices = context.watch<WalletServices>();
    walletServices.getAllWallets().then(
      (list) => setState(() {
        walletList = list;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (walletList == null)
        ? CircularProgressIndicator(color: Colors.blue)
        : (widget.isScrollable)
        ? _buildScrollableList()
        : _buildNonScrollableList();
  }

  Widget _buildNonScrollableList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: walletList!
          .map((wallet) => WalletTile(wallet: wallet))
          .toList(),
    );
  }

  Widget _buildScrollableList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return WalletTile(wallet: walletList![index]);
      },
      itemCount: walletList!.length,
    );
  }
}
