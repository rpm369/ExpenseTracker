import 'package:expense_tracker/Components/FirstScreenWidgets/ErrorDialog.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/AmountField.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/DateSelectionTile.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/FormHeader.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/ModExpansionTile.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/TitleField.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/WalletExpensionTile.dart';
import 'package:expense_tracker/Models/ExpenseCategory.dart';
import 'package:expense_tracker/Models/ExpenseType.dart';
import 'package:expense_tracker/Models/Transaction.dart';
import 'package:expense_tracker/Models/Wallet.dart';
import 'package:expense_tracker/Services/TransactionServices.dart';
import 'package:expense_tracker/Services/WalletServices.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewTransactionForm extends StatefulWidget {
  const NewTransactionForm({super.key});

  @override
  State<NewTransactionForm> createState() => _NewTransactionFormState();
}

class _NewTransactionFormState extends State<NewTransactionForm> {
  bool isLoading = true;
  FocusNode amountNode = FocusNode();
  FocusNode titleNode = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey();

  Transaction transaction = Transaction(
    category: ExpenseCategory.values[0],
    title: "",
    amount: 0,
    type: ExpenseType.values[0],
    dateTime: DateTime.now(),
    walletId: -1,
  );

  List<Wallet>? walletList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<WalletServices>().getAllWallets().then((list) {
      setState(() {
        walletList = list;
        isLoading = false;
      });
      if (walletList!.isNotEmpty) transaction.walletId = walletList![0].id!;
    });
  }

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
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              children: [
                _buildNameField(),
                SizedBox(height: 20),
                _buildAmountField(),
                SizedBox(height: 20),
                _buildTypeTile(),
                SizedBox(height: 20),
                _buildWalletTile(),
                SizedBox(height: 20),
                _buildCategoryTile(),
                SizedBox(height: 20),
                _buildDateTile(),
              ],
            ),
          ),
        ),
        UiUtils.formFooter(
          context: context,
          child: UiUtils.formButton(
            primary: primary,
            title: "Submit",
            onTap: submitForm,
          ),
        ),
      ],
    );
  }

  Future<void> submitForm() async {
    if (isLoading || !formKey.currentState!.validate()) return;

    if (titleNode.hasFocus) titleNode.unfocus();
    if (amountNode.hasFocus) amountNode.unfocus();

    if (transaction.walletId == -1) {
      showDialog(
        context: context,
        builder: (_) => ErrorDialog(
          message:
              "Please assign a wallet to this transaction, If there is no wallet - create one first.",
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    await context.read<TransactionServices>().addNewTransaction(
      transaction: transaction,
    );

    setState(() {
      isLoading = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context);
    });
  }

  Widget _buildNameField() {
    return Column(
      spacing: 10,
      children: [
        Text("Title", style: TextStyle(fontSize: 20)),
        TitleField(
          node: titleNode,
          callBack: (newTitle) => transaction.title = newTitle,
          onSave: (_) => amountNode.requestFocus(),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget _buildAmountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text("Amount", style: TextStyle(fontSize: 20)),
        AmountField(
          callBack: (newAmount) => transaction.amount = newAmount,
          node: amountNode,
        ),
      ],
    );
  }

  Widget _buildDateTile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text("Date", style: TextStyle(fontSize: 20)),
        DateSelectionTile(
          callBack: (selectedDateTime) =>
              transaction.dateTime = selectedDateTime,
        ),
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
          callBack: (selectedCategory) {
            transaction.category = ExpenseCategory.fromId(selectedCategory);
          },
          children: ExpenseCategory.idList(),
        ),
      ],
    );
  }

  Widget _buildWalletTile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text("Wallet", style: TextStyle(fontSize: 20)),
        WalletExpensionTile(
          children: walletList!,
          onWalletSelection: (walletId) {
            transaction.walletId = walletId;
          },
        ),
      ],
    );
  }
}
