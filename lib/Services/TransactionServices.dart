import 'package:expense_tracker/Database/TransactionDb.dart';
import 'package:expense_tracker/Database/WalletDb.dart';
import 'package:expense_tracker/Models/ExpenseType.dart';
import 'package:expense_tracker/Models/Transaction.dart';
import 'package:expense_tracker/Models/Wallet.dart';
import 'package:flutter/material.dart';

class TransactionServices extends ChangeNotifier {
  Future<void> deleteTransactionsWithWalletId({required int walletId}) async {
    TransactionDb transDb = TransactionDb.getDb();

    (await fetchAllTransactions()).forEach((trans) async {
      if (trans.walletId == walletId)
        await transDb.deleteTransaction(trans: trans);
    });
  }

  Future<void> addNewTransaction({required Transaction transaction}) async {
    TransactionDb transactionDb = TransactionDb.getDb();
    WalletDb walletDb = await WalletDb.getDb();

    Wallet linkedWallet = await walletDb.getWallet(id: transaction.walletId);

    if (transaction.type == ExpenseType.EXPENSE) {
      linkedWallet.totalAmount -= transaction.amount;
    } else {
      linkedWallet.totalAmount += transaction.amount;
    }

    await walletDb.update(wallet: linkedWallet);

    int newId = await transactionDb.addNewTransaction(
      newTransaction: transaction,
    );
    transaction.id = newId;
    await transactionDb.updateTransaction(transaction: transaction);
    notifyListeners();
  }

  Future<Map<String, double>> getBalanceStatus() async {
    List<Transaction> allTransactions = await fetchAllTransactions();
    double income = 0;
    double expense = 0;

    allTransactions.forEach((trans) {
      if (trans.type == ExpenseType.EXPENSE)
        expense += trans.amount;
      else
        income += trans.amount;
    });

    double total = income - expense;

    return {'Income': income, 'Expense': expense, 'Total': total};
  }

  Future<List<Transaction>> fetchAllTransactions() async {
    TransactionDb transactionDb = TransactionDb.getDb();

    return transactionDb.getAllTransactions();
  }
}
