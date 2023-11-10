import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:stock_watchlist/core/constannts.dart';
import 'package:stock_watchlist/data/models/new_stock.dart';

const List<String> apiKey =  ['TGRATIJYEEDPWUU2','Q6C17DR08AAV2ED8','7O59LV9IVKLKR875','47QARI5VNWFASDVI','CSY7K599MT8RGWPY', 'P2KDK5UZJFLJC1NL', 'IN5QGNT3R6YDGX23', 'VDX5HDGZ0NEI2C4P', '5BUPMX78BSVPDRNI', 'FCAXPQDP3P1J81YQ', 'D8CD5R3LIORBHX66', '3MQZEZND57NVJ9LC', 'UP1UTI3TT177ECKF', '1NEQ2YWDZ3OJVM2V', '4SZNCL3MOPM4WVE7', 'MXJ8M64EXIKOVUTW'];
const baseUrl = "https://www.alphavantage.co";
const interval = 1;
var index = -1;

Future<List<String>> searchStocks(String query) async {
  final Uri uri = Uri.parse('$baseUrl/query?function=SYMBOL_SEARCH&keywords=$query&apikey=${apiKey[getIndex()]}');
  final response = await http.get(
    uri,
    headers: {
      "Content-Type": "application/json"
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    List<String> symbols = [];
    if (data['bestMatches'] == null) {
      symbols.add(perDayLimit);
      return symbols;
    }
    for (var result in data['bestMatches']) {
      symbols.add(result['1. symbol']);
    }
    return symbols;
  } else {
    throw Exception('Failed to load stock symbols');
  }
}

Future<String> fetchStockPrices(String symbol) async {
  final Uri uri = Uri.parse('$baseUrl/query?function=TIME_SERIES_INTRADAY&symbol=$symbol&interval=${interval}min&apikey=${apiKey[getIndex()]}');
  final response = await http.get(uri, headers: {
     "Content-Type": "application/json"
  });

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['Time Series (${interval}min)'] != null) {
      return data['Time Series (${interval}min)'][data['Meta Data']['3. Last Refreshed']]['4. close'];
    } else {
      return "lmt excceded";
    }
  } else {
    throw Exception('Failed to load stock prices');
  }
}

FutureOr<List<NewStock>> getStocksBySearch(String query) async{
  final Uri uri = Uri.parse('https://dev.portal.tradebrains.in/api/search?keyword=$query');
  final response = await http.get(
    uri,
    headers: {
      "Content-Type": "application/json"
    },
  );
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    List<NewStock> result = [];
    for (dynamic entity in data) {
      result.add(NewStock.fromJson(entity));
    }
    return result;
  } else {
    throw Exception('Error ${response.statusCode}');
  }
}

int getIndex() {
  index = (index+1)%apiKey.length;
  return index;
}


