import 'package:fixa_renda/data/selic_forecast/api/selic_forecast_service.dart';
import 'package:fixa_renda/data/selic_forecast/models/meeting_model.dart';
import 'package:fixa_renda/data/selic_forecast/selic_forecast_dao.dart';
import 'package:fixa_renda/data/selic_forecast/selic_forecast_entity.dart';

bool alreadyUpdated = false;

class SelicForecastRepository {
  final SelicForecastDao _selicForecastDao;
  final SelicForecastService _forecastService;

  SelicForecastRepository(
      {required SelicForecastDao selicForecastDao,
      required SelicForecastService forecastService})
      : _selicForecastDao = selicForecastDao,
        _forecastService = forecastService {
    updateForecast();
  }

  Future<void> updateForecast() async {
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
  }

  Stream<List<SelicForecast>> getLastForecast(MeetingModel meetingModel) {
    return _selicForecastDao.getLastForecastByMeeting(meetingModel);
  }
}
