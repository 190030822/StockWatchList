import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_watchlist/logic/bloc/stock_bloc.dart';
import 'package:stock_watchlist/ui/widgets/stock_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController searchController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Trade Brains"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
          child: Column(
            children : [
              Material(
                elevation: 5,
                shadowColor: Colors.blueGrey,
                borderRadius: BorderRadius.circular(25.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText:  "Search based on company name ",
                    prefixIcon: const Icon(Icons.search, color: Colors.black,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none
                    ),
                  ),
                  onChanged: (value) {
                    context.read<StockBloc>().onSearch(value, () {
                      context.read<StockBloc>().add(StockSearchEvent(value));
                    });
                  },
                  
                ),
              ),
              Expanded(
                child: BlocBuilder<StockBloc, StockState>(
                  buildWhen: (previous, current) => current is StockSearchState,
                  builder: (context, state) {
                    switch(state.runtimeType) {
                      case StockSearchState: {
                        StockSearchState stockSearchState = state as StockSearchState;
                        switch(stockSearchState.status) {
                          case SearchStatus.loaded: {
                            return ListView.builder(
                                itemBuilder: (context, index) => StockItem(stockSearchState.stocks![index]),
                                itemCount: stockSearchState.stocks!.length,
                              
                            );
                          }
                          case SearchStatus.loading: {
                            return const Center(child: CircularProgressIndicator());
                          }
                          case SearchStatus.notFound: {
                            return const Center(child: Text("No Stocks Found"));
                          }
                          case SearchStatus.empty: {
                            return const Center(child: Text("Search ... (type atleast two characters)"));
                          }
                        }
                      }
                      default:  return const Center(child: Text("Search ... (type atleast two characters)"));
                    }
                    
                  },
                ),
              ),
            ],
          ),
        )
      ),
    );

  }
}