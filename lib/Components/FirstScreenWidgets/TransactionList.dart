import 'package:expense_tracker/Components/FirstScreenWidgets/TransactionTile.dart';
import 'package:expense_tracker/Models/Transaction.dart';
import 'package:expense_tracker/Services/TransactionServices.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatefulWidget {
  final bool isScrollable;
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
    return AnimationLimiter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: transList!
              .map((model) => TransactionTile(transaction: model))
              .toList(),
        ),
      ),
    );
  }

  Widget _scrollableList() {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: transList!.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: TransactionTile(transaction: transList![index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
