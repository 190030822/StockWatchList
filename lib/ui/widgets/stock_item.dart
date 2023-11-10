import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_watchlist/data/models/new_stock.dart';
import 'package:stock_watchlist/data/models/stock.dart';
import 'package:stock_watchlist/logic/bloc/watchlist_bloc.dart';

class StockItem extends StatefulWidget {
  final NewStock stock;
  const StockItem(this.stock, {super.key});

  @override
  State<StockItem> createState() => _StockItemState();
}

class _StockItemState extends State<StockItem> {

  bool isAdded = false;
  late bool isLimitExceeded;

  @override
  Widget build(BuildContext context) {
     bool isLimitExceeded = widget.stock.companyName == "error";
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Material(
        shadowColor: Colors.blueAccent,
        elevation: 2,
        borderRadius: BorderRadius.circular(10.0),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          leading: isLimitExceeded ? const Icon(Icons.error_outline_sharp, color: Colors.red) : null,
          title: isLimitExceeded ?  Text(widget.stock.companyName) : Text("${widget.stock.companyName} (Rs ${widget.stock.symbol})"),
          trailing:  InkWell(
            onTap: () {
              if (isAdded || isLimitExceeded) {
                null;
              } else {
                setState(() {
                   context.read<WatchlistBloc>().add(WatchlistAddEvent(widget.stock));
                   isAdded = true;
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${widget.stock.companyName} added to watchList")));
                }); 
              }
            },
            child: isLimitExceeded ? const Text("") : (isAdded ? const Icon(Icons.done, color: Colors.green,) : const Icon(Icons.add_circle, color: Colors.blue)),
          ),
        ),
      ),
    );
  }
}