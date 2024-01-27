import 'dart:async';

import 'package:fixa_renda/data/investment/enum/investment_income_type.dart';
import 'package:fixa_renda/data/selic_forecast/models/meeting_model.dart';
import 'package:fixa_renda/data/selic_forecast/selic_forecast_dao.dart';
import 'package:fixa_renda/data/selic_forecast/selic_forecast_entity.dart';
import 'package:floor/floor.dart';
import 'package:fixa_renda/data/selic/selic_dao.dart';
import 'package:fixa_renda/data/selic/selic_entity.dart';
import 'package:fixa_renda/data/util/datetime_converter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:fixa_renda/data/investment/investment_dao.dart';
import 'package:fixa_renda/data/investment/investment_entity.dart';

part 'database.g.dart';

@Database(
  version: 2,
  entities: [Investment, Selic, SelicForecast],
)
abstract class AppDatabase extends FloorDatabase {
  InvestmentDao get investmentDao;
  SelicDao get selicDao;
  SelicForecastDao get selicForecastDao;
}
