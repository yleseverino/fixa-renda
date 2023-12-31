import 'dart:async';

import 'package:fixa_renda/data/investment/investiment_repository.dart';
import 'package:fixa_renda/data/investment/investment_entity.dart';

class InvestmentEditViewModel {
  final int investmentId;
  final InvestmentRepository _investmentRepository;
  late final Stream<Investment?> investmentItem;

  InvestmentEditViewModel(
      {required this.investmentId,
      required InvestmentRepository investmentRepository})
      : _investmentRepository = investmentRepository {
    investmentItem = _investmentRepository.findInvestmentById(investmentId);
  }

  Future<void> createInvestmentItem({
    required String name,
    required num valueInvested,
    required num interestRate,
    required DateTime date,
  }) async {
    return _investmentRepository.insert(
        name: name,
        valueInvested: valueInvested,
        interestRate: interestRate,
        date: date);
  }

  Future<void> updateInvestmentItem(Investment investment) async {
    return _investmentRepository.update(investment);
  }

  Future<void> deleteInvestmentItem(Investment investment) async {
    return _investmentRepository.delete(investment);
  }
}
