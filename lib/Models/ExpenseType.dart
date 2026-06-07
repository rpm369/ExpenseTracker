import 'package:hive/hive.dart';

part 'ExpenseType.g.dart';

@HiveType(typeId: 4)
enum ExpenseType {
  @HiveField(0)
  INCOME(id: "Income"),
  @HiveField(1)
  EXPENSE(id: "Expense");

  final String id;
  const ExpenseType({required this.id});
  factory ExpenseType.fromId(String id) {
    return ExpenseType.values.firstWhere(
      (value) => value.id == id,
      orElse: () => INCOME,
    );
  }

  static List<String> idList() {
    return values.map((constants) => constants.id).toList();
  }
}
