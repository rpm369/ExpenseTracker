// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExpenseCategory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseCategoryAdapter extends TypeAdapter<ExpenseCategory> {
  @override
  final int typeId = 3;

  @override
  ExpenseCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExpenseCategory.UTILITIES;
      case 1:
        return ExpenseCategory.TRANSPORTATION;
      case 2:
        return ExpenseCategory.HEALTH;
      case 3:
        return ExpenseCategory.LOAN;
      case 4:
        return ExpenseCategory.GROCERIES;
      case 5:
        return ExpenseCategory.TAKEOUT;
      case 6:
        return ExpenseCategory.ENTERTAINMENT;
      case 7:
        return ExpenseCategory.SHOPPING;
      case 8:
        return ExpenseCategory.TRAVEL;
      case 9:
        return ExpenseCategory.INVESTMENTS;
      default:
        return ExpenseCategory.UTILITIES;
    }
  }

  @override
  void write(BinaryWriter writer, ExpenseCategory obj) {
    switch (obj) {
      case ExpenseCategory.UTILITIES:
        writer.writeByte(0);
        break;
      case ExpenseCategory.TRANSPORTATION:
        writer.writeByte(1);
        break;
      case ExpenseCategory.HEALTH:
        writer.writeByte(2);
        break;
      case ExpenseCategory.LOAN:
        writer.writeByte(3);
        break;
      case ExpenseCategory.GROCERIES:
        writer.writeByte(4);
        break;
      case ExpenseCategory.TAKEOUT:
        writer.writeByte(5);
        break;
      case ExpenseCategory.ENTERTAINMENT:
        writer.writeByte(6);
        break;
      case ExpenseCategory.SHOPPING:
        writer.writeByte(7);
        break;
      case ExpenseCategory.TRAVEL:
        writer.writeByte(8);
        break;
      case ExpenseCategory.INVESTMENTS:
        writer.writeByte(9);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
