import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_watchlist/core/routes/app_route.dart';
import 'package:stock_watchlist/core/themes/app_theme.dart';
import 'package:stock_watchlist/data/models/stock.dart';
import 'package:stock_watchlist/data/repositories/stock_reposioty.dart';
import 'package:stock_watchlist/data/repositories/watchlist_repository.dart';
import 'package:stock_watchlist/logic/bloc/stock_bloc.dart';
import 'package:stock_watchlist/logic/bloc/watchlist_bloc.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  
  await Hive.initFlutter();
  Hive.registerAdapter(StockAdapter());
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox('WatchList');
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => StockRepository()),
        RepositoryProvider(create: (context) => WatchListRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => StockBloc(context.read<StockRepository>())),
          BlocProvider(create: (context) => WatchlistBloc(context.read<WatchListRepository>()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          onGenerateRoute: _appRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
