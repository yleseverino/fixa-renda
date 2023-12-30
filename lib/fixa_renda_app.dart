import 'package:fixa_renda/ui/help/help_screen.dart';
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
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            cardTheme: const CardTheme(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<BeveledRectangleBorder>(
                    const BeveledRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                )),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: Theme.of(context).textTheme.bodyMedium!,
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<BeveledRectangleBorder>(
                    const BeveledRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                )),
              ),
            ),
            textTheme: textScheme),
        darkTheme: ThemeData(
            useMaterial3: true,
            cardTheme: const CardTheme(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<BeveledRectangleBorder>(
                    const BeveledRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                )),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: Theme.of(context).textTheme.bodyMedium!,
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<BeveledRectangleBorder>(
                    const BeveledRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                )),
              ),
            ),
            colorScheme: darkColorScheme,
            textTheme: textScheme),
        home: const MyHomePage(),
        routes: <String, WidgetBuilder>{
          HelpScreen.routeName: (BuildContext context) => const HelpScreen(),
          InvestmentItemEntryScreen.routeName: (BuildContext context) =>
              const InvestmentItemEntryScreen(),
        },
      ),
    );
  }
}
