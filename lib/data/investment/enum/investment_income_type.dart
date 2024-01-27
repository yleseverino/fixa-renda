import 'package:floor/floor.dart';

enum InvestmentIncomeType {
  posFixed("Pós-Fixado atrelado ao CDI"),
  preFixed("Pré-Fixado");

  final String description;
  const InvestmentIncomeType(this.description);
}

class InvestmentIncomeTypeConverter
    extends TypeConverter<InvestmentIncomeType, int> {
  @override
  InvestmentIncomeType decode(int databaseValue) {
    return InvestmentIncomeType.values[databaseValue];
  }

  @override
  int encode(InvestmentIncomeType value) {
    return value.index;
  }
}
