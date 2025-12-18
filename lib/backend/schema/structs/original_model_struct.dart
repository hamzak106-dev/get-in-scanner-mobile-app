// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OriginalModelStruct extends BaseStruct {
  OriginalModelStruct({
    String? success,
    String? error,
    String? csrfToken,
    String? token,
    int? uid,
    String? facebookId,
    int? personalInfo,
    String? userId,
  })  : _success = success,
        _error = error,
        _csrfToken = csrfToken,
        _token = token,
        _uid = uid,
        _facebookId = facebookId,
        _personalInfo = personalInfo,
        _userId = userId;

  // "success" field.
  String? _success;
  String get success => _success ?? '';
  set success(String? val) => _success = val;

  bool hasSuccess() => _success != null;

  // "error" field.
  String? _error;
  String get error => _error ?? '';
  set error(String? val) => _error = val;

  bool hasError() => _error != null;

  // "csrf_token" field.
  String? _csrfToken;
  String get csrfToken => _csrfToken ?? '';
  set csrfToken(String? val) => _csrfToken = val;

  bool hasCsrfToken() => _csrfToken != null;

  // "token" field.
  String? _token;
  String get token => _token ?? '';
  set token(String? val) => _token = val;

  bool hasToken() => _token != null;

  // "uid" field.
  int? _uid;
  int get uid => _uid ?? 0;
  set uid(int? val) => _uid = val;

  void incrementUid(int amount) => uid = uid + amount;

  bool hasUid() => _uid != null;

  // "facebook_id" field.
  String? _facebookId;
  String get facebookId => _facebookId ?? '';
  set facebookId(String? val) => _facebookId = val;

  bool hasFacebookId() => _facebookId != null;

  // "personal_info" field.
  int? _personalInfo;
  int get personalInfo => _personalInfo ?? 0;
  set personalInfo(int? val) => _personalInfo = val;

  void incrementPersonalInfo(int amount) =>
      personalInfo = personalInfo + amount;

  bool hasPersonalInfo() => _personalInfo != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  static OriginalModelStruct fromMap(Map<String, dynamic> data) =>
      OriginalModelStruct(
        success: data['success'] as String?,
        error: data['error'] as String?,
        csrfToken: data['csrf_token'] as String?,
        token: data['token'] as String?,
        uid: castToType<int>(data['uid']),
        facebookId: data['facebook_id'] as String?,
        personalInfo: castToType<int>(data['personal_info']),
        userId: data['user_id'] as String?,
      );

  static OriginalModelStruct? maybeFromMap(dynamic data) => data is Map
      ? OriginalModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'success': _success,
        'error': _error,
        'csrf_token': _csrfToken,
        'token': _token,
        'uid': _uid,
        'facebook_id': _facebookId,
        'personal_info': _personalInfo,
        'user_id': _userId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'success': serializeParam(
          _success,
          ParamType.String,
        ),
        'error': serializeParam(
          _error,
          ParamType.String,
        ),
        'csrf_token': serializeParam(
          _csrfToken,
          ParamType.String,
        ),
        'token': serializeParam(
          _token,
          ParamType.String,
        ),
        'uid': serializeParam(
          _uid,
          ParamType.int,
        ),
        'facebook_id': serializeParam(
          _facebookId,
          ParamType.String,
        ),
        'personal_info': serializeParam(
          _personalInfo,
          ParamType.int,
        ),
        'user_id': serializeParam(
          _userId,
          ParamType.String,
        ),
      }.withoutNulls;

  static OriginalModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      OriginalModelStruct(
        success: deserializeParam(
          data['success'],
          ParamType.String,
          false,
        ),
        error: deserializeParam(
          data['error'],
          ParamType.String,
          false,
        ),
        csrfToken: deserializeParam(
          data['csrf_token'],
          ParamType.String,
          false,
        ),
        token: deserializeParam(
          data['token'],
          ParamType.String,
          false,
        ),
        uid: deserializeParam(
          data['uid'],
          ParamType.int,
          false,
        ),
        facebookId: deserializeParam(
          data['facebook_id'],
          ParamType.String,
          false,
        ),
        personalInfo: deserializeParam(
          data['personal_info'],
          ParamType.int,
          false,
        ),
        userId: deserializeParam(
          data['user_id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'OriginalModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is OriginalModelStruct &&
        success == other.success &&
        error == other.error &&
        csrfToken == other.csrfToken &&
        token == other.token &&
        uid == other.uid &&
        facebookId == other.facebookId &&
        personalInfo == other.personalInfo &&
        userId == other.userId;
  }

  @override
  int get hashCode => const ListEquality().hash([
        success,
        error,
        csrfToken,
        token,
        uid,
        facebookId,
        personalInfo,
        userId
      ]);
}

OriginalModelStruct createOriginalModelStruct({
  String? success,
  String? error,
  String? csrfToken,
  String? token,
  int? uid,
  String? facebookId,
  int? personalInfo,
  String? userId,
}) =>
    OriginalModelStruct(
      success: success,
      error: error,
      csrfToken: csrfToken,
      token: token,
      uid: uid,
      facebookId: facebookId,
      personalInfo: personalInfo,
      userId: userId,
    );
