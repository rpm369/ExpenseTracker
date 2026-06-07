import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/AmountField.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/DateSelectionTile.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/FormHeader.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/ModExpansionTile.dart';
import 'package:expense_tracker/Models/ExpenseCategory.dart';
import 'package:expense_tracker/Models/Transaction.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';

class NewTransactionForm extends StatefulWidget {
  const NewTransactionForm({super.key});

  @override
  State<NewTransactionForm> createState() => _NewTransactionFormState();
}

class _NewTransactionFormState extends State<NewTransactionForm> {
  bool isLoading = false;
  Transaction transaction = Transaction(
    category: ExpenseCategory.HEALTH,
    title: "",
    amount: 0,
    type: ExpenseType.INCOME,
    dateTime: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: (isLoading)
          ? Center(child: CircularProgressIndicator(color: Colors.blue))
          : _buildForm(),
    );
  }

  Widget _buildForm() {
    Color primary = Theme.of(context).colorScheme.primary;
    return Column(
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
        UiUtils.formFooter(
          context: context,
          child: UiUtils.formButton(
            primary: primary,
            title: "Submit",
            onTap: () {},
          ),
        ),
      ],
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
          callBack: (selectedType) =>
              transaction.type = ExpenseType.fromId(selectedType),
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
