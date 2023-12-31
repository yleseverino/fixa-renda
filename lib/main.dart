import 'package:dio/dio.dart';
import 'package:fixa_renda/data/investment/investment_entity.dart';
import 'package:flutter/material.dart';
import 'package:fixa_renda/data/database.dart';
import 'package:fixa_renda/data/selic/api/selic_service.dart';
import 'package:fixa_renda/fixa_renda_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      await $FloorAppDatabase.databaseBuilder('investment.db').build();

  final dio = Dio();
  final selicService = SelicService(dio);

  runApp(FixaRendaApp(
    appDatabase: database,
    selicService: selicService,
  ));
}
