import 'dart:async';

import 'package:floor/floor.dart';
import 'package:fixa_renda/data/selic/selic_dao.dart';
import 'package:fixa_renda/data/selic/selic_entity.dart';
import 'package:fixa_renda/data/util/datetime_converter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:fixa_renda/data/investment/investment_dao.dart';
import 'package:fixa_renda/data/investment/investment_entity.dart';

part 'database.g.dart';

@Database(
  version: 1,
  entities: [Investment, Selic],
)
abstract class AppDatabase extends FloorDatabase {
  InvestmentDao get investmentDao;
  SelicDao get selicDao;
}
