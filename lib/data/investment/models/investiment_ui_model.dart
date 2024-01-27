import 'package:fixa_renda/data/investment/investment_entity.dart';

class InvestmentUiModel {
  final int id;
  final String name;
  final num valueInvested;
  final num profit;
  final num profit6months;

  InvestmentUiModel(
      {required this.id,
      required this.name,
      required this.profit6months,
      required this.valueInvested,
      required this.profit});

  factory InvestmentUiModel.fromInvestment(
      Investment investment, double profit, double profit6months) {
    return InvestmentUiModel(
      id: investment.id!,
      name: investment.name,
      profit6months: profit6months,
      valueInvested: investment.investedAmount,
      profit: profit,
    );
  }
}
