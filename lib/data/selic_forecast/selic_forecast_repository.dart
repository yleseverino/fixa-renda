import 'package:fixa_renda/data/selic_forecast/api/selic_forecast_service.dart';
import 'package:fixa_renda/data/selic_forecast/models/meeting_model.dart';
import 'package:fixa_renda/data/selic_forecast/selic_forecast_dao.dart';
import 'package:fixa_renda/data/selic_forecast/selic_forecast_entity.dart';

bool alreadyUpdated = false;

class SelicForecastRepository {
  final SelicForecastDao _selicForecastDao;
  final SelicForecastService _forecastService;
  final double _selicAtual;
  final MeetingModel _nextMeeting;

  SelicForecastRepository(
      {required SelicForecastDao selicForecastDao,
      required SelicForecastService forecastService,
      required double selicAtual,
      required MeetingModel nextMeeting})
      : _selicForecastDao = selicForecastDao,
        _forecastService = forecastService,
        _selicAtual = selicAtual,
        _nextMeeting = nextMeeting {
    updateForecast();
  }

  double get selicAtual => _selicAtual;
  MeetingModel get nextMeeting => _nextMeeting;

  Future<void> updateForecast() async {
    if (alreadyUpdated) {
      return;
    }
    int? lastDate;
    try {
      lastDate = await _selicForecastDao.getLastDate();
    } catch (_) {}
    late final DateTime? lastDateSelic;

    if (lastDate == null) {
      lastDateSelic = null;
    } else {
      lastDateSelic = DateTime.fromMillisecondsSinceEpoch(lastDate);
    }

    final values = await _forecastService.getSelicForecastFromCentralBank(
        filter: formatFilterDateGreaterThan(lastDateSelic));

    for (final forecastDto in values.value) {
      await _selicForecastDao.insertSelic(forecastDto.toEntity());
    }
    alreadyUpdated = true;
  }

  Stream<List<SelicForecast>> getLastForecast() {
    return _selicForecastDao.getLastForecastByMeeting(_nextMeeting);
  }

  Future<double> getSelicAverage(int numberFutureMeeting) async {
    final averageRate = await _selicForecastDao.getSelicAverageBetweenMeetings(
        _nextMeeting, _nextMeeting.addMeeting(numberFutureMeeting));
    if (averageRate == null) {
      return 0;
    }
    return averageRate / 100;
  }
}
