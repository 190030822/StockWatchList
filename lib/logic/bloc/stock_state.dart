part of 'stock_bloc.dart';

enum SearchStatus {empty, loading, loaded, notFound}

enum LatestPriceStatus {loading, fetched}


@immutable
sealed class StockState {}

final class StockInitial extends StockState {}

final class StockListenerState extends StockState {}

final class StockSearchState extends StockState {
  final List<Stock>? stocks;
  final SearchStatus status;
  StockSearchState(this.status, {this.stocks});
}

final class FetchLatestStockPrice extends StockState {
  final String price;
  final String companyName;
  final LatestPriceStatus latestPriceStatus;
  FetchLatestStockPrice(this.price, this.companyName, this.latestPriceStatus);
}


