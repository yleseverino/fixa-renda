extension StringExtension on String {
  num? convertPriceToNum() {
    return num.tryParse(replaceAll('R\$', '')
        .replaceAll('.', '')
        .replaceAll(',', '.')
        .trim());
  }
}
