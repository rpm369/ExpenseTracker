import 'package:hive/hive.dart';

part 'User.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String userEmail;

  @HiveField(1)
  String? userName;

  @HiveField(2)
  String userPassword;

  User({required this.userEmail, this.userName, required this.userPassword});
}
