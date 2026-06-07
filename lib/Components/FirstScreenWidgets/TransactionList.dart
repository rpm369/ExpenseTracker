import 'package:expense_tracker/Components/FirstScreenWidgets/TransactionTile.dart';
import 'package:expense_tracker/Models/Transaction.dart';
import 'package:expense_tracker/Services/TransactionServices.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatefulWidget {
  bool isScrollable;
  TransactionList({this.isScrollable = true});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  bool isLoading = true;
  List<Transaction>? transList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<TransactionServices>().fetchAllTransactions().then((list) {
      setState(() {
        isLoading = false;
        transList = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? Center(child: CircularProgressIndicator(color: Colors.blue))
        : (widget.isScrollable)
        ? _scrollableList()
        : _staticList();
  }

  Widget _staticList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: transList!
          .map((model) => TransactionTile(transaction: model))
          .toList(),
    );
  }

  Widget _scrollableList() {
    return ListView.builder(
      itemCount: transList!.length,
      itemBuilder: (context, index) {
        return TransactionTile(transaction: transList![index]);
      },
    );
  }
}
