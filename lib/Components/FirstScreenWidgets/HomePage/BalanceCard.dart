import 'package:flutter/material.dart';

class StackedBalanceCard extends StatelessWidget {
  double totalIncome;
  double income;
  double expense;

  StackedBalanceCard({
    required this.totalIncome,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    // We define a standard width so the background cards scale down proportionately
    const double cardWidth = 350.0;
    const double cardHeight = 180.0;

    return SizedBox(
      width: cardWidth,
      height:
          cardHeight +
          20, // Extra height to account for the stacked cards underneath
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // 1. Bottom-most background card (Smallest)
          Positioned(
            top: 20,
            child: Container(
              width: cardWidth * 0.85,
              height: cardHeight,
              decoration: BoxDecoration(
                color: const Color(0xFF333333),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          // 2. Middle background card
          Positioned(
            top: 10,
            child: Container(
              width: cardWidth * 0.92,
              height: cardHeight,
              decoration: BoxDecoration(
                color: const Color(0xFF555555),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          // 3. Top Main Card (The one displaying info)
          Positioned(
            top: 0,
            child: Container(
              width: cardWidth,
              height: cardHeight,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header Row: Title and Menu Icon
                  const Text(
                    'Total Balance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "\$ ${totalIncome.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Income and Expense Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Income Section
                      _buildFinancialStat(
                        label: 'Income',
                        amount: '\$ ${income.toStringAsFixed(2)}',
                        amountColor: const Color(0xFF2E7D32), // Custom Green
                        icon: Icons.arrow_downward,
                      ),
                      // Expense Section
                      _buildFinancialStat(
                        label: 'Expense',
                        amount: '\$ ${expense.toStringAsFixed(2)}',
                        amountColor: const Color(0xFFC62828), // Custom Red
                        icon: Icons.arrow_upward,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build Income/Expense column layout
  Widget _buildFinancialStat({
    required String label,
    required String amount,
    required Color amountColor,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 10,
          backgroundColor: Colors.white,
          child: Icon(icon, size: 14, color: Colors.black),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              amount,
              style: TextStyle(
                color: amountColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
