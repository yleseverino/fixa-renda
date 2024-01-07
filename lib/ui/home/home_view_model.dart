import 'package:fixa_renda/data/investment/investiment_repository.dart';
import 'package:fixa_renda/data/investment/models/investiment_ui_model.dart';
import 'package:fixa_renda/data/selic_forecast/selic_forecast_repository.dart';

class HomeViewModel {
  final InvestmentRepository _investmentRepository;
  final SelicForecastRepository _selicForecastRepository;
  late final Stream<List<InvestmentUiModel>> investments;

  HomeViewModel( {required InvestmentRepository investmentRepository, required SelicForecastRepository selicForecastRepository})
      : _investmentRepository = investmentRepository , _selicForecastRepository = selicForecastRepository{
    investments = _investmentRepository.getInvestments();
    _selicForecastRepository.getLastForecast();
  }
}
