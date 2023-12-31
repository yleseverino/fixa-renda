import 'package:fixa_renda/ui/help/help_screen.dart';
import 'package:fixa_renda/ui/investment_item/investment_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:fixa_renda/data/database.dart';
import 'package:fixa_renda/data/investment/investiment_repository.dart';
import 'package:fixa_renda/data/selic/api/selic_service.dart';
import 'package:fixa_renda/data/selic/selic_repository.dart';
import 'package:fixa_renda/ui/home/components/investment_card.dart';
import 'package:fixa_renda/ui/home/home_view_model.dart';
import 'package:fixa_renda/ui/investment_item/investment_item_entry_screen.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SelicRepository>(
          create: (context) => SelicRepository(
              selicDao:
                  Provider.of<AppDatabase>(context, listen: false).selicDao,
              selicService: Provider.of<SelicService>(context, listen: false)),
        ),
        Provider<InvestmentRepository>(
          create: (context) => InvestmentRepository(
              investmentDao: Provider.of<AppDatabase>(context, listen: false)
                  .investmentDao,
              selicRepository:
                  Provider.of<SelicRepository>(context, listen: false)),
        ),
        Provider<HomeViewModel>(
            create: (context) => HomeViewModel(
                investmentRepository:
                    Provider.of<InvestmentRepository>(context, listen: false))),
      ],
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const Text('Investimentos'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, HelpScreen.routeName);
              },
              icon: Icon(
                Icons.help_outline,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: StreamBuilder(
                stream: context.read<HomeViewModel>().investments,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return const Text('Erro ao carregar investimentos');
                  }

                  if (snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('Nenhum investimento cadastrado'));
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ...snapshot.data!
                          .map((investment) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        InvestmentItemEditScreen.routeName,
                                        arguments: investment.id);
                                  },
                                  child: InvestmentCard(
                                    title: investment.name,
                                    investedValue: investment.valueInvested,
                                    grossIncome: investment.profit,
                                  ),
                                ),
                              ))
                          .toList()
                    ],
                  );
                }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, InvestmentItemEntryScreen.routeName);
          },
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
          ),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
