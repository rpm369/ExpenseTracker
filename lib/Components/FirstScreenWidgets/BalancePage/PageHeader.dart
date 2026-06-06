import 'package:expense_tracker/Services/WalletServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageHeader extends StatefulWidget {
  @override
  State<PageHeader> createState() => PageHeaderState();
}

class PageHeaderState extends State<PageHeader> {
  double? totalBalance;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    totalBalance = null;
    context.watch<WalletServices>().getTotalBalance().then(
      (value) => setState(() {
        totalBalance = value;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color surface = Theme.of(context).colorScheme.surface;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: surface),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          (totalBalance == null)
              ? Center(child: CircularProgressIndicator(color: Colors.blue))
              : _commonTextWidget(
                  title: "\$ ${totalBalance!.toStringAsFixed(2)}",
                  textSize: 50,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.grey,
                ),
          _commonTextWidget(
            title: "Total Balance",
            textSize: 15,
            textColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _commonTextWidget({
    required String title,
    Color? textColor,
    required double textSize,
    double? letterSpacing,
    FontWeight? fontWeight,
  }) {
    return Text(
      title,
      style: TextStyle(
        height: 1,
        color: textColor,
        fontSize: textSize,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight,
      ),
    );
  }
}
