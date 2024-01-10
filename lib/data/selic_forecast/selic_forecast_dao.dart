import 'package:fixa_renda/data/selic_forecast/models/meeting_model.dart';
import 'package:fixa_renda/data/selic_forecast/selic_forecast_entity.dart';
import 'package:floor/floor.dart';
import 'package:fixa_renda/data/selic/selic_entity.dart';

@dao
abstract class SelicForecastDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSelic(SelicForecast selic);

  @Query(
      "SELECT * from SelicForecast sf where meeting = :meeting order by date desc limit 1")
  Future<double?> getSelicAverage(String meeting);

  @Query(
      "SELECT * from SelicForecast sf where date = (SELECT max(date) as maxDate from  SelicForecast) and baseCalculo = 0 and meeting >= :meeting group by meeting  order by  meeting asc limit 8")
  Stream<List<SelicForecast>> getLastForecastByMeeting(MeetingModel meeting);

  @Query("SELECT max(date) from SelicForecast sf ")
  Future<int?> getLastDate();
}
