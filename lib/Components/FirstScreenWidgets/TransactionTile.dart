import 'package:expense_tracker/Components/FirstScreenWidgets/CategoryVisuals.dart';
import 'package:expense_tracker/Models/ExpenseCategory.dart';
import 'package:expense_tracker/Models/Transaction.dart';
import 'package:expense_tracker/Utils/DateTimeUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionTile extends StatelessWidget {
  Transaction transaction;
  TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    Color secondary = Theme.of(context).colorScheme.secondary;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: secondary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: _buildTileContent(transaction: transaction),
    );
  }

  Widget _buildTileContent({required Transaction transaction}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _transactionIcon(expenseCategory: transaction.category),
              Expanded(
                child: _transactionTitle(
                  category: transaction.category.id,
                  title: transaction.title,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _amountText(trans: transaction),
            Text(
              DateTimeUtils.listTimeFormat(dateTime: transaction.dateTime),
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
      ],
    );
  }

  Widget _amountText({required Transaction trans}) {
    bool isIncome = trans.type == ExpenseType.INCOME;
    Color textColor = (isIncome) ? Colors.greenAccent : Colors.red;
    String prefixText = (isIncome) ? '+' : '-';

    return Text(
      "$prefixText \$${trans.amount}",
      style: TextStyle(color: textColor, fontSize: 20),
    );
  }

  Widget _transactionIcon({required ExpenseCategory expenseCategory}) {
    CategoryVisuals visuals =
        categoryRegistry[expenseCategory] ??
        CategoryVisuals(
          icon: Icons.check_box_outline_blank,
          color: Colors.black,
        );

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: visuals.color,
      ),
      child: Icon(visuals.icon, size: 33),
    );
  }

  Widget _transactionTitle({required String category, required String title}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(fontSize: 15, height: 1),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
