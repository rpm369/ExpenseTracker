import 'package:expense_tracker/Components/FirstScreenWidgets/EditNameField.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/FormHeader.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/ProfilePage/AvatarModifier.dart';
import 'package:expense_tracker/Models/Wallet.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';

class UpdateProfileForm extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();

  Wallet wallet = Wallet(title: "Gautam Jangid", totalAmount: 300);

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            FormHeader(title: "Update Profile"),
            SizedBox(height: 30),
            AvatarModifier(callBack: (file) => print(file.path)),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: [_buildNameModifier(context: context)],
              ),
            ),
            UiUtils.formFooter(
              context: context,
              child: UiUtils.formButton(primary: primary, title: "Update"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameModifier({required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text("Name", style: TextStyle(fontSize: 22)),
        EditNameField(callBack: (newName) {}, existingText: wallet.title),
      ],
    );
  }
}
