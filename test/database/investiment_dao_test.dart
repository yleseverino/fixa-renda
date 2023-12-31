import 'package:fixa_renda/data/investment/investment_dao.dart';
import 'package:fixa_renda/data/investment/investment_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fixa_renda/data/database.dart';

void main() {
  late AppDatabase database;
  late InvestmentDao investmentDao;

  setUp(() async {
    database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    investmentDao = database.investmentDao;
  });

  tearDown(() async {
    await database.close();
  });

  test("Test save investments", () async {
    await investmentDao.insertInvestment(Investment(
        id: null,
        name: "Teste 1",
        investedAmount: 100,
        interestRate: 10,
        date: DateTime.now()));

    await investmentDao.insertInvestment(Investment(
        id: null,
        name: "Teste 2",
        investedAmount: 100,
        interestRate: 10,
        date: DateTime.now()));

    final investments = await investmentDao.getInvestments().first;

    expect(investments[0].id, 1);
    expect(investments[0].name, "Teste 1");
    expect(investments[0].investedAmount, 100);
    expect(investments[0].interestRate, 10);
    expect(investments[0].date, isNotNull);

    expect(investments[1].id, 2);
    expect(investments[1].name, "Teste 2");
    expect(investments[1].investedAmount, 100);
    expect(investments[1].interestRate, 10);
    expect(investments[1].date, isNotNull);
  });

  test("Test read one investment", () async {
    await investmentDao.insertInvestment(Investment(
        id: 1,
        name: "Teste 1",
        investedAmount: 100,
        interestRate: 10,
        date: DateTime.now()));

    final investment = await investmentDao.findInvestmentById(1).first;

    expect(investment!.id, 1);
    expect(investment.name, "Teste 1");
    expect(investment.investedAmount, 100);
    expect(investment.interestRate, 10);
    expect(investment.date, isNotNull);
  });
}
