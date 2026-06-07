class Validators {
  static bool _doesNotExist(String? value) {
    return (value == null || value.isEmpty);
  }

  static String? validateMail(String? value) {
    if (_doesNotExist(value)) return "Field is Required";
    if (!RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    ).hasMatch(value!)) {
      return "Incorrect email address !";
    }
    return null;
  }

  static String? validPassword(String? value) {
    if (_doesNotExist(value)) return "Field is Required";

    String validConditions = '''
Your password needs to be at least 6 characters long and include a mix of:
> At least one lowercase letter
> At least one uppercase letter
> At least one number
> At least one special character or symbol
''';

    if (!RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$',
    ).hasMatch(value!)) {
      return validConditions;
    }
    return null;
  }

  static String? validConformPassword(String? value, String originalPassword) {
    if (_doesNotExist(value)) return "Field is Required";

    if (value != originalPassword) return "Password Mismatch !";
    return null;
  }

  static String? requiredField(String? value) {
    if (_doesNotExist(value)) return "Field is Required";
    return null;
  }
}
