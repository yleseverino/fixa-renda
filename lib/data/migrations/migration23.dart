import 'package:floor/floor.dart';

final migration23 = Migration(2, 3, (database) async {
  await database.execute('''CREATE TABLE `SelicForecast` (`id` INTEGER, `meeting` TEXT NOT NULL, `date` INTEGER NOT NULL, `median` REAL NOT NULL, PRIMARY KEY (`id`));''');
});
