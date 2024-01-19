import 'package:intl/intl.dart';
import 'package:fixa_renda/data/selic/api/selic_service.dart';
import 'package:fixa_renda/data/selic/selic_dao.dart';



class SelicRepository {
  final SelicDao _selicDao;
  final SelicService _selicService;

  SelicRepository(
      {required SelicDao selicDao, required SelicService selicService})
      : _selicDao = selicDao,
        _selicService = selicService {
  }

  Future<double?> getSelicAverage(DateTime date) async {
    try {
      final averageRate = await _selicDao.getSelicAverage(date);
      return averageRate;
    } on TypeError {
      return null;
    }
  }

  Future<int?> getCountDays(DateTime date) async {
    try {
      final countDays = await _selicDao.getCountDays(date);
      return countDays;
    } on TypeError {
      return null;
    }
  }

  Future<void> getSelicDataFromCentralBank() async {
    int? lastDate;
    try {
      lastDate = await _selicDao.getLastDate();
    } catch (_) {}
    late final DateTime lastDateSelic;

    if (lastDate == null) {
      lastDateSelic = DateTime(2002, 1, 1);
    } else {
      lastDateSelic = DateTime.fromMillisecondsSinceEpoch(lastDate);
    }
    final today = DateTime.now();
    final formatDate = DateFormat('dd/MM/yyyy');

    final selicListDto = await _selicService.getSelicFromCentralBank(
        startDate: formatDate.format(lastDateSelic),
        endDate: formatDate.format(today));

    final selicList =
        selicListDto.map((selicDto) => selicDto.toSelic()).toList();

    for (final selic in selicList) {
      await _selicDao.insertSelic(selic);
    }
  }
}
