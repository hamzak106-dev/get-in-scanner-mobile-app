// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AuthDataModelStruct extends BaseStruct {
  AuthDataModelStruct({
    String? session,
    String? refresh,
    String? firebase,
  })  : _session = session,
        _refresh = refresh,
        _firebase = firebase;

  // "session" field.
  String? _session;
  String get session => _session ?? '';
  set session(String? val) => _session = val;

  bool hasSession() => _session != null;

  // "refresh" field.
  String? _refresh;
  String get refresh => _refresh ?? '';
  set refresh(String? val) => _refresh = val;

  bool hasRefresh() => _refresh != null;

  // "firebase" field.
  String? _firebase;
  String get firebase => _firebase ?? '';
  set firebase(String? val) => _firebase = val;

  bool hasFirebase() => _firebase != null;

  static AuthDataModelStruct fromMap(Map<String, dynamic> data) =>
      AuthDataModelStruct(
        session: data['session'] as String?,
        refresh: data['refresh'] as String?,
        firebase: data['firebase'] as String?,
      );

  static AuthDataModelStruct? maybeFromMap(dynamic data) => data is Map
      ? AuthDataModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'session': _session,
        'refresh': _refresh,
        'firebase': _firebase,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'session': serializeParam(
          _session,
          ParamType.String,
        ),
        'refresh': serializeParam(
          _refresh,
          ParamType.String,
        ),
        'firebase': serializeParam(
          _firebase,
          ParamType.String,
        ),
      }.withoutNulls;

  static AuthDataModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      AuthDataModelStruct(
        session: deserializeParam(
          data['session'],
          ParamType.String,
          false,
        ),
        refresh: deserializeParam(
          data['refresh'],
          ParamType.String,
          false,
        ),
        firebase: deserializeParam(
          data['firebase'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AuthDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AuthDataModelStruct &&
        session == other.session &&
        refresh == other.refresh &&
        firebase == other.firebase;
  }

  @override
  int get hashCode => const ListEquality().hash([session, refresh, firebase]);
}

AuthDataModelStruct createAuthDataModelStruct({
  String? session,
  String? refresh,
  String? firebase,
}) =>
    AuthDataModelStruct(
      session: session,
      refresh: refresh,
      firebase: firebase,
    );
