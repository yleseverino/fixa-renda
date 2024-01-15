import 'package:fixa_renda/data/selic_forecast/models/meeting_model.dart';
import 'package:fixa_renda/data/selic_forecast/selic_forecast_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class SelicForecastDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSelic(SelicForecast selic);

  @Query(
      "SELECT AVG(sf.median) from SelicForecast sf where date = (SELECT max(date) as maxDate from  SelicForecast) and baseCalculo = 0 and meeting >= :greaterMeeting and meeting <= :lessMeeting")
  Future<double?> getSelicAverageBetweenMeetings(
      MeetingModel greaterMeeting, MeetingModel lessMeeting);

  @Query(
      "SELECT * from SelicForecast sf where date = (SELECT max(date) as maxDate from  SelicForecast) and baseCalculo = 0 and meeting >= :meeting group by meeting  order by  meeting asc limit 8")
  Stream<List<SelicForecast>> getLastForecastByMeeting(MeetingModel meeting);

  @Query("SELECT max(date) from SelicForecast sf ")
  Future<int?> getLastDate();
}
