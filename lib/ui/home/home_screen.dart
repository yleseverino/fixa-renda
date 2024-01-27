import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:fixa_renda/data/database.dart';
import 'package:fixa_renda/data/investment/investiment_repository.dart';
import 'package:fixa_renda/data/retrofit_services.dart';
import 'package:fixa_renda/data/selic/selic_repository.dart';
import 'package:fixa_renda/data/selic_forecast/models/meeting_model.dart';
import 'package:fixa_renda/data/selic_forecast/selic_forecast_repository.dart';
import 'package:fixa_renda/ui/help/help_screen.dart';
import 'package:fixa_renda/ui/home/components/forecast_selic_card/forecast_selic_card.dart';
import 'package:fixa_renda/ui/home/components/investment_card.dart';
import 'package:fixa_renda/ui/home/home_view_model.dart';
import 'package:fixa_renda/ui/investment_item/investment_edit_screen.dart';
import 'package:fixa_renda/ui/investment_item/investment_item_entry_screen.dart';
import 'package:flutter/material.dart';
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
              selicService:
                  Provider.of<RetrofitServices>(context, listen: false)
                      .selicService),
        ),
        Provider<SelicForecastRepository>(
          create: (context) => SelicForecastRepository(
              nextMeeting: MeetingModel.fromApi(FirebaseRemoteConfig.instance
                  .getString('next_focus_meeting')),
              selicAtual:
                  FirebaseRemoteConfig.instance.getDouble('selic_atual'),
              selicForecastDao: Provider.of<AppDatabase>(context, listen: false)
                  .selicForecastDao,
              forecastService:
                  Provider.of<RetrofitServices>(context, listen: false)
                      .selicForecastService),
        ),
        Provider<InvestmentRepository>(
          create: (context) => InvestmentRepository(
              selicForecastRepository:
                  Provider.of<SelicForecastRepository>(context, listen: false),
              investmentDao: Provider.of<AppDatabase>(context, listen: false)
                  .investmentDao,
              selicRepository:
                  Provider.of<SelicRepository>(context, listen: false)),
        ),
        ChangeNotifierProvider<HomeViewModel>(
            create: (context) => HomeViewModel(
                selicRepository: Provider.of<SelicRepository>(context,
                    listen: false),
                selicForecastRepository: Provider.of<SelicForecastRepository>(
                    context,
                    listen: false),
                investmentRepository:
                    Provider.of<InvestmentRepository>(context, listen: false))),
      ],
      builder: (context, _) => Scaffold(
        appBar: AppBar(
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                    stream: context.read<HomeViewModel>().forecast,
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

                      return ForecastSelicCard(
                        selic: context.watch<HomeViewModel>().selicAtual,
                        forecastGraphUiModel: snapshot.data!,
                      );
                    }),
                StreamBuilder(
                    stream: context.watch<HomeViewModel>().investments,
                    builder: (context, snapshot) {
                      context.read<HomeViewModel>().updateSelic();
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        return const Text('Erro ao carregar investimentos');
                      }

                      if (snapshot.data!.isEmpty) {
                        return Container();
                      }

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ...snapshot.data!
                              .map((investmentUi) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            InvestmentItemEditScreen.routeName,
                                            arguments: investmentUi.id);
                                      },
                                      child: InvestmentCard(
                                        investmentUiModel: investmentUi,
                                      ),
                                    ),
                                  ))
                              .toList()
                        ],
                      );
                    }),
              ],
            ),
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
