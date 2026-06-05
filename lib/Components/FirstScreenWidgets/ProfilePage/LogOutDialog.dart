import 'package:expense_tracker/Services/AuthService.dart';
import 'package:flutter/material.dart';

class LogOutDialog extends StatelessWidget {
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    Color surface = Theme.of(context).colorScheme.surface;

    return ValueListenableBuilder(
      valueListenable: isLoading,
      builder: (_, _, _) {
        return AlertDialog(
          backgroundColor: surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(15),
          ),
          titlePadding: EdgeInsets.all(10),
          contentPadding: EdgeInsets.all(10),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: EdgeInsets.only(bottom: 15),
          title: (isLoading.value)
              ? null
              : _buildText(
                  title: "Confirm",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
          content: (isLoading.value)
              ? CircularProgressIndicator()
              : _buildText(
                  title: "Are you sure you want to Logout ?",
                  fontSize: 15,
                ),
          actions: (isLoading.value) ? null : _buildButtons(context: context),
        );
      },
    );
  }

  List<Widget> _buildButtons({required BuildContext context}) {
    return [
      _buildActionButton(
        title: "No",
        color: Colors.red,
        onTap: () => Navigator.pop(context, false),
      ),
      _buildActionButton(
        title: "Yes",
        color: Colors.lightGreenAccent,
        onTap: () async {
          isLoading.value = true;
          bool successStatus = await AuthService.logOut();
          if (successStatus)
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          else
            Navigator.pop(context);
        },
      ),
    ];
  }

  Widget _buildActionButton({
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return TextButton(
      onPressed: onTap,
      child: Text(title, style: TextStyle(fontSize: 20, color: color)),
    );
  }

  Widget _buildText({
    required String title,
    required double fontSize,
    FontWeight? fontWeight,
  }) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
