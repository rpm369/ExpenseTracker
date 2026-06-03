import 'package:flutter/material.dart';

class ModExpansionTile extends StatelessWidget {
  List<String>? children;
  void Function(String) callBack;
  EdgeInsetsGeometry? padding;

  ModExpansionTile({this.padding, this.children, required this.callBack})
    : selectedElement = ValueNotifier(
        (children == null || children!.isEmpty) ? "Nill" : children![0],
      ),
      controller = ExpansibleController() {
    callBack(selectedElement.value);
  }

  late ValueNotifier<String> selectedElement;
  late ExpansibleController controller;

  void changeSelectedElement(String element) {
    selectedElement.value = element;
    callBack(element);
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
        children: _buildChildren() ?? [],
      ),
    );
  }

  List<Widget>? _buildChildren() {
    return children
        ?.map(
          (element) => ListTile(
            title: Text(element),
            onTap: () => changeSelectedElement(element),
          ),
        )
        .toList();
  }

  Widget _buildText() {
    return ValueListenableBuilder(
      valueListenable: selectedElement,
      builder: (_, selectedElement, _) {
        return Text(selectedElement, style: TextStyle(fontSize: 20));
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
