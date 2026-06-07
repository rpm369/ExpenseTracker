import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/SearchableList.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/StatsPage/StatsChart.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/TransactionList.dart';
import 'package:expense_tracker/Database/DummyTransactions.dart';
import 'package:expense_tracker/Models/Transaction.dart';
import 'package:expense_tracker/Models/ExpenseCategory.dart';
import 'package:expense_tracker/Services/TransactionServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum StatsPeriod { weekly, monthly, yearly }

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  bool isLoading = true;
  List<Transaction>? transactionList;

  StatsPeriod _selectedPeriod = StatsPeriod.weekly;

  List<Transaction> _getFilteredTransactions() {
    final DateTime now = DateTime.now();
    switch (_selectedPeriod) {
      case StatsPeriod.weekly:
        final limit = now.subtract(const Duration(days: 7));
        return transactionList!
            .where((tx) => tx.dateTime.isAfter(limit))
            .toList();
      case StatsPeriod.monthly:
        final limit = now.subtract(const Duration(days: 30));
        return transactionList!
            .where((tx) => tx.dateTime.isAfter(limit))
            .toList();
      case StatsPeriod.yearly:
        final limit = now.subtract(const Duration(days: 365));
        return transactionList!
            .where((tx) => tx.dateTime.isAfter(limit))
            .toList();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<TransactionServices>().fetchAllTransactions().then((list) {
      setState(() {
        isLoading = false;
        transactionList = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Transaction>? filteredData;
    if (!isLoading) filteredData = _getFilteredTransactions();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildHeader(context: context, displayText: "Statistics"),
        if (!isLoading) _buildSegmentControl(context),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: (!isLoading)
                    ? StatsChart(
                        transactions: filteredData!,
                        period: _selectedPeriod,
                      )
                    : Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      ),
              ),
              const SizedBox(height: 20),
              _listHeaderText(displayText: "Transactions"),
              const SizedBox(height: 10),
              (!isLoading)
                  ? SearchableList(data: filteredData!)
                  : Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSegmentControl(BuildContext context) {
    Color surface = Theme.of(context).colorScheme.surface;
    Color secondary = Theme.of(context).colorScheme.secondary;
    Color onSurface = Theme.of(context).colorScheme.onSurface;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: StatsPeriod.values.map((period) {
          final isSelected = period == _selectedPeriod;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPeriod = period;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? onSurface : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  period == StatsPeriod.weekly
                      ? "Weekly"
                      : period == StatsPeriod.monthly
                      ? "Monthly"
                      : "Yearly",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? surface : onSurface.withAlpha(150),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _listHeaderText({required String displayText}) {
    return Text(
      displayText,
      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      textAlign: TextAlign.start,
    );
  }

  Widget _buildHeader({
    required BuildContext context,
    required String displayText,
  }) {
    Color primary = Theme.of(context).colorScheme.primary;
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(color: primary),
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            displayText,
            style: TextStyle(
              fontSize: 30,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
