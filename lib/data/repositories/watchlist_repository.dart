import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_watchlist/data/models/new_stock.dart';
import 'package:stock_watchlist/data/models/stock.dart';

class WatchListRepository {

  final _watchListBox = Hive.box('WatchList');
  final _newWatchListBox = Hive.box('NewWatchList');

  List<NewStock> addStock(NewStock stock) {
    _newWatchListBox.put(stock.companyName, stock);
    return fetchStocks();

  }

  List<NewStock> removeStock(String companyName) {
    _newWatchListBox.delete(companyName);
    return fetchStocks();
  }


  List<NewStock> convertToStockType(List<dynamic> stockValues) {
    return stockValues.map((e) => e as NewStock).toList();
  }

  List<NewStock> fetchStocks() {
    return convertToStockType(_newWatchListBox.values.toList());
  }
}