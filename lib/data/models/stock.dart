
import 'package:hive_flutter/hive_flutter.dart';
part 'stock.g.dart';

@HiveType(typeId: 1)
class Stock {

  @HiveField(1)
  final String companyName;
  @HiveField(2)
  final String stockPrice;

  Stock(this.companyName, this.stockPrice);
}