import 'package:hive/hive.dart';

part 'User.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String userEmail;

  @HiveField(1)
  String? userName;

  @HiveField(2)
  String userPassword;

  @HiveField(3)
  String? imageURL;

  User({
    required this.userEmail,
    this.userName,
    required this.userPassword,
    this.imageURL,
  });
}
