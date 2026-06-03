import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/AmountField.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/DateSelectionTile.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/FormHeader.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/ModExpansionTile.dart';
import 'package:expense_tracker/Models/ExpenseCategory.dart';
import 'package:flutter/material.dart';

class NewTransactionForm extends StatelessWidget {
  const NewTransactionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        children: [
          FormHeader(title: "Add Transaction"),
          SizedBox(height: 15),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              children: [
                _buildTypeTile(),
                SizedBox(height: 20),
                _buildWalletTile(),
                SizedBox(height: 20),
                _buildCategoryTile(),
                SizedBox(height: 20),
                _buildDateTile(),
                SizedBox(height: 20),
                _buildAmountField(),
              ],
            ),
          ),
          _buildSubmitButton(context: context),
        ],
      ),
    );
  }

  Widget _buildSubmitButton({required BuildContext context}) {
    Color primary = Theme.of(context).colorScheme.primary;
    Color onSurface = Theme.of(context).colorScheme.onSurface;

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 2),
      decoration: BoxDecoration(color: primary),
      alignment: Alignment.center,
      child: _submitButton(primary: primary),
    );
  }

  Widget _submitButton({required Color primary}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.deepOrange,
        ),
        child: Text(
          "Submit",
          style: TextStyle(
            fontSize: 26,
            color: primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildAmountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text("Amount", style: TextStyle(fontSize: 20)),
        AmountField(callBack: (value) {}),
      ],
    );
  }

  Widget _buildDateTile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text("Date", style: TextStyle(fontSize: 20)),
        DateSelectionTile(callBack: (value) {}),
      ],
    );
  }

  Widget _buildTypeTile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text("Type", style: TextStyle(fontSize: 20)),
        ModExpansionTile(
          callBack: (selectedType) {},
          children: ExpenseType.idList(),
        ),
      ],
    );
  }

  Widget _buildCategoryTile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text("Expense Category", style: TextStyle(fontSize: 20)),
        ModExpansionTile(
          callBack: (selectedCategory) {},
          children: ExpenseCategory.idList(),
        ),
      ],
    );
  }

  //Entries for this Expansion Tile depends upon the dynamic data from the backend.
  Widget _buildWalletTile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text("Wallet", style: TextStyle(fontSize: 20)),
        ModExpansionTile(callBack: (value) {}, children: []),
      ],
    );
  }
}
