import 'package:fixa_renda/data/database.dart';
import 'package:fixa_renda/data/investment/investiment_repository.dart';
import 'package:fixa_renda/data/investment/investment_entity.dart';
import 'package:fixa_renda/data/selic/api/selic_service.dart';
import 'package:fixa_renda/data/selic/selic_repository.dart';
import 'package:fixa_renda/ui/investment_item/components/investment_item_content.dart';
import 'package:fixa_renda/ui/investment_item/investment_edit_view_model.dart';
import 'package:fixa_renda/ui/investment_item/investment_item_view_model.dart';
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
              selicService: Provider.of<SelicService>(context, listen: false)),
        ),
        Provider<InvestmentRepository>(
          create: (context) => InvestmentRepository(
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
                      required num interestRate}) {
                    context
                        .read<InvestmentEditViewModel>()
                        .updateInvestmentItem(Investment(
                            id: investmentId,
                            name: name,
                            investedAmount: valueInvested.toDouble(),
                            interestRate: interestRate.toDouble(),
                            date: date));

                    Navigator.pop(context);
                  });
            },
          )),
    );
  }
}
