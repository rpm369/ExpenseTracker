enum ExpenseCategory {
  UTILITIES(id: "Utilities"),
  TRANSPORTATION(id: "Transportation"),
  HEALTH(id: "Health"),
  LOAN(id: "Loan"),
  GROCERIES(id: "Groceries"),
  TAKEOUT(id: "Takeout"),
  ENTERTAINMENT(id: "Entertainment"),
  SHOPPING(id: "Shopping"),
  TRAVEL(id: "Travel"),
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

enum ExpenseType {
  INCOME(id: "Income"),
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
