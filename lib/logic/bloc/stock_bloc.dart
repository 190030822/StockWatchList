import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stock_watchlist/core/utils/utilities.dart';
import 'package:stock_watchlist/data/models/new_stock.dart';
import 'package:stock_watchlist/data/models/stock.dart';
import 'package:stock_watchlist/data/repositories/stock_reposioty.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {

  final StockRepository stockRepository;

  StockBloc(this.stockRepository) : super(StockSearchState(SearchStatus.empty)) {
    on<StockSearchEvent>(stockSearchFunction);
    on<FetchLatestStockPriceEvent>(fetchLatestStockPriceEvent);
  }


  Future<void> stockSearchFunction(StockSearchEvent stockSearchEvent, Emitter emit) async{
    if (stockSearchEvent.query.length <= 1) {
      emit(StockSearchState(SearchStatus.empty));
    } else {
      emit(StockSearchState(SearchStatus.loading));
      List<NewStock> stocks = await stockRepository.searchNewStocksByQuery(stockSearchEvent.query);
    if (stocks.isEmpty) {
      emit(StockSearchState(SearchStatus.notFound));
    } else {
      emit(StockSearchState(SearchStatus.loaded, stocks: stocks));
    }
    }
  }

  Future<void> fetchLatestStockPriceEvent(FetchLatestStockPriceEvent fetchLatestStockPriceEvent, Emitter emit) async {
    emit(FetchLatestStockPrice("", fetchLatestStockPriceEvent.companyName, LatestPriceStatus.loading));
    String stockPrice = await stockRepository.getLatestStockPrice(fetchLatestStockPriceEvent.companyName);
    emit(FetchLatestStockPrice(stockPrice, fetchLatestStockPriceEvent.companyName, LatestPriceStatus.fetched));
  }


  void onSearch(String value, dynamic Function() callback) {
    debounce(value, callback);
  }
}
