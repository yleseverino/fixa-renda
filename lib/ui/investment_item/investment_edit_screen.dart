import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:fixa_renda/data/database.dart';
import 'package:fixa_renda/data/investment/enum/investment_income_type.dart';
import 'package:fixa_renda/data/investment/investiment_repository.dart';
import 'package:fixa_renda/data/investment/investment_entity.dart';
import 'package:fixa_renda/data/retrofit_services.dart';
import 'package:fixa_renda/data/selic/selic_repository.dart';
import 'package:fixa_renda/data/selic_forecast/models/meeting_model.dart';
import 'package:fixa_renda/data/selic_forecast/selic_forecast_repository.dart';
import 'package:fixa_renda/ui/investment_item/components/investment_item_content.dart';
import 'package:fixa_renda/ui/investment_item/investment_edit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvestmentItemEditScreen extends StatefulWidget {
  static const routeName = 'investment-edit';

  const InvestmentItemEditScreen({super.key});

  @override
  State<InvestmentItemEditScreen> createState() =>
      _InvestmentItemEditScreenState();
}

class _InvestmentItemEditScreenState extends State<InvestmentItemEditScreen> {
  @override
  Widget build(BuildContext context) {
    final int investmentId = ModalRoute.of(context)!.settings.arguments as int;

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
        Provider<InvestmentEditViewModel>(
            create: (context) => InvestmentEditViewModel(
                investmentId: investmentId,
                investmentRepository:
                    Provider.of<InvestmentRepository>(context, listen: false))),
      ],
      builder: (context, _) => Scaffold(
          appBar: AppBar(),
          body: StreamBuilder(
            stream: context.read<InvestmentEditViewModel>().investmentItem,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }

              if (!snapshot.hasData) {
                return const Center(
                  child: Text('Não foi possível carregar os dados'),
                );
              }

              final investmentItem = snapshot.data!;

              return InvestmentItemContent(
                  valueInvested: investmentItem.investedAmount,
                  interestRate: investmentItem.interestRate,
                  date: investmentItem.date,
                  name: investmentItem.name,
                  incomeType: investmentItem.incomeType,
                  onRemove: () {
                    context
                        .read<InvestmentEditViewModel>()
                        .deleteInvestmentItem(investmentItem);

                    Navigator.pop(context);
                  },
                  onSave: (
                      {required String name,
                      required DateTime date,
                      required num valueInvested,
                      required num interestRate,
                      required InvestmentIncomeType incomeType}) {
                    context
                        .read<InvestmentEditViewModel>()
                        .updateInvestmentItem(Investment(
                            id: investmentId,
                            name: name,
                            investedAmount: valueInvested.toDouble(),
                            incomeType: incomeType,
                            interestRate: interestRate.toDouble(),
                            date: date));

                    Navigator.pop(context);
                  });
            },
          )),
    );
  }
}
