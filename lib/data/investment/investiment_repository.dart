import 'dart:math';

import 'package:fixa_renda/data/investment/enum/investment_income_type.dart';
import 'package:fixa_renda/data/investment/exceptions/selic_rate_not_found.dart';
import 'package:fixa_renda/data/investment/investment_dao.dart';
import 'package:fixa_renda/data/investment/investment_entity.dart';
import 'package:fixa_renda/data/investment/models/investiment_ui_model.dart';
import 'package:fixa_renda/data/investment/models/selic_rate_model.dart';
import 'package:fixa_renda/data/selic/selic_repository.dart';
import 'package:fixa_renda/data/selic_forecast/selic_forecast_repository.dart';

class InvestmentRepository {
  final InvestmentDao _investmentDao;
  final SelicRepository _selicRepository;
  final SelicForecastRepository _selicForecastRepository;

  InvestmentRepository(
      {required InvestmentDao investmentDao,
      required SelicRepository selicRepository,
      required SelicForecastRepository selicForecastRepository})
      : _investmentDao = investmentDao,
        _selicRepository = selicRepository,
        _selicForecastRepository = selicForecastRepository;

  Stream<List<InvestmentUiModel>> getInvestments() async* {
    final investmentsSteam = _investmentDao.getInvestments();
    await for (final investments in investmentsSteam) {
      final List<InvestmentUiModel> investmentsUi = [];
      for (final investment in investments) {
        final profit = await getInvestmentProfit(investment);
        final profit6months = await getInvestmentProfit6Months(investment);
        investmentsUi.add(InvestmentUiModel.fromInvestment(
            investment, profit, profit + profit6months));
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
        incomeType: InvestmentIncomeType.posFixed,
        date: date));
  }

  Future<double> getInvestmentProfit(Investment investment) async {
    if (investment.incomeType == InvestmentIncomeType.preFixed) {
      return _preFixateInvestiment(investment);
    }
    return await _posFixateInvestiment(investment);
  }

  double _preFixateInvestiment(Investment investment, {DateTime? currentDate}) {
    final date = currentDate ?? DateTime.now();
    final rateByDay =
        (pow((1 + (investment.interestRate / 100)), (1 / 252)) - 1);

    final period =
        (date.difference(investment.date).inDays * (252 / 365)).toInt();

    final futureValue = investment.investedAmount * pow(1 + rateByDay, period);
    return futureValue - investment.investedAmount;
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

  Future<double> getInvestmentProfit6Months(Investment investment) async {
    if (investment.incomeType == InvestmentIncomeType.preFixed) {
      return _preFixateInvestiment(investment,
          currentDate: DateTime.now().add(const Duration(days: 180)));
    }
    return await _posFixateInvestimentFutureCDI(investment, 4);
  }

  Future<double> _posFixateInvestimentFutureCDI(
      Investment investment, int numberOfMeetings) async {
    try {
      final numberMonths = numberOfMeetings * 1.5;
      final selicRateYear =
          await _selicForecastRepository.getSelicAverage(numberOfMeetings);
      final selicMonth = pow((1 + selicRateYear), 1 / 12) - 1;
      final investimentRate = (investment.interestRate / 100) * selicMonth;

      final futureValue =
          investment.investedAmount * (pow(1 + investimentRate, numberMonths));
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
