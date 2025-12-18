// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UploadDataModelStruct extends BaseStruct {
  UploadDataModelStruct({
    int? totalCount,
    int? newAttendeeCount,
    int? duplicateAttendeeCount,
    int? inCompleteCount,
    int? errorCount,
  })  : _totalCount = totalCount,
        _newAttendeeCount = newAttendeeCount,
        _duplicateAttendeeCount = duplicateAttendeeCount,
        _inCompleteCount = inCompleteCount,
        _errorCount = errorCount;

  // "totalCount" field.
  int? _totalCount;
  int get totalCount => _totalCount ?? 0;
  set totalCount(int? val) => _totalCount = val;

  void incrementTotalCount(int amount) => totalCount = totalCount + amount;

  bool hasTotalCount() => _totalCount != null;

  // "newAttendeeCount" field.
  int? _newAttendeeCount;
  int get newAttendeeCount => _newAttendeeCount ?? 0;
  set newAttendeeCount(int? val) => _newAttendeeCount = val;

  void incrementNewAttendeeCount(int amount) =>
      newAttendeeCount = newAttendeeCount + amount;

  bool hasNewAttendeeCount() => _newAttendeeCount != null;

  // "duplicateAttendeeCount" field.
  int? _duplicateAttendeeCount;
  int get duplicateAttendeeCount => _duplicateAttendeeCount ?? 0;
  set duplicateAttendeeCount(int? val) => _duplicateAttendeeCount = val;

  void incrementDuplicateAttendeeCount(int amount) =>
      duplicateAttendeeCount = duplicateAttendeeCount + amount;

  bool hasDuplicateAttendeeCount() => _duplicateAttendeeCount != null;

  // "inCompleteCount" field.
  int? _inCompleteCount;
  int get inCompleteCount => _inCompleteCount ?? 0;
  set inCompleteCount(int? val) => _inCompleteCount = val;

  void incrementInCompleteCount(int amount) =>
      inCompleteCount = inCompleteCount + amount;

  bool hasInCompleteCount() => _inCompleteCount != null;

  // "errorCount" field.
  int? _errorCount;
  int get errorCount => _errorCount ?? 0;
  set errorCount(int? val) => _errorCount = val;

  void incrementErrorCount(int amount) => errorCount = errorCount + amount;

  bool hasErrorCount() => _errorCount != null;

  static UploadDataModelStruct fromMap(Map<String, dynamic> data) =>
      UploadDataModelStruct(
        totalCount: castToType<int>(data['totalCount']),
        newAttendeeCount: castToType<int>(data['newAttendeeCount']),
        duplicateAttendeeCount: castToType<int>(data['duplicateAttendeeCount']),
        inCompleteCount: castToType<int>(data['inCompleteCount']),
        errorCount: castToType<int>(data['errorCount']),
      );

  static UploadDataModelStruct? maybeFromMap(dynamic data) => data is Map
      ? UploadDataModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'totalCount': _totalCount,
        'newAttendeeCount': _newAttendeeCount,
        'duplicateAttendeeCount': _duplicateAttendeeCount,
        'inCompleteCount': _inCompleteCount,
        'errorCount': _errorCount,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'totalCount': serializeParam(
          _totalCount,
          ParamType.int,
        ),
        'newAttendeeCount': serializeParam(
          _newAttendeeCount,
          ParamType.int,
        ),
        'duplicateAttendeeCount': serializeParam(
          _duplicateAttendeeCount,
          ParamType.int,
        ),
        'inCompleteCount': serializeParam(
          _inCompleteCount,
          ParamType.int,
        ),
        'errorCount': serializeParam(
          _errorCount,
          ParamType.int,
        ),
      }.withoutNulls;

  static UploadDataModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      UploadDataModelStruct(
        totalCount: deserializeParam(
          data['totalCount'],
          ParamType.int,
          false,
        ),
        newAttendeeCount: deserializeParam(
          data['newAttendeeCount'],
          ParamType.int,
          false,
        ),
        duplicateAttendeeCount: deserializeParam(
          data['duplicateAttendeeCount'],
          ParamType.int,
          false,
        ),
        inCompleteCount: deserializeParam(
          data['inCompleteCount'],
          ParamType.int,
          false,
        ),
        errorCount: deserializeParam(
          data['errorCount'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'UploadDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UploadDataModelStruct &&
        totalCount == other.totalCount &&
        newAttendeeCount == other.newAttendeeCount &&
        duplicateAttendeeCount == other.duplicateAttendeeCount &&
        inCompleteCount == other.inCompleteCount &&
        errorCount == other.errorCount;
  }

  @override
  int get hashCode => const ListEquality().hash([
        totalCount,
        newAttendeeCount,
        duplicateAttendeeCount,
        inCompleteCount,
        errorCount
      ]);
}

UploadDataModelStruct createUploadDataModelStruct({
  int? totalCount,
  int? newAttendeeCount,
  int? duplicateAttendeeCount,
  int? inCompleteCount,
  int? errorCount,
}) =>
    UploadDataModelStruct(
      totalCount: totalCount,
      newAttendeeCount: newAttendeeCount,
      duplicateAttendeeCount: duplicateAttendeeCount,
      inCompleteCount: inCompleteCount,
      errorCount: errorCount,
    );
