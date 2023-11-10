import 'package:hive_flutter/hive_flutter.dart';
part 'new_stock.g.dart';

@HiveType(typeId: 2)
class NewStock {

  @HiveField(1)
  final String companyName;
  @HiveField(2)
  final String symbol;

  NewStock(this.companyName, this.symbol);

  static NewStock fromJson(dynamic json) {
    return NewStock(json['company'], json['symbol']);
  }
}