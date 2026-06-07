import 'package:hive/hive.dart';

part 'ExpenseCategory.g.dart';

@HiveType(typeId: 3)
enum ExpenseCategory {
  @HiveField(0)
  UTILITIES(id: "Utilities"),
  @HiveField(1)
  TRANSPORTATION(id: "Transportation"),
  @HiveField(2)
  HEALTH(id: "Health"),
  @HiveField(3)
  LOAN(id: "Loan"),
  @HiveField(4)
  GROCERIES(id: "Groceries"),
  @HiveField(5)
  TAKEOUT(id: "Takeout"),
  @HiveField(6)
  ENTERTAINMENT(id: "Entertainment"),
  @HiveField(7)
  SHOPPING(id: "Shopping"),
  @HiveField(8)
  TRAVEL(id: "Travel"),
  @HiveField(9)
  INVESTMENTS(id: "Investments");

  final String id;
  const ExpenseCategory({required this.id});

  factory ExpenseCategory.fromId(String id) {
    return ExpenseCategory.values.firstWhere(
      (value) => value.id == id,
      orElse: () => UTILITIES,
    );
  }
  static List<String> idList() {
    return values.map((constants) => constants.id).toList();
  }
}
