import 'package:expense_tracker/Components/FirstScreenWidgets/TransactionTile.dart';
import 'package:expense_tracker/Models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SearchableList extends StatelessWidget {
  final List<Transaction> data;
  SearchableList({required this.data});

  @override
  Widget build(BuildContext context) {
    return _staticList();
  }

  Widget _staticList() {
    return AnimationLimiter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: data
              .map((model) => TransactionTile(transaction: model))
              .toList(),
        ),
      ),
    );
  }
}
