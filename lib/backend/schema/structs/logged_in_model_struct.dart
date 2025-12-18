// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LoggedInModelStruct extends BaseStruct {
  LoggedInModelStruct({
    int? userId,
    int? pinId,
    int? deviceId,
    Profile? profile,
    String? type,
    UserModelStruct? user,
    AuthDataModelStruct? auth,
    int? permissions,
    int? isManager,
    int? isProducer,
    String? pinType,
    String? eventIds,
  })  : _userId = userId,
        _pinId = pinId,
        _deviceId = deviceId,
        _profile = profile,
        _type = type,
        _user = user,
        _auth = auth,
        _permissions = permissions,
        _isManager = isManager,
        _isProducer = isProducer,
        _pinType = pinType,
        _eventIds = eventIds;

  // "user_id" field.
  int? _userId;
  int get userId => _userId ?? 0;
  set userId(int? val) => _userId = val;

  void incrementUserId(int amount) => userId = userId + amount;

  bool hasUserId() => _userId != null;

  // "pin_id" field.
  int? _pinId;
  int get pinId => _pinId ?? 0;
  set pinId(int? val) => _pinId = val;

  void incrementPinId(int amount) => pinId = pinId + amount;

  bool hasPinId() => _pinId != null;

  // "device_id" field.
  int? _deviceId;
  int get deviceId => _deviceId ?? 0;
  set deviceId(int? val) => _deviceId = val;

  void incrementDeviceId(int amount) => deviceId = deviceId + amount;

  bool hasDeviceId() => _deviceId != null;

  // "profile" field.
  Profile? _profile;
  Profile? get profile => _profile;
  set profile(Profile? val) => _profile = val;

  bool hasProfile() => _profile != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "user" field.
  UserModelStruct? _user;
  UserModelStruct get user => _user ?? UserModelStruct();
  set user(UserModelStruct? val) => _user = val;

  void updateUser(Function(UserModelStruct) updateFn) {
    updateFn(_user ??= UserModelStruct());
  }

  bool hasUser() => _user != null;

  // "auth" field.
  AuthDataModelStruct? _auth;
  AuthDataModelStruct get auth => _auth ?? AuthDataModelStruct();
  set auth(AuthDataModelStruct? val) => _auth = val;

  void updateAuth(Function(AuthDataModelStruct) updateFn) {
    updateFn(_auth ??= AuthDataModelStruct());
  }

  bool hasAuth() => _auth != null;

  // "permissions" field.
  int? _permissions;
  int get permissions => _permissions ?? 0;
  set permissions(int? val) => _permissions = val;

  void incrementPermissions(int amount) => permissions = permissions + amount;

  bool hasPermissions() => _permissions != null;

  // "isManager" field.
  int? _isManager;
  int get isManager => _isManager ?? 0;
  set isManager(int? val) => _isManager = val;

  void incrementIsManager(int amount) => isManager = isManager + amount;

  bool hasIsManager() => _isManager != null;

  // "isProducer" field.
  int? _isProducer;
  int get isProducer => _isProducer ?? 0;
  set isProducer(int? val) => _isProducer = val;

  void incrementIsProducer(int amount) => isProducer = isProducer + amount;

  bool hasIsProducer() => _isProducer != null;

  // "pinType" field.
  String? _pinType;
  String get pinType => _pinType ?? '';
  set pinType(String? val) => _pinType = val;

  bool hasPinType() => _pinType != null;

  // "eventIds" field.
  String? _eventIds;
  String get eventIds => _eventIds ?? '';
  set eventIds(String? val) => _eventIds = val;

  bool hasEventIds() => _eventIds != null;

  static LoggedInModelStruct fromMap(Map<String, dynamic> data) =>
      LoggedInModelStruct(
        userId: castToType<int>(data['user_id']),
        pinId: castToType<int>(data['pin_id']),
        deviceId: castToType<int>(data['device_id']),
        profile: data['profile'] is Profile
            ? data['profile']
            : deserializeEnum<Profile>(data['profile']),
        type: data['type'] as String?,
        user: data['user'] is UserModelStruct
            ? data['user']
            : UserModelStruct.maybeFromMap(data['user']),
        auth: data['auth'] is AuthDataModelStruct
            ? data['auth']
            : AuthDataModelStruct.maybeFromMap(data['auth']),
        permissions: castToType<int>(data['permissions']),
        isManager: castToType<int>(data['isManager']),
        isProducer: castToType<int>(data['isProducer']),
        pinType: data['pinType'] as String?,
        eventIds: data['eventIds'] as String?,
      );

  static LoggedInModelStruct? maybeFromMap(dynamic data) => data is Map
      ? LoggedInModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'user_id': _userId,
        'pin_id': _pinId,
        'device_id': _deviceId,
        'profile': _profile?.serialize(),
        'type': _type,
        'user': _user?.toMap(),
        'auth': _auth?.toMap(),
        'permissions': _permissions,
        'isManager': _isManager,
        'isProducer': _isProducer,
        'pinType': _pinType,
        'eventIds': _eventIds,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'user_id': serializeParam(
          _userId,
          ParamType.int,
        ),
        'pin_id': serializeParam(
          _pinId,
          ParamType.int,
        ),
        'device_id': serializeParam(
          _deviceId,
          ParamType.int,
        ),
        'profile': serializeParam(
          _profile,
          ParamType.Enum,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'user': serializeParam(
          _user,
          ParamType.DataStruct,
        ),
        'auth': serializeParam(
          _auth,
          ParamType.DataStruct,
        ),
        'permissions': serializeParam(
          _permissions,
          ParamType.int,
        ),
        'isManager': serializeParam(
          _isManager,
          ParamType.int,
        ),
        'isProducer': serializeParam(
          _isProducer,
          ParamType.int,
        ),
        'pinType': serializeParam(
          _pinType,
          ParamType.String,
        ),
        'eventIds': serializeParam(
          _eventIds,
          ParamType.String,
        ),
      }.withoutNulls;

  static LoggedInModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      LoggedInModelStruct(
        userId: deserializeParam(
          data['user_id'],
          ParamType.int,
          false,
        ),
        pinId: deserializeParam(
          data['pin_id'],
          ParamType.int,
          false,
        ),
        deviceId: deserializeParam(
          data['device_id'],
          ParamType.int,
          false,
        ),
        profile: deserializeParam<Profile>(
          data['profile'],
          ParamType.Enum,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        user: deserializeStructParam(
          data['user'],
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
        permissions: deserializeParam(
          data['permissions'],
          ParamType.int,
          false,
        ),
        isManager: deserializeParam(
          data['isManager'],
          ParamType.int,
          false,
        ),
        isProducer: deserializeParam(
          data['isProducer'],
          ParamType.int,
          false,
        ),
        pinType: deserializeParam(
          data['pinType'],
          ParamType.String,
          false,
        ),
        eventIds: deserializeParam(
          data['eventIds'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LoggedInModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LoggedInModelStruct &&
        userId == other.userId &&
        pinId == other.pinId &&
        deviceId == other.deviceId &&
        profile == other.profile &&
        type == other.type &&
        user == other.user &&
        auth == other.auth &&
        permissions == other.permissions &&
        isManager == other.isManager &&
        isProducer == other.isProducer &&
        pinType == other.pinType &&
        eventIds == other.eventIds;
  }

  @override
  int get hashCode => const ListEquality().hash([
        userId,
        pinId,
        deviceId,
        profile,
        type,
        user,
        auth,
        permissions,
        isManager,
        isProducer,
        pinType,
        eventIds
      ]);
}

LoggedInModelStruct createLoggedInModelStruct({
  int? userId,
  int? pinId,
  int? deviceId,
  Profile? profile,
  String? type,
  UserModelStruct? user,
  AuthDataModelStruct? auth,
  int? permissions,
  int? isManager,
  int? isProducer,
  String? pinType,
  String? eventIds,
}) =>
    LoggedInModelStruct(
      userId: userId,
      pinId: pinId,
      deviceId: deviceId,
      profile: profile,
      type: type,
      user: user ?? UserModelStruct(),
      auth: auth ?? AuthDataModelStruct(),
      permissions: permissions,
      isManager: isManager,
      isProducer: isProducer,
      pinType: pinType,
      eventIds: eventIds,
    );
