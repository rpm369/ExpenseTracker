import 'package:expense_tracker/Models/Wallet.dart';
import 'package:flutter/material.dart';

class WalletExpensionTile extends StatelessWidget {
  List<Wallet> children;
  void Function(int) onWalletSelection;
  EdgeInsetsGeometry? padding;

  WalletExpensionTile({
    this.padding,
    required this.children,
    required this.onWalletSelection,
  }) : selectedElement = ValueNotifier((children.isEmpty) ? null : children[0]);

  late ValueNotifier<Wallet?> selectedElement;
  ExpansibleController controller = ExpansibleController();

  void changeSelectedElement(Wallet wallet) {
    selectedElement.value = wallet;
    onWalletSelection(selectedElement.value!.id!);
    controller.collapse();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: ExpansionTile(
        shape: _buildBorder(),
        collapsedShape: _buildBorder(),
        expansionAnimationStyle: AnimationStyle(
          curve: Curves.ease,
          duration: Duration(milliseconds: 300),
          reverseCurve: Curves.bounceIn,
          reverseDuration: Duration(milliseconds: 400),
        ),
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        iconColor: Colors.white,
        controller: controller,
        title: _buildText(),
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    return children
        .map(
          (wallet) => ListTile(
            title: Text(wallet.title),
            onTap: () => changeSelectedElement(wallet),
          ),
        )
        .toList();
  }

  Widget _buildText() {
    return ValueListenableBuilder(
      valueListenable: selectedElement,
      builder: (_, wallet, _) {
        return Text(
          wallet?.title ?? "No Wallet Found",
          style: TextStyle(fontSize: 20),
        );
      },
    );
  }

  RoundedRectangleBorder _buildBorder() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(15),
      side: BorderSide(width: 1, color: Colors.white),
    );
  }
}
