import 'package:expense_tracker/Models/ExpenseCategory.dart';
import 'package:expense_tracker/Models/ExpenseType.dart';
import 'package:hive/hive.dart';

part 'Transaction.g.dart';

@HiveType(typeId: 2)
class Transaction extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  ExpenseCategory category;

  @HiveField(2)
  String title;

  @HiveField(3)
  double amount;

  @HiveField(4)
  ExpenseType type;

  @HiveField(5)
  DateTime dateTime;

  @HiveField(6)
  int walletId;

  Transaction({
    this.id,
    required this.category,
    required this.title,
    required this.amount,
    required this.type,
    required this.dateTime,
    required this.walletId,
  });

  @override
  String toString() {
    return "$id - ${category.id} - ${title} - ${amount} - ${type} - ${dateTime} - $walletId";
  }
}
