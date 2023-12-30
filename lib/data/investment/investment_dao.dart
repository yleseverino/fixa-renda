import 'package:floor/floor.dart';
import 'package:fixa_renda/data/investment/investment_entity.dart';

@dao
abstract class InvestmentDao {
  @Query("SELECT * FROM Investment")
  Stream<List<Investment>> getInvestments();

  @Query('SELECT * FROM Investment id = :id')
  Stream<Investment?> findInvestmentById(int id);

  @insert
  Future<void> insertInvestment(Investment investment);
}
