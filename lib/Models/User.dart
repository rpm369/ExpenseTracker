class User {
  String _userEmail;
  String? _userName;
  String _userPassword;

  User({
    required this._userEmail,
    required this._userName,
    required this._userPassword,
  });

  set userEmail(String newEmail) => this._userEmail = newEmail;
  set userName(String newName) => this._userName = newName;
  set userPassword(String newPasswd) => this._userPassword = newPasswd;

  String get userEmail => this._userEmail;
  String? get userName => this._userName;
  String get userPasswd => this._userPassword;
}
