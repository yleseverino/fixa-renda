import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:fixa_renda/data/database.dart';
import 'package:fixa_renda/data/investment/investiment_repository.dart';
import 'package:fixa_renda/data/retrofit_services.dart';
import 'package:fixa_renda/data/selic/api/selic_service.dart';
import 'package:fixa_renda/data/selic/selic_repository.dart';
import 'package:fixa_renda/data/selic_forecast/models/meeting_model.dart';
import 'package:fixa_renda/data/selic_forecast/selic_forecast_repository.dart';
import 'package:fixa_renda/ui/investment_item/components/investment_item_content.dart';
import 'package:fixa_renda/ui/investment_item/investment_item_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/investment/enum/investment_income_type.dart';

class InvestmentItemEntryScreen extends StatefulWidget {
  static const routeName = 'investment-item-entry';

  const InvestmentItemEntryScreen({super.key});

  @override
  State<InvestmentItemEntryScreen> createState() =>
      _InvestmentItemEntryScreenState();
}

class _InvestmentItemEntryScreenState extends State<InvestmentItemEntryScreen> {
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
        Provider<InvestmentItemViewModel>(
            create: (context) => InvestmentItemViewModel(
                investmentRepository:
                    Provider.of<InvestmentRepository>(context, listen: false))),
      ],
      builder: (context, _) => Scaffold(
          appBar: AppBar(),
          body: InvestmentItemContent(onSave: (
              {required String name,
              required DateTime date,
              required num valueInvested,
              required num interestRate,
              required InvestmentIncomeType incomeType}) {
            context.read<InvestmentItemViewModel>().createInvestmentItem(
                name: name,
                date: date,
                valueInvested: valueInvested,
                interestRate: interestRate);

            Navigator.pop(context);
          })),
    );
  }
}
