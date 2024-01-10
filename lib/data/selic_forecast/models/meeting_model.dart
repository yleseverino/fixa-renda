import 'package:floor/floor.dart';

class MeetingModel {
  final int meeting;
  final int year;

  MeetingModel({required this.meeting, required this.year});

  factory MeetingModel.fromApi(String reuniao) {
    final list = reuniao.split('/');
    return MeetingModel(
        meeting: int.parse(list[0].replaceAll('R', "")),
        year: int.parse(list[1]));
  }
}

class MeetingModelTypeConverter extends TypeConverter<MeetingModel, String> {
  @override
  MeetingModel decode(String databaseValue) {
    return MeetingModel(
        meeting: int.parse(databaseValue[4]),
        year: int.parse(
            '${databaseValue[0]}${databaseValue[1]}${databaseValue[2]}${databaseValue[3]}'));
  }

  @override
  String encode(MeetingModel value) {
    return '${value.year}${value.meeting}';
  }
}
