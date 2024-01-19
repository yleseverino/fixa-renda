import 'package:fixa_renda/data/investment/investiment_repository.dart';
import 'package:fixa_renda/data/investment/models/investiment_ui_model.dart';
import 'package:fixa_renda/data/selic/selic_repository.dart';
import 'package:fixa_renda/data/selic_forecast/selic_forecast_repository.dart';
import 'package:fixa_renda/ui/home/components/forecast_selic_card/forecast_graph_ui_model.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  bool _updateSelic = false;
  final InvestmentRepository _investmentRepository;
  final SelicForecastRepository _selicForecastRepository;
  final SelicRepository _selicRepository;
  late Stream<List<InvestmentUiModel>> investments =
      _investmentRepository.getInvestments();
  late Stream<List<ForecastGraphUiModel>> forecast = _selicForecastRepository
      .getLastForecast()
      .map((event) =>
          event.map((e) => ForecastGraphUiModel.fromEntity(e)).toList());

  HomeViewModel(
      {required InvestmentRepository investmentRepository,
      required SelicForecastRepository selicForecastRepository,
      required SelicRepository selicRepository})
      : _investmentRepository = investmentRepository,
        _selicForecastRepository = selicForecastRepository,
        _selicRepository = selicRepository;

  double get selicAtual => _selicForecastRepository.selicAtual;

  Future<void> updateSelic() async {
    if (_updateSelic) {
      return;
    }
    await _selicForecastRepository.updateForecast();
    await _selicRepository.getSelicDataFromCentralBank();
    // investments = _investmentRepository.getInvestments();
    // forecast = _selicForecastRepository.getLastForecast().map((event) =>
    //     event.map((e) => ForecastGraphUiModel.fromEntity(e)).toList());
    _updateSelic = true;
  }
}
