import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stock_watchlist/data/models/stock.dart';
import 'package:stock_watchlist/data/repositories/watchlist_repository.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {

  final WatchListRepository _watchListRepository;

  WatchlistBloc(this._watchListRepository) : super(WatchListStocksState(_watchListRepository.fetchStocks().isEmpty ? WatchListStatus.empty : WatchListStatus.notEmpty, _watchListRepository.fetchStocks())) {
    on<WatchlistEvent>((event, emit) {});
    on<WatchlistAddEvent>(watchListAddEvent);
    on<WatchlistRemoveEvent>(watchListRemoveEvent);
  }

  Future<void> watchListAddEvent(WatchlistAddEvent stockAddEvent, Emitter emit) async {
    List<Stock> watchListStocks = _watchListRepository.addStock(stockAddEvent.stock);
    emit(WatchListStocksState(WatchListStatus.notEmpty, watchListStocks));
  }

  Future<void> watchListRemoveEvent(WatchlistRemoveEvent stockRemoveEvent, Emitter emit) async {
    List<Stock> watchListStocks = _watchListRepository.removeStock(stockRemoveEvent.companyName);
    if (watchListStocks.isEmpty) {
      emit(WatchListStocksState(WatchListStatus.empty, watchListStocks));
    } else {
       emit(WatchListStocksState(WatchListStatus.notEmpty, watchListStocks));
    }
   
  }
}
