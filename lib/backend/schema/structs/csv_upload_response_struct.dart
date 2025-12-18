// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CsvUploadResponseStruct extends BaseStruct {
  CsvUploadResponseStruct({
    bool? error,
    int? uploadedRecord,
    int? errorRecord,
    int? totalRecord,
    int? availableRecord,
  })  : _error = error,
        _uploadedRecord = uploadedRecord,
        _errorRecord = errorRecord,
        _totalRecord = totalRecord,
        _availableRecord = availableRecord;

  // "error" field.
  bool? _error;
  bool get error => _error ?? false;
  set error(bool? val) => _error = val;

  bool hasError() => _error != null;

  // "uploadedRecord" field.
  int? _uploadedRecord;
  int get uploadedRecord => _uploadedRecord ?? 0;
  set uploadedRecord(int? val) => _uploadedRecord = val;

  void incrementUploadedRecord(int amount) =>
      uploadedRecord = uploadedRecord + amount;

  bool hasUploadedRecord() => _uploadedRecord != null;

  // "errorRecord" field.
  int? _errorRecord;
  int get errorRecord => _errorRecord ?? 0;
  set errorRecord(int? val) => _errorRecord = val;

  void incrementErrorRecord(int amount) => errorRecord = errorRecord + amount;

  bool hasErrorRecord() => _errorRecord != null;

  // "totalRecord" field.
  int? _totalRecord;
  int get totalRecord => _totalRecord ?? 0;
  set totalRecord(int? val) => _totalRecord = val;

  void incrementTotalRecord(int amount) => totalRecord = totalRecord + amount;

  bool hasTotalRecord() => _totalRecord != null;

  // "availableRecord" field.
  int? _availableRecord;
  int get availableRecord => _availableRecord ?? 0;
  set availableRecord(int? val) => _availableRecord = val;

  void incrementAvailableRecord(int amount) =>
      availableRecord = availableRecord + amount;

  bool hasAvailableRecord() => _availableRecord != null;

  static CsvUploadResponseStruct fromMap(Map<String, dynamic> data) =>
      CsvUploadResponseStruct(
        error: data['error'] as bool?,
        uploadedRecord: castToType<int>(data['uploadedRecord']),
        errorRecord: castToType<int>(data['errorRecord']),
        totalRecord: castToType<int>(data['totalRecord']),
        availableRecord: castToType<int>(data['availableRecord']),
      );

  static CsvUploadResponseStruct? maybeFromMap(dynamic data) => data is Map
      ? CsvUploadResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'error': _error,
        'uploadedRecord': _uploadedRecord,
        'errorRecord': _errorRecord,
        'totalRecord': _totalRecord,
        'availableRecord': _availableRecord,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'error': serializeParam(
          _error,
          ParamType.bool,
        ),
        'uploadedRecord': serializeParam(
          _uploadedRecord,
          ParamType.int,
        ),
        'errorRecord': serializeParam(
          _errorRecord,
          ParamType.int,
        ),
        'totalRecord': serializeParam(
          _totalRecord,
          ParamType.int,
        ),
        'availableRecord': serializeParam(
          _availableRecord,
          ParamType.int,
        ),
      }.withoutNulls;

  static CsvUploadResponseStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CsvUploadResponseStruct(
        error: deserializeParam(
          data['error'],
          ParamType.bool,
          false,
        ),
        uploadedRecord: deserializeParam(
          data['uploadedRecord'],
          ParamType.int,
          false,
        ),
        errorRecord: deserializeParam(
          data['errorRecord'],
          ParamType.int,
          false,
        ),
        totalRecord: deserializeParam(
          data['totalRecord'],
          ParamType.int,
          false,
        ),
        availableRecord: deserializeParam(
          data['availableRecord'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'CsvUploadResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CsvUploadResponseStruct &&
        error == other.error &&
        uploadedRecord == other.uploadedRecord &&
        errorRecord == other.errorRecord &&
        totalRecord == other.totalRecord &&
        availableRecord == other.availableRecord;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([error, uploadedRecord, errorRecord, totalRecord, availableRecord]);
}

CsvUploadResponseStruct createCsvUploadResponseStruct({
  bool? error,
  int? uploadedRecord,
  int? errorRecord,
  int? totalRecord,
  int? availableRecord,
}) =>
    CsvUploadResponseStruct(
      error: error,
      uploadedRecord: uploadedRecord,
      errorRecord: errorRecord,
      totalRecord: totalRecord,
      availableRecord: availableRecord,
    );
