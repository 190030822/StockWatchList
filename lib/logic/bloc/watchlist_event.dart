part of 'watchlist_bloc.dart';

@immutable
sealed class WatchlistEvent {}

class WatchlistAddEvent extends WatchlistEvent {
  final Stock stock;
  WatchlistAddEvent(this.stock);
}

class WatchlistRemoveEvent extends WatchlistEvent {
  final String companyName;
  WatchlistRemoveEvent(this.companyName);
}
