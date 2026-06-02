import 'package:expense_tracker/Models/ExpenseCategory.dart';
import 'package:flutter/material.dart';

class CategoryVisuals {
  IconData icon;
  Color color;

  CategoryVisuals({required this.icon, required this.color});
}

final Map<ExpenseCategory, CategoryVisuals> categoryRegistry = {
  ExpenseCategory.UTILITIES: CategoryVisuals(
    color: Colors.amber,
    icon: Icons.lightbulb,
  ),
  ExpenseCategory.TRANSPORTATION: CategoryVisuals(
    color: Colors.teal,
    icon: Icons.emoji_transportation_rounded,
  ),
  ExpenseCategory.HEALTH: CategoryVisuals(
    color: Colors.red,
    icon: Icons.favorite,
  ),
  ExpenseCategory.LOAN: CategoryVisuals(
    color: Colors.blue,
    icon: Icons.local_atm_rounded,
  ),
  ExpenseCategory.GROCERIES: CategoryVisuals(
    color: Colors.lightGreenAccent,
    icon: Icons.local_grocery_store_rounded,
  ),
  ExpenseCategory.TAKEOUT: CategoryVisuals(
    color: Colors.cyan,
    icon: Icons.takeout_dining,
  ),
  ExpenseCategory.ENTERTAINMENT: CategoryVisuals(
    color: Colors.purple,
    icon: Icons.movie_filter_sharp,
  ),
  ExpenseCategory.SHOPPING: CategoryVisuals(
    color: Colors.deepPurple,
    icon: Icons.shopping_bag,
  ),
  ExpenseCategory.TRAVEL: CategoryVisuals(
    color: Colors.deepOrange,
    icon: Icons.travel_explore,
  ),
  ExpenseCategory.INVESTMENTS: CategoryVisuals(
    color: Colors.green,
    icon: Icons.attach_money_outlined,
  ),
};
