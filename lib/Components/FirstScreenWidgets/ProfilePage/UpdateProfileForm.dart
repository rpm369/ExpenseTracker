import 'package:expense_tracker/Components/FirstScreenWidgets/ProfilePage/EditNameField.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/FormHeader.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/ProfilePage/AvatarModifier.dart';
import 'package:expense_tracker/Models/User.dart';
import 'package:expense_tracker/Services/UserService.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfileForm extends StatefulWidget {
  @override
  State<UpdateProfileForm> createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  FocusNode nameNode = FocusNode();

  bool isLoading = false;
  late User user;

  @override
  void initState() {
    super.initState();
    User activeUser = context.read<UserService>().getActiveUser();
    user = User(
      userEmail: activeUser.userEmail,
      userPassword: activeUser.userPassword,
      imageURL: activeUser.imageURL,
      userName: activeUser.userName,
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: EdgeInsets.all(15),
      child: (isLoading)
          ? Center(child: CircularProgressIndicator(color: Colors.blue))
          : Provider(create: (_) => user, child: _buildForm()),
    );
  }

  Widget _buildForm() {
    Color primary = Theme.of(context).colorScheme.primary;
    return Form(
      key: formKey,
      child: Column(
        children: [
          FormHeader(title: "Update Profile"),
          SizedBox(height: 30),
          AvatarModifier(),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: [_buildNameModifier(context: context)],
            ),
          ),
          UiUtils.formFooter(
            context: context,
            child: UiUtils.formButton(
              primary: primary,
              title: "Update",
              onTap: submissionFunction,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> submissionFunction() async {
    if (isLoading || !formKey.currentState!.validate()) return;
    if (nameNode.hasFocus) nameNode.unfocus();

    setState(() {
      isLoading = true;
    });

    bool successStatus = await context.read<UserService>().updateUser(
      user: user,
    );

    setState(() {
      isLoading = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (successStatus == true) Navigator.pop(context);
    });
  }

  Widget _buildNameModifier({required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text("Name", style: TextStyle(fontSize: 22)),
        EditNameField(node: nameNode),
      ],
    );
  }
}
