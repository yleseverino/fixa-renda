import 'dart:math';

import 'package:fixa_renda/data/investment/exceptions/selic_rate_not_found.dart';
import 'package:fixa_renda/data/investment/investment_dao.dart';
import 'package:fixa_renda/data/investment/investment_entity.dart';
import 'package:fixa_renda/data/investment/models/investiment_ui_model.dart';
import 'package:fixa_renda/data/investment/models/selic_rate_model.dart';
import 'package:fixa_renda/data/selic/selic_repository.dart';

class InvestmentRepository {
  final InvestmentDao _investmentDao;
  final SelicRepository _selicRepository;

  InvestmentRepository(
      {required InvestmentDao investmentDao,
      required SelicRepository selicRepository})
      : _investmentDao = investmentDao,
        _selicRepository = selicRepository;

  Stream<List<InvestmentUiModel>> getInvestments() async* {
    final investmentsSteam = _investmentDao.getInvestments();
    await for (final investments in investmentsSteam) {
      final List<InvestmentUiModel> investmentsUi = [];
      for (final investment in investments) {
        final profit = await getInvestmentProfit(investment);
        investmentsUi.add(InvestmentUiModel.fromInvestment(investment, profit));
      }

      yield investmentsUi;
    }
  }

  Future<void> update(Investment investment) async {
    return await _investmentDao.updateInvestment(investment);
  }

  Future<void> delete(Investment investment) async {
    return await _investmentDao.deleteInvestment(investment);
  }

  Future<void> insert({
    required String name,
    required num valueInvested,
    required num interestRate,
    required DateTime date,
  }) async {
    return await _investmentDao.insertInvestment(Investment(
        id: null,
        name: name,
        investedAmount: valueInvested.toDouble(),
        interestRate: interestRate.toDouble(),
        date: date));
  }

  Future<double> getInvestmentProfit(Investment investment) async {
    return await _posFixateInvestiment(investment);
  }

  Future<double> _posFixateInvestiment(Investment investment) async {
    try {
      final selicRate = await getSelicRate(investment.date);
      final investimentRate =
          (investment.interestRate / 100) * selicRate.averageRate;

      final futureValue = investment.investedAmount *
          (pow(1 + investimentRate, selicRate.countDays));
      final profit = futureValue - investment.investedAmount;

      return profit;
    } on SelicRateNotFound {
      return 0;
    }
  }

  Future<SelicRate> getSelicRate(DateTime date) async {
    final averageRate = await _selicRepository.getSelicAverage(date);
    final countDays = await _selicRepository.getCountDays(date);

    if (averageRate == null || countDays == null) {
      throw SelicRateNotFound('Error to get Selic Rate');
    }

    return SelicRate(
      countDays: countDays,
      averageRate: averageRate,
    );
  }

  Stream<Investment?> findInvestmentById(int id) {
    return _investmentDao.findInvestmentById(id);
  }
}
