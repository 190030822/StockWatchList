import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_watchlist/core/constannts.dart';
import 'package:stock_watchlist/data/models/new_stock.dart';
import 'package:stock_watchlist/data/models/stock.dart';
import 'package:stock_watchlist/logic/bloc/stock_bloc.dart';
import 'package:stock_watchlist/logic/bloc/watchlist_bloc.dart';

class WatchListScreeen extends StatefulWidget {
  const WatchListScreeen({super.key});

  @override
  State<WatchListScreeen> createState() => _WatchListScreeenState();
}

class _WatchListScreeenState extends State<WatchListScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Watch List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<WatchlistBloc, WatchlistState>(
          buildWhen: (previous, current) => current is WatchListStocksState,
          builder: (context, state) {
            WatchListStocksState watchListStocksState =
                state as WatchListStocksState;
            switch (watchListStocksState.watchListStatus) {
              case WatchListStatus.notEmpty:
                {
                  return SingleChildScrollView(
                    child: Table(
                      border: TableBorder.all(color: Colors.blue),
                      children: [
                        const TableRow(
                            decoration: BoxDecoration(color: Colors.blueGrey),
                            children: [
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Comp Name"),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Stock Price"),
                                ),
                              ),
                              TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Remove"),
                                  ))
                            ]),
                        ...List.generate(
                          watchListStocksState.watchListStocks.length, (index) {
                          NewStock currentStock =
                              watchListStocksState.watchListStocks[index];
                          context.read<StockBloc>().add(FetchLatestStockPriceEvent(currentStock.companyName));
                          return TableRow(children: [
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(currentStock.companyName),
                                )),
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                    child: Text(currentStock.symbol),
                                  // child: BlocConsumer<StockBloc, StockState>(
                                  //   listenWhen: (previous, current) {
                                  //     if (current.runtimeType == FetchLatestStockPrice) {
                                  //       FetchLatestStockPrice fetchLatestStockPrice = current as FetchLatestStockPrice;
                                  //       if (fetchLatestStockPrice.companyName == currentStock.companyName && fetchLatestStockPrice.latestPriceStatus == LatestPriceStatus.fetched && fetchLatestStockPrice.price == "lmt excceded") {
                                  //         return true;
                                  //       }
                                  //     }
                                  //     return false;
                                  //   },
                                  //   buildWhen: (previous, current) {
                                  //    if(current.runtimeType == FetchLatestStockPrice) {
                                  //     FetchLatestStockPrice fetchLatestStockPrice = current as FetchLatestStockPrice;
                                  //     if (fetchLatestStockPrice.companyName == currentStock.companyName) {
                                  //       return true;
                                  //     } return false;
                                  //    } 
                                  //    return false;
                                  //   },
                                  //   listener: (context, state1) {
                                  //     if (state1.runtimeType == FetchLatestStockPrice) {
                                  //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(perMinuteLimit)));
                                  //     }
                                  //   },
                                  //   builder: (context, state1) {
                                  //     switch(state1.runtimeType) {
                                  //       case StockSearchState:  {
                                  //         return Text(currentStock.symbol);
                                  //       }
                                  //       case FetchLatestStockPrice: {
                                  //         FetchLatestStockPrice fetchLatestStockPrice = state1 as FetchLatestStockPrice;
                                  //         switch(fetchLatestStockPrice.latestPriceStatus) {
                                  //           case LatestPriceStatus.loading: return Transform.scale(scale: 0.5, child: const Center(child: CircularProgressIndicator(strokeWidth: 4,)));
                                  //           case LatestPriceStatus.fetched: {
                                  //             if (fetchLatestStockPrice.companyName == currentStock.companyName) {
                                  //               return Text(fetchLatestStockPrice.price);
                                                
                                  //             } else {
                                  //               return Text(currentStock.symbol);
                                  //             }  
                                  //           } 
                                  //         }
                                  //       }
                                  //       default: return Text(currentStock.symbol);
                                  //     }
                                  //   },
                                  // ),
                                )),
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {context
                                        .read<WatchlistBloc>()
                                        .add(WatchlistRemoveEvent(
                                            currentStock.companyName));
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${currentStock.companyName} removed successfully")));
                                    },
                                    child: const Icon(Icons.remove_circle, color: Colors.red,),
                                  ),
                                ))
                          ]);
                        }),
                      ],
                    ),
                  );
                }
              case WatchListStatus.empty:
                return const Center(child: Text("No Stocks in WatchList"));
            }
          },
        ),
      ),
    );
  }
}
