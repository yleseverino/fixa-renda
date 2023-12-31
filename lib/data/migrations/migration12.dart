import 'package:floor/floor.dart';

final migration12 = Migration(1, 2, (database) async {
  await database.execute('''ALTER TABLE Investment ADD COLUMN incomeType INT;
      UPDATE Investment SET incomeType = 0 WHERE incomeType IS NULL;''');
});
