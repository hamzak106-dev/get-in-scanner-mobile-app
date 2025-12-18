// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LoginResponseModelStruct extends BaseStruct {
  LoginResponseModelStruct({
    OriginalModelStruct? original,
    UserModelStruct? userData,
    AuthDataModelStruct? auth,
    bool? newUser,
  })  : _original = original,
        _userData = userData,
        _auth = auth,
        _newUser = newUser;

  // "original" field.
  OriginalModelStruct? _original;
  OriginalModelStruct get original => _original ?? OriginalModelStruct();
  set original(OriginalModelStruct? val) => _original = val;

  void updateOriginal(Function(OriginalModelStruct) updateFn) {
    updateFn(_original ??= OriginalModelStruct());
  }

  bool hasOriginal() => _original != null;

  // "user_data" field.
  UserModelStruct? _userData;
  UserModelStruct get userData => _userData ?? UserModelStruct();
  set userData(UserModelStruct? val) => _userData = val;

  void updateUserData(Function(UserModelStruct) updateFn) {
    updateFn(_userData ??= UserModelStruct());
  }

  bool hasUserData() => _userData != null;

  // "auth" field.
  AuthDataModelStruct? _auth;
  AuthDataModelStruct get auth => _auth ?? AuthDataModelStruct();
  set auth(AuthDataModelStruct? val) => _auth = val;

  void updateAuth(Function(AuthDataModelStruct) updateFn) {
    updateFn(_auth ??= AuthDataModelStruct());
  }

  bool hasAuth() => _auth != null;

  // "new_user" field.
  bool? _newUser;
  bool get newUser => _newUser ?? false;
  set newUser(bool? val) => _newUser = val;

  bool hasNewUser() => _newUser != null;

  static LoginResponseModelStruct fromMap(Map<String, dynamic> data) =>
      LoginResponseModelStruct(
        original: data['original'] is OriginalModelStruct
            ? data['original']
            : OriginalModelStruct.maybeFromMap(data['original']),
        userData: data['user_data'] is UserModelStruct
            ? data['user_data']
            : UserModelStruct.maybeFromMap(data['user_data']),
        auth: data['auth'] is AuthDataModelStruct
            ? data['auth']
            : AuthDataModelStruct.maybeFromMap(data['auth']),
        newUser: data['new_user'] as bool?,
      );

  static LoginResponseModelStruct? maybeFromMap(dynamic data) => data is Map
      ? LoginResponseModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'original': _original?.toMap(),
        'user_data': _userData?.toMap(),
        'auth': _auth?.toMap(),
        'new_user': _newUser,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'original': serializeParam(
          _original,
          ParamType.DataStruct,
        ),
        'user_data': serializeParam(
          _userData,
          ParamType.DataStruct,
        ),
        'auth': serializeParam(
          _auth,
          ParamType.DataStruct,
        ),
        'new_user': serializeParam(
          _newUser,
          ParamType.bool,
        ),
      }.withoutNulls;

  static LoginResponseModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      LoginResponseModelStruct(
        original: deserializeStructParam(
          data['original'],
          ParamType.DataStruct,
          false,
          structBuilder: OriginalModelStruct.fromSerializableMap,
        ),
        userData: deserializeStructParam(
          data['user_data'],
          ParamType.DataStruct,
          false,
          structBuilder: UserModelStruct.fromSerializableMap,
        ),
        auth: deserializeStructParam(
          data['auth'],
          ParamType.DataStruct,
          false,
          structBuilder: AuthDataModelStruct.fromSerializableMap,
        ),
        newUser: deserializeParam(
          data['new_user'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'LoginResponseModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LoginResponseModelStruct &&
        original == other.original &&
        userData == other.userData &&
        auth == other.auth &&
        newUser == other.newUser;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([original, userData, auth, newUser]);
}

LoginResponseModelStruct createLoginResponseModelStruct({
  OriginalModelStruct? original,
  UserModelStruct? userData,
  AuthDataModelStruct? auth,
  bool? newUser,
}) =>
    LoginResponseModelStruct(
      original: original ?? OriginalModelStruct(),
      userData: userData ?? UserModelStruct(),
      auth: auth ?? AuthDataModelStruct(),
      newUser: newUser,
    );
