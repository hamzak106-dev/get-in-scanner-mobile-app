// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UploadDataResponseStruct extends BaseStruct {
  UploadDataResponseStruct({
    bool? success,
    String? message,
    UploadDataModelStruct? data,
    String? statusText,
  })  : _success = success,
        _message = message,
        _data = data,
        _statusText = statusText;

  // "success" field.
  bool? _success;
  bool get success => _success ?? false;
  set success(bool? val) => _success = val;

  bool hasSuccess() => _success != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  // "data" field.
  UploadDataModelStruct? _data;
  UploadDataModelStruct get data => _data ?? UploadDataModelStruct();
  set data(UploadDataModelStruct? val) => _data = val;

  void updateData(Function(UploadDataModelStruct) updateFn) {
    updateFn(_data ??= UploadDataModelStruct());
  }

  bool hasData() => _data != null;

  // "statusText" field.
  String? _statusText;
  String get statusText => _statusText ?? '';
  set statusText(String? val) => _statusText = val;

  bool hasStatusText() => _statusText != null;

  static UploadDataResponseStruct fromMap(Map<String, dynamic> data) =>
      UploadDataResponseStruct(
        success: data['success'] as bool?,
        message: data['message'] as String?,
        data: data['data'] is UploadDataModelStruct
            ? data['data']
            : UploadDataModelStruct.maybeFromMap(data['data']),
        statusText: data['statusText'] as String?,
      );

  static UploadDataResponseStruct? maybeFromMap(dynamic data) => data is Map
      ? UploadDataResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'success': _success,
        'message': _message,
        'data': _data?.toMap(),
        'statusText': _statusText,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'success': serializeParam(
          _success,
          ParamType.bool,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
        'data': serializeParam(
          _data,
          ParamType.DataStruct,
        ),
        'statusText': serializeParam(
          _statusText,
          ParamType.String,
        ),
      }.withoutNulls;

  static UploadDataResponseStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      UploadDataResponseStruct(
        success: deserializeParam(
          data['success'],
          ParamType.bool,
          false,
        ),
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
        data: deserializeStructParam(
          data['data'],
          ParamType.DataStruct,
          false,
          structBuilder: UploadDataModelStruct.fromSerializableMap,
        ),
        statusText: deserializeParam(
          data['statusText'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UploadDataResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UploadDataResponseStruct &&
        success == other.success &&
        message == other.message &&
        data == other.data &&
        statusText == other.statusText;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([success, message, data, statusText]);
}

UploadDataResponseStruct createUploadDataResponseStruct({
  bool? success,
  String? message,
  UploadDataModelStruct? data,
  String? statusText,
}) =>
    UploadDataResponseStruct(
      success: success,
      message: message,
      data: data ?? UploadDataModelStruct(),
      statusText: statusText,
    );
