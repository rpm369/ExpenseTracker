import 'package:expense_tracker/Models/ExpenseCategory.dart';
import 'package:expense_tracker/Utils/DateTimeUtils.dart';

class Transaction {
  ExpenseCategory _category;
  String _title;
  double _amount;
  ExpenseType _type;
  DateTime _dateTime;

  Transaction({
    required this._category,
    required this._title,
    required this._amount,
    required this._type,
    required this._dateTime,
  });

  ExpenseCategory get category => this._category;
  String get title => this._title;
  double get amount => this._amount;
  ExpenseType get type => this._type;
  String get dateTime =>
      this._dateTime.day.toString() +
      " " +
      DateTimeUtils.monthToString(nMonth: this._dateTime.month);

  set category(ExpenseCategory newCategory) => this._category = newCategory;
  set title(String newTitle) => this._title = newTitle;
  set amount(double newAmount) => this._amount = newAmount;
  set type(ExpenseType newType) => this._type = newType;
  set dateTime(DateTime newDateTime) => this._dateTime = newDateTime;
}
