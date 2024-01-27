import 'package:floor/floor.dart';

final monthsMeeting = {
  1: '',
  2: 'Mar',
  3: '',
  4: 'Jun',
  5: '',
  6: 'Sep',
  7: '',
  8: 'Dec',
};

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

  MeetingModel addMeeting(int meeting) {
    if (this.meeting + meeting > 8) {
      final meetingAdjust = this.meeting + meeting - 8;
      return MeetingModel(meeting: meetingAdjust, year: year + 1);
    }
    return MeetingModel(meeting: this.meeting + meeting, year: year);
  }

  String get month => monthsMeeting[meeting] ?? '';

  String get label => '$meeting/$year';
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
