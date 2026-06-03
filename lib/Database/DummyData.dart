import 'package:expense_tracker/Models/ExpenseCategory.dart';
import 'package:expense_tracker/Models/Transaction.dart';

List<Transaction> dummyData = [
  Transaction(
    category: ExpenseCategory.UTILITIES,
    title: "Electricity Bill",
    amount: 85.50,
    type: ExpenseType.EXPENSE,
    dateTime: DateTime.now(),
  ),
  Transaction(
    category: ExpenseCategory.TRANSPORTATION,
    title: "Subway Pass",
    amount: 45.00,
    type: ExpenseType.EXPENSE,
    dateTime: DateTime.now(),
  ),
  Transaction(
    category: ExpenseCategory.HEALTH,
    title: "Dental Checkup",
    amount: 120.00,
    type: ExpenseType.EXPENSE,
    dateTime: DateTime.now(),
  ),
  Transaction(
    category: ExpenseCategory.LOAN,
    title: "Car Loan Payment",
    amount: 350.00,
    type: ExpenseType.EXPENSE,
    dateTime: DateTime.now(),
  ),
  Transaction(
    category: ExpenseCategory.GROCERIES,
    title: "Weekly Groceries",
    amount: 154.20,
    type: ExpenseType.EXPENSE,
    dateTime: DateTime.now(),
  ),
  Transaction(
    category: ExpenseCategory.TAKEOUT,
    title: "Sushi Dinner",
    amount: 42.00,
    type: ExpenseType.EXPENSE,
    dateTime: DateTime.now(),
  ),
  Transaction(
    category: ExpenseCategory.ENTERTAINMENT,
    title: "Netflix Subscription",
    amount: 15.99,
    type: ExpenseType.EXPENSE,
    dateTime: DateTime.now(),
  ),
  Transaction(
    category: ExpenseCategory.SHOPPING,
    title: "Winter Jacket",
    amount: 129.99,
    type: ExpenseType.EXPENSE,
    dateTime: DateTime.now(),
  ),
  Transaction(
    category: ExpenseCategory.TRAVEL,
    title: "Flight Tickets",
    amount: 450.00,
    type: ExpenseType.EXPENSE,
    dateTime: DateTime.now(),
  ),
  Transaction(
    category: ExpenseCategory.INVESTMENTS,
    title: "Stock Dividend",
    amount: 250.00,
    type: ExpenseType.INCOME,
    dateTime: DateTime.now(),
  ),
];
