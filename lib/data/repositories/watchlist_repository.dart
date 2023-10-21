import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_watchlist/data/models/stock.dart';

class WatchListRepository {

  final _watchListBox = Hive.box('WatchList');

  List<Stock> addStock(Stock stock) {
    _watchListBox.put(stock.companyName, stock);
    return fetchStocks();

  }

  List<Stock> removeStock(String companyName) {
    _watchListBox.delete(companyName);
    return fetchStocks();
  }


  List<Stock> convertToStockType(List<dynamic> stockValues) {
    return stockValues.map((e) => e as Stock).toList();
  }

  List<Stock> fetchStocks() {
    return convertToStockType(_watchListBox.values.toList());
  }
}