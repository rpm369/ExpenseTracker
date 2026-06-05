import 'package:expense_tracker/Models/ExpenseCategory.dart';

class Transaction {
  int? _id;
  ExpenseCategory _category;
  String _title;
  double _amount;
  ExpenseType _type;
  DateTime _dateTime;

  Transaction({
    this._id,
    required this._category,
    required this._title,
    required this._amount,
    required this._type,
    required this._dateTime,
  });

  int? get id => this._id;
  ExpenseCategory get category => this._category;
  String get title => this._title;
  double get amount => this._amount;
  ExpenseType get type => this._type;
  DateTime get dateTime => this._dateTime;

  set id(int newId) => id;
  set category(ExpenseCategory newCategory) => this._category = newCategory;
  set title(String newTitle) => this._title = newTitle;
  set amount(double newAmount) => this._amount = newAmount;
  set type(ExpenseType newType) => this._type = newType;
  set dateTime(DateTime newDateTime) => this._dateTime = newDateTime;
}
