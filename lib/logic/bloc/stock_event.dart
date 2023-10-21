part of 'stock_bloc.dart';

@immutable
sealed class StockEvent {}

class StockSearchEvent extends StockEvent {
  final String query;
  StockSearchEvent(this.query);
}

class FetchLatestStockPriceEvent extends StockEvent {
  final String companyName;
  FetchLatestStockPriceEvent(this.companyName);
}