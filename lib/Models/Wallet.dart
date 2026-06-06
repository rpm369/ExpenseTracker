import 'package:hive/hive.dart';

part 'Wallet.g.dart';

@HiveType(typeId: 1)
class Wallet extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double totalAmount;

  @HiveField(3)
  String? imageURL;

  Wallet({
    this.id,
    required this.title,
    required this.totalAmount,
    this.imageURL,
  });

  @override
  String toString() {
    return "$id - $title - $totalAmount - $imageURL";
  }
}
