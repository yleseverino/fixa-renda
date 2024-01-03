import 'package:floor/floor.dart';
import 'package:fixa_renda/data/selic/selic_entity.dart';

@dao
abstract class SelicForecastDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSelic(Selic selic);

  @Query(
      "SELECT * from SelicForecast sf where meeting = :meeting order by date desc limit 1")
  Future<double?> getSelicAverage(String meeting);

  @Query("SELECT COUNT(date) FROM Selic WHERE date >= :date")
  Future<int?> getCountDays(DateTime date);

  @Query("SELECT MAX(date) FROM Selic")
  Future<int?> getLastDate();

  @Query("SELECT * FROM Selic")
  Future<List<Selic>> getSelicList();
}
