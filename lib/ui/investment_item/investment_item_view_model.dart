import 'package:fixa_renda/data/investment/investiment_repository.dart';

class InvestmentItemViewModel {
  final InvestmentRepository _investmentRepository;

  InvestmentItemViewModel({required InvestmentRepository investmentRepository})
      : _investmentRepository = investmentRepository;

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
}
