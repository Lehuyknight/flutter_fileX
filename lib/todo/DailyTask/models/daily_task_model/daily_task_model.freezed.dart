// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DailyTaskModel _$DailyTaskModelFromJson(Map<String, dynamic> json) {
  return _DailyTaskModel.fromJson(json);
}

/// @nodoc
mixin _$DailyTaskModel {
  String? get color => throw _privateConstructorUsedError;
  String? get day => throw _privateConstructorUsedError;
  String? get time => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyTaskModelCopyWith<DailyTaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyTaskModelCopyWith<$Res> {
  factory $DailyTaskModelCopyWith(
          DailyTaskModel value, $Res Function(DailyTaskModel) then) =
      _$DailyTaskModelCopyWithImpl<$Res, DailyTaskModel>;
  @useResult
  $Res call({String? color, String? day, String? time, String? note});
}

/// @nodoc
class _$DailyTaskModelCopyWithImpl<$Res, $Val extends DailyTaskModel>
    implements $DailyTaskModelCopyWith<$Res> {
  _$DailyTaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = freezed,
    Object? day = freezed,
    Object? time = freezed,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      day: freezed == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DailyTaskModelCopyWith<$Res>
    implements $DailyTaskModelCopyWith<$Res> {
  factory _$$_DailyTaskModelCopyWith(
          _$_DailyTaskModel value, $Res Function(_$_DailyTaskModel) then) =
      __$$_DailyTaskModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? color, String? day, String? time, String? note});
}

/// @nodoc
class __$$_DailyTaskModelCopyWithImpl<$Res>
    extends _$DailyTaskModelCopyWithImpl<$Res, _$_DailyTaskModel>
    implements _$$_DailyTaskModelCopyWith<$Res> {
  __$$_DailyTaskModelCopyWithImpl(
      _$_DailyTaskModel _value, $Res Function(_$_DailyTaskModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = freezed,
    Object? day = freezed,
    Object? time = freezed,
    Object? note = freezed,
  }) {
    return _then(_$_DailyTaskModel(
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      day: freezed == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DailyTaskModel implements _DailyTaskModel {
  _$_DailyTaskModel({this.color, this.day, this.time, this.note});

  factory _$_DailyTaskModel.fromJson(Map<String, dynamic> json) =>
      _$$_DailyTaskModelFromJson(json);

  @override
  final String? color;
  @override
  final String? day;
  @override
  final String? time;
  @override
  final String? note;

  @override
  String toString() {
    return 'DailyTaskModel(color: $color, day: $day, time: $time, note: $note)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DailyTaskModel &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, color, day, time, note);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DailyTaskModelCopyWith<_$_DailyTaskModel> get copyWith =>
      __$$_DailyTaskModelCopyWithImpl<_$_DailyTaskModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DailyTaskModelToJson(
      this,
    );
  }
  
  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}

abstract class _DailyTaskModel implements DailyTaskModel {
  factory _DailyTaskModel(
      {final String? color,
      final String? day,
      final String? time,
      final String? note}) = _$_DailyTaskModel;

  factory _DailyTaskModel.fromJson(Map<String, dynamic> json) =
      _$_DailyTaskModel.fromJson;

  @override
  String? get color;
  @override
  String? get day;
  @override
  String? get time;
  @override
  String? get note;
  @override
  @JsonKey(ignore: true)
  _$$_DailyTaskModelCopyWith<_$_DailyTaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}
