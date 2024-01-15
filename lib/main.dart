import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:fixa_renda/data/database.dart';
import 'package:fixa_renda/data/migrations/migration12.dart';
import 'package:fixa_renda/data/migrations/migration23.dart';
import 'package:fixa_renda/data/retrofit_services.dart';
import 'package:fixa_renda/data/selic/api/selic_service.dart';
import 'package:fixa_renda/data/selic_forecast/api/selic_forecast_service.dart';
import 'package:fixa_renda/firebase_options.dart';
import 'package:fixa_renda/fixa_renda_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final database = await $FloorAppDatabase
      .databaseBuilder('investment.db')
      .addMigrations([migration12, migration23]).build();

  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
  ));
  await remoteConfig.setDefaults(const {
    "next_focus_meeting": 'R1/2024',
    "selic_atual": 11.75,
  });
  await remoteConfig.fetchAndActivate();

  final dio = Dio();
  final selicService = SelicService(dio);
  final selicForecastService = SelicForecastService(dio);

  final retrofitServices = RetrofitServices(
      selicService: selicService, selicForecastService: selicForecastService);

  runApp(FixaRendaApp(
    appDatabase: database,
    retrofitServices: retrofitServices,
  ));
}
