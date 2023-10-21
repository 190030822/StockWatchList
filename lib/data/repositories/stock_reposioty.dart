import 'package:stock_watchlist/core/constannts.dart';
import 'package:stock_watchlist/data/models/stock.dart';
import 'package:stock_watchlist/data/services/stock_service.dart';

class StockRepository {

  Future<List<Stock>> searchStocksByQuery(String query) async {
    List<String> companies = await searchStocks(query);
    List<Stock> stocks = [];
    String stockValue;  
    if (companies.length == 1 && companies[0] == perDayLimit) {
     stocks.add(Stock("error", perDayLimit));
     return stocks;
    }
    int limit = companies.length > 5 ? 5 : companies.length;
    for (var i = 0; i < limit; i++) {
      stockValue = await fetchStockPrices(companies[i]);
      if (stockValue == "error") {
        stockValue == "lmt excceded";
      }
      if (stockValue != "lmt excceded") {
        stocks.add(Stock(companies[i], stockValue));
      } 
    }
    if (companies.isNotEmpty && stocks.isEmpty) {
      stocks.add(Stock("error", perMinuteLimit));
    }
    return stocks;
  }

  Future<String> getLatestStockPrice(String companyName) async {
    String stockPrice = await fetchStockPrices(companyName);
    return stockPrice;
  }

}