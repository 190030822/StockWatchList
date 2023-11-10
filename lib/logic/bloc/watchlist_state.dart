part of 'watchlist_bloc.dart';

enum WatchListStatus {notEmpty, empty}

@immutable
sealed class WatchlistState {}

final class WatchlistInitial extends WatchlistState {}

final class WatchListStocksState extends WatchlistState {
  final WatchListStatus watchListStatus;
  final List<NewStock> watchListStocks;
  WatchListStocksState(this.watchListStatus, this.watchListStocks);
}

