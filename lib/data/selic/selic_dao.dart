import 'package:floor/floor.dart';
import 'package:fixa_renda/data/selic/selic_entity.dart';

@dao
abstract class SelicDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSelic(Selic selic);

  @Query("SELECT AVG(value) FROM Selic WHERE date >= :date")
  Future<double?> getSelicAverage(DateTime date);

  @Query("SELECT COUNT(date) FROM Selic WHERE date >= :date")
  Future<int?> getCountDays(DateTime date);

  @Query("SELECT MAX(date) FROM Selic")
  Future<int?> getLastDate();

  @Query("SELECT * FROM Selic")
  Future<List<Selic>> getSelicList();
}
