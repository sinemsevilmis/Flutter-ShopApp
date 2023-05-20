import 'package:hive/hive.dart';
part 'product.g.dart';

@HiveType(typeId: 0)
class Product{
  @HiveField(0)
  final String productName;
  @HiveField(1)
  final String productImageUrl;
  @HiveField(2)
  final String currentPrice;
  @HiveField(3)
  final String oldPrice;
  @HiveField(4)
  final bool isLiked;

  Product({
    required this.productName,
    required this.productImageUrl,
    required this.currentPrice,
    required this.oldPrice,
    required this.isLiked,
  });
}
