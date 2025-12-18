// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SummaryStruct extends BaseStruct {
  SummaryStruct({
    String? name,
    int? value,
    int? totalCheckins,
    int? totalCheckouts,
    int? totalAttendees,
    int? totalAbsent,
    int? totalLogs,
  })  : _name = name,
        _value = value,
        _totalCheckins = totalCheckins,
        _totalCheckouts = totalCheckouts,
        _totalAttendees = totalAttendees,
        _totalAbsent = totalAbsent,
        _totalLogs = totalLogs;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "value" field.
  int? _value;
  int get value => _value ?? 0;
  set value(int? val) => _value = val;

  void incrementValue(int amount) => value = value + amount;

  bool hasValue() => _value != null;

  // "total_checkins" field.
  int? _totalCheckins;
  int get totalCheckins => _totalCheckins ?? 0;
  set totalCheckins(int? val) => _totalCheckins = val;

  void incrementTotalCheckins(int amount) =>
      totalCheckins = totalCheckins + amount;

  bool hasTotalCheckins() => _totalCheckins != null;

  // "total_checkouts" field.
  int? _totalCheckouts;
  int get totalCheckouts => _totalCheckouts ?? 0;
  set totalCheckouts(int? val) => _totalCheckouts = val;

  void incrementTotalCheckouts(int amount) =>
      totalCheckouts = totalCheckouts + amount;

  bool hasTotalCheckouts() => _totalCheckouts != null;

  // "total_attendees" field.
  int? _totalAttendees;
  int get totalAttendees => _totalAttendees ?? 0;
  set totalAttendees(int? val) => _totalAttendees = val;

  void incrementTotalAttendees(int amount) =>
      totalAttendees = totalAttendees + amount;

  bool hasTotalAttendees() => _totalAttendees != null;

  // "total_absent" field.
  int? _totalAbsent;
  int get totalAbsent => _totalAbsent ?? 0;
  set totalAbsent(int? val) => _totalAbsent = val;

  void incrementTotalAbsent(int amount) => totalAbsent = totalAbsent + amount;

  bool hasTotalAbsent() => _totalAbsent != null;

  // "total_logs" field.
  int? _totalLogs;
  int get totalLogs => _totalLogs ?? 0;
  set totalLogs(int? val) => _totalLogs = val;

  void incrementTotalLogs(int amount) => totalLogs = totalLogs + amount;

  bool hasTotalLogs() => _totalLogs != null;

  static SummaryStruct fromMap(Map<String, dynamic> data) => SummaryStruct(
        name: data['name'] as String?,
        value: castToType<int>(data['value']),
        totalCheckins: castToType<int>(data['total_checkins']),
        totalCheckouts: castToType<int>(data['total_checkouts']),
        totalAttendees: castToType<int>(data['total_attendees']),
        totalAbsent: castToType<int>(data['total_absent']),
        totalLogs: castToType<int>(data['total_logs']),
      );

  static SummaryStruct? maybeFromMap(dynamic data) =>
      data is Map ? SummaryStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'value': _value,
        'total_checkins': _totalCheckins,
        'total_checkouts': _totalCheckouts,
        'total_attendees': _totalAttendees,
        'total_absent': _totalAbsent,
        'total_logs': _totalLogs,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'value': serializeParam(
          _value,
          ParamType.int,
        ),
        'total_checkins': serializeParam(
          _totalCheckins,
          ParamType.int,
        ),
        'total_checkouts': serializeParam(
          _totalCheckouts,
          ParamType.int,
        ),
        'total_attendees': serializeParam(
          _totalAttendees,
          ParamType.int,
        ),
        'total_absent': serializeParam(
          _totalAbsent,
          ParamType.int,
        ),
        'total_logs': serializeParam(
          _totalLogs,
          ParamType.int,
        ),
      }.withoutNulls;

  static SummaryStruct fromSerializableMap(Map<String, dynamic> data) =>
      SummaryStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        value: deserializeParam(
          data['value'],
          ParamType.int,
          false,
        ),
        totalCheckins: deserializeParam(
          data['total_checkins'],
          ParamType.int,
          false,
        ),
        totalCheckouts: deserializeParam(
          data['total_checkouts'],
          ParamType.int,
          false,
        ),
        totalAttendees: deserializeParam(
          data['total_attendees'],
          ParamType.int,
          false,
        ),
        totalAbsent: deserializeParam(
          data['total_absent'],
          ParamType.int,
          false,
        ),
        totalLogs: deserializeParam(
          data['total_logs'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'SummaryStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SummaryStruct &&
        name == other.name &&
        value == other.value &&
        totalCheckins == other.totalCheckins &&
        totalCheckouts == other.totalCheckouts &&
        totalAttendees == other.totalAttendees &&
        totalAbsent == other.totalAbsent &&
        totalLogs == other.totalLogs;
  }

  @override
  int get hashCode => const ListEquality().hash([
        name,
        value,
        totalCheckins,
        totalCheckouts,
        totalAttendees,
        totalAbsent,
        totalLogs
      ]);
}

SummaryStruct createSummaryStruct({
  String? name,
  int? value,
  int? totalCheckins,
  int? totalCheckouts,
  int? totalAttendees,
  int? totalAbsent,
  int? totalLogs,
}) =>
    SummaryStruct(
      name: name,
      value: value,
      totalCheckins: totalCheckins,
      totalCheckouts: totalCheckouts,
      totalAttendees: totalAttendees,
      totalAbsent: totalAbsent,
      totalLogs: totalLogs,
    );
