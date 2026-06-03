import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/StatsPage/StatsPage.dart';
import 'package:expense_tracker/Models/Transaction.dart';
import 'package:expense_tracker/Models/ExpenseCategory.dart';
import 'package:expense_tracker/Utils/DateTimeUtils.dart';

class StatsChart extends StatelessWidget {
  final List<Transaction> transactions;
  final StatsPeriod period;

  const StatsChart({
    super.key,
    required this.transactions,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final List<BarChartGroupData> barGroups = [];
    double maxVal = 0;
    final List<String> bottomLabels = [];

    if (period == StatsPeriod.weekly) {
      final List<DateTime> last7Days = List.generate(7, (index) {
        return now.subtract(Duration(days: index));
      });
      const List<String> weekdayNames = [
        "Mon",
        "Tue",
        "Wed",
        "Thu",
        "Fri",
        "Sat",
        "Sun",
      ];

      for (int i = 0; i < 7; i++) {
        final DateTime day = last7Days[i];
        double incomeSum = 0;
        double expenseSum = 0;

        for (final transaction in transactions) {
          if (transaction.dateTime.year == day.year &&
              transaction.dateTime.month == day.month &&
              transaction.dateTime.day == day.day) {
            if (transaction.type == ExpenseType.INCOME) {
              incomeSum += transaction.amount;
            } else {
              expenseSum += transaction.amount;
            }
          }
        }

        if (incomeSum > maxVal) maxVal = incomeSum;
        if (expenseSum > maxVal) maxVal = expenseSum;

        final double displayIncome = incomeSum > 0 ? incomeSum : 1.5;
        final double displayExpense = expenseSum > 0 ? expenseSum : 1.5;

        barGroups.add(
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: displayIncome,
                color: const Color(0xFF8DE34B),
                width: 8,
                borderRadius: BorderRadius.circular(4),
              ),
              BarChartRodData(
                toY: displayExpense,
                color: const Color(0xFFFF5252),
                width: 8,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        );

        bottomLabels.add(weekdayNames[day.weekday - 1]);
      }
    } else if (period == StatsPeriod.monthly) {
      // Group into 4 weeks: Wk 0 (this week), Wk 1 (last week), etc.
      for (int i = 0; i < 4; i++) {
        final startDay = i * 7;
        final endDay = (i + 1) * 7 - 1;

        double incomeSum = 0;
        double expenseSum = 0;

        for (final transaction in transactions) {
          final difference = now.difference(transaction.dateTime).inDays;
          if (difference >= startDay && difference <= endDay) {
            if (transaction.type == ExpenseType.INCOME) {
              incomeSum += transaction.amount;
            } else {
              expenseSum += transaction.amount;
            }
          }
        }

        if (incomeSum > maxVal) maxVal = incomeSum;
        if (expenseSum > maxVal) maxVal = expenseSum;

        final double displayIncome = incomeSum > 0 ? incomeSum : 1.5;
        final double displayExpense = expenseSum > 0 ? expenseSum : 1.5;

        barGroups.add(
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: displayIncome,
                color: const Color(0xFF8DE34B),
                width: 14,
                borderRadius: BorderRadius.circular(4),
              ),
              BarChartRodData(
                toY: displayExpense,
                color: const Color(0xFFFF5252),
                width: 14,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        );

        bottomLabels.add(i == 0
            ? "This Wk"
            : i == 1
                ? "Last Wk"
                : "Wk -${i}");
      }
    } else {
      // Yearly: 12 months going backwards (index 0: this month)
      for (int i = 0; i < 12; i++) {
        int targetMonth = now.month - i;
        int targetYear = now.year;
        while (targetMonth <= 0) {
          targetMonth += 12;
          targetYear -= 1;
        }

        double incomeSum = 0;
        double expenseSum = 0;

        for (final transaction in transactions) {
          if (transaction.dateTime.year == targetYear &&
              transaction.dateTime.month == targetMonth) {
            if (transaction.type == ExpenseType.INCOME) {
              incomeSum += transaction.amount;
            } else {
              expenseSum += transaction.amount;
            }
          }
        }

        if (incomeSum > maxVal) maxVal = incomeSum;
        if (expenseSum > maxVal) maxVal = expenseSum;

        final double displayIncome = incomeSum > 0 ? incomeSum : 1.5;
        final double displayExpense = expenseSum > 0 ? expenseSum : 1.5;

        barGroups.add(
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: displayIncome,
                color: const Color(0xFF8DE34B),
                width: 5,
                borderRadius: BorderRadius.circular(3),
              ),
              BarChartRodData(
                toY: displayExpense,
                color: const Color(0xFFFF5252),
                width: 5,
                borderRadius: BorderRadius.circular(3),
              ),
            ],
          ),
        );

        bottomLabels.add(DateTimeUtils.monthToString(nMonth: targetMonth));
      }
    }

    double calculatedMaxY = maxVal * 1.15;
    if (calculatedMaxY < 50.0) {
      calculatedMaxY = 50.0;
    }

    return Container(
      padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: calculatedMaxY,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => Colors.grey.shade900,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final String type = rodIndex == 0 ? "Income" : "Expense";
                final double value = rod.toY == 1.5 ? 0.0 : rod.toY;
                return BarTooltipItem(
                  '$type\n\$${value.toStringAsFixed(2)}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 45,
                interval: calculatedMaxY / 3,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    meta: meta,
                    space: 8,
                    child: Text(
                      '\$${value.toInt()}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  final int index = value.toInt();
                  if (index >= 0 && index < bottomLabels.length) {
                    return SideTitleWidget(
                      meta: meta,
                      space: 6,
                      child: Text(
                        bottomLabels[index],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: false,
            horizontalInterval: calculatedMaxY / 3,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withAlpha(25),
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(show: false),
          barGroups: barGroups,
        ),
      ),
    );
  }
}
