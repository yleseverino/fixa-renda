import 'package:fixa_renda/data/database.dart';
import 'package:fixa_renda/data/retrofit_services.dart';
import 'package:fixa_renda/ui/help/help_screen.dart';
import 'package:fixa_renda/ui/home/home_screen.dart';
import 'package:fixa_renda/ui/investment_item/investment_edit_screen.dart';
import 'package:fixa_renda/ui/investment_item/investment_item_entry_screen.dart';
import 'package:fixa_renda/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FixaRendaApp extends StatelessWidget {
  final AppDatabase appDatabase;
  final RetrofitServices retrofitServices;

  const FixaRendaApp(
      {super.key, required this.appDatabase, required this.retrofitServices});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDatabase>(
          create: (context) => appDatabase,
        ),
        Provider<RetrofitServices>(
          create: (context) => retrofitServices,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: getThemeData(context, true),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
        routes: <String, WidgetBuilder>{
          InvestmentItemEditScreen.routeName: (BuildContext context) =>
              const InvestmentItemEditScreen(),
          HelpScreen.routeName: (BuildContext context) => const HelpScreen(),
          InvestmentItemEntryScreen.routeName: (BuildContext context) =>
              const InvestmentItemEntryScreen(),
        },
      ),
    );
  }
}
