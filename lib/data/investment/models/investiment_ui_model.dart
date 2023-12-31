import 'package:fixa_renda/data/investment/investment_entity.dart';

class InvestmentUiModel {
  final int id;
  final String name;
  final num valueInvested;
  final num profit;

  InvestmentUiModel(
      {required this.id,
      required this.name,
      required this.valueInvested,
      required this.profit});

  factory InvestmentUiModel.fromInvestment(
      Investment investment, double profit) {
    return InvestmentUiModel(
      id: investment.id!,
      name: investment.name,
      valueInvested: investment.investedAmount,
      profit: profit,
    );
  }
}
