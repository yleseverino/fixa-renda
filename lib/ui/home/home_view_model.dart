import 'package:fixa_renda/data/investment/investiment_repository.dart';
import 'package:fixa_renda/data/investment/models/investiment_ui_model.dart';
import 'package:fixa_renda/data/selic_forecast/models/meeting_model.dart';
import 'package:fixa_renda/data/selic_forecast/selic_forecast_repository.dart';
import 'package:fixa_renda/ui/home/components/forecast_selic_card/forecast_graph_ui_model.dart';

class HomeViewModel {
  final InvestmentRepository _investmentRepository;
  final SelicForecastRepository _selicForecastRepository;
  late final Stream<List<InvestmentUiModel>> investments =
      _investmentRepository.getInvestments();
  late final Stream<List<ForecastGraphUiModel>> forecast =
      _selicForecastRepository.getLastForecast().map((event) =>
          event.map((e) => ForecastGraphUiModel.fromEntity(e)).toList());

  HomeViewModel(
      {required InvestmentRepository investmentRepository,
      required SelicForecastRepository selicForecastRepository})
      : _investmentRepository = investmentRepository,
        _selicForecastRepository = selicForecastRepository {}
}
