import 'package:fixa_renda/data/database.dart';
import 'package:fixa_renda/data/investment/investiment_repository.dart';
import 'package:fixa_renda/data/selic/api/selic_service.dart';
import 'package:fixa_renda/data/selic/selic_repository.dart';
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
        Provider<InvestmentRepository>(
          create: (context) => InvestmentRepository(
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
