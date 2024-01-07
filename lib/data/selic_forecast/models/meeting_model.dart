import 'package:floor/floor.dart';

class MeetingModel {
  final int meeting;
  final int year;

  MeetingModel({required this.meeting, required this.year});
}

class MeetingModelTypeConverter
    extends TypeConverter<MeetingModel, String> {
  @override
  MeetingModel decode(String databaseValue) {
    final listValues = databaseValue.split('/');
    return MeetingModel(meeting: int.parse(listValues[0].replaceAll('R', '')), year: int.parse(listValues[1]));
  }

  @override
  String encode(MeetingModel value) {
    return '${value.meeting}/${value.year}';
  }
}
