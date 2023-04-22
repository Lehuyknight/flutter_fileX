import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_task_model.freezed.dart';
part 'daily_task_model.g.dart';

@freezed
class DailyTaskModel with _$DailyTaskModel {
  factory DailyTaskModel({
    String? color,
    String? day,
    String? time,
    String? note,
  }) = _DailyTaskModel;

  factory DailyTaskModel.fromJson(Map<String, dynamic> json) =>
      _$DailyTaskModelFromJson(json);
Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['color'] = color;
    map['note'] = note;
    map['day'] = day;
    map['time'] = time;
    return map;
  }

}
