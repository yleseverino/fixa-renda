import 'package:fixa_renda/ui/help/help_screen.dart';
import 'package:fixa_renda/ui/investment_item/investment_edit_screen.dart';
import 'package:fixa_renda/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:fixa_renda/data/database.dart';
import 'package:fixa_renda/data/selic/api/selic_service.dart';
import 'package:fixa_renda/ui/home/home_screen.dart';
import 'package:fixa_renda/ui/investment_item/investment_item_entry_screen.dart';
import 'package:fixa_renda/ui/theme/color_schemes.g.dart';
import 'package:fixa_renda/ui/theme/type_scheme.dart';
import 'package:provider/provider.dart';

class FixaRendaApp extends StatelessWidget {
  final AppDatabase appDatabase;
  final SelicService selicService;

  const FixaRendaApp(
      {super.key, required this.appDatabase, required this.selicService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDatabase>(
          create: (context) => appDatabase,
        ),
        Provider<SelicService>(
          create: (context) => selicService,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: getThemeData(context, false),
        darkTheme: getThemeData(context, true),
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
