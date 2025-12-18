// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserModelStruct extends BaseStruct {
  UserModelStruct({
    int? userId,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    int? type,
    String? img,
    String? profileImg,
    String? company,
    String? phoneCountryCode,
    int? followerCounter,
    int? isProducer,
    int? isManager,
  })  : _userId = userId,
        _firstName = firstName,
        _lastName = lastName,
        _phone = phone,
        _email = email,
        _type = type,
        _img = img,
        _profileImg = profileImg,
        _company = company,
        _phoneCountryCode = phoneCountryCode,
        _followerCounter = followerCounter,
        _isProducer = isProducer,
        _isManager = isManager;

  // "user_id" field.
  int? _userId;
  int get userId => _userId ?? 0;
  set userId(int? val) => _userId = val;

  void incrementUserId(int amount) => userId = userId + amount;

  bool hasUserId() => _userId != null;

  // "first_name" field.
  String? _firstName;
  String get firstName => _firstName ?? '';
  set firstName(String? val) => _firstName = val;

  bool hasFirstName() => _firstName != null;

  // "last_name" field.
  String? _lastName;
  String get lastName => _lastName ?? '';
  set lastName(String? val) => _lastName = val;

  bool hasLastName() => _lastName != null;

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  set phone(String? val) => _phone = val;

  bool hasPhone() => _phone != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "type" field.
  int? _type;
  int get type => _type ?? 0;
  set type(int? val) => _type = val;

  void incrementType(int amount) => type = type + amount;

  bool hasType() => _type != null;

  // "img" field.
  String? _img;
  String get img => _img ?? '';
  set img(String? val) => _img = val;

  bool hasImg() => _img != null;

  // "profile_img" field.
  String? _profileImg;
  String get profileImg => _profileImg ?? '';
  set profileImg(String? val) => _profileImg = val;

  bool hasProfileImg() => _profileImg != null;

  // "company" field.
  String? _company;
  String get company => _company ?? '';
  set company(String? val) => _company = val;

  bool hasCompany() => _company != null;

  // "phoneCountryCode" field.
  String? _phoneCountryCode;
  String get phoneCountryCode => _phoneCountryCode ?? '';
  set phoneCountryCode(String? val) => _phoneCountryCode = val;

  bool hasPhoneCountryCode() => _phoneCountryCode != null;

  // "follower_counter" field.
  int? _followerCounter;
  int get followerCounter => _followerCounter ?? 0;
  set followerCounter(int? val) => _followerCounter = val;

  void incrementFollowerCounter(int amount) =>
      followerCounter = followerCounter + amount;

  bool hasFollowerCounter() => _followerCounter != null;

  // "isProducer" field.
  int? _isProducer;
  int get isProducer => _isProducer ?? 0;
  set isProducer(int? val) => _isProducer = val;

  void incrementIsProducer(int amount) => isProducer = isProducer + amount;

  bool hasIsProducer() => _isProducer != null;

  // "isManager" field.
  int? _isManager;
  int get isManager => _isManager ?? 0;
  set isManager(int? val) => _isManager = val;

  void incrementIsManager(int amount) => isManager = isManager + amount;

  bool hasIsManager() => _isManager != null;

  static UserModelStruct fromMap(Map<String, dynamic> data) => UserModelStruct(
        userId: castToType<int>(data['user_id']),
        firstName: data['first_name'] as String?,
        lastName: data['last_name'] as String?,
        phone: data['phone'] as String?,
        email: data['email'] as String?,
        type: castToType<int>(data['type']),
        img: data['img'] as String?,
        profileImg: data['profile_img'] as String?,
        company: data['company'] as String?,
        phoneCountryCode: data['phoneCountryCode'] as String?,
        followerCounter: castToType<int>(data['follower_counter']),
        isProducer: castToType<int>(data['isProducer']),
        isManager: castToType<int>(data['isManager']),
      );

  static UserModelStruct? maybeFromMap(dynamic data) => data is Map
      ? UserModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'user_id': _userId,
        'first_name': _firstName,
        'last_name': _lastName,
        'phone': _phone,
        'email': _email,
        'type': _type,
        'img': _img,
        'profile_img': _profileImg,
        'company': _company,
        'phoneCountryCode': _phoneCountryCode,
        'follower_counter': _followerCounter,
        'isProducer': _isProducer,
        'isManager': _isManager,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'user_id': serializeParam(
          _userId,
          ParamType.int,
        ),
        'first_name': serializeParam(
          _firstName,
          ParamType.String,
        ),
        'last_name': serializeParam(
          _lastName,
          ParamType.String,
        ),
        'phone': serializeParam(
          _phone,
          ParamType.String,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.int,
        ),
        'img': serializeParam(
          _img,
          ParamType.String,
        ),
        'profile_img': serializeParam(
          _profileImg,
          ParamType.String,
        ),
        'company': serializeParam(
          _company,
          ParamType.String,
        ),
        'phoneCountryCode': serializeParam(
          _phoneCountryCode,
          ParamType.String,
        ),
        'follower_counter': serializeParam(
          _followerCounter,
          ParamType.int,
        ),
        'isProducer': serializeParam(
          _isProducer,
          ParamType.int,
        ),
        'isManager': serializeParam(
          _isManager,
          ParamType.int,
        ),
      }.withoutNulls;

  static UserModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserModelStruct(
        userId: deserializeParam(
          data['user_id'],
          ParamType.int,
          false,
        ),
        firstName: deserializeParam(
          data['first_name'],
          ParamType.String,
          false,
        ),
        lastName: deserializeParam(
          data['last_name'],
          ParamType.String,
          false,
        ),
        phone: deserializeParam(
          data['phone'],
          ParamType.String,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.int,
          false,
        ),
        img: deserializeParam(
          data['img'],
          ParamType.String,
          false,
        ),
        profileImg: deserializeParam(
          data['profile_img'],
          ParamType.String,
          false,
        ),
        company: deserializeParam(
          data['company'],
          ParamType.String,
          false,
        ),
        phoneCountryCode: deserializeParam(
          data['phoneCountryCode'],
          ParamType.String,
          false,
        ),
        followerCounter: deserializeParam(
          data['follower_counter'],
          ParamType.int,
          false,
        ),
        isProducer: deserializeParam(
          data['isProducer'],
          ParamType.int,
          false,
        ),
        isManager: deserializeParam(
          data['isManager'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'UserModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserModelStruct &&
        userId == other.userId &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        phone == other.phone &&
        email == other.email &&
        type == other.type &&
        img == other.img &&
        profileImg == other.profileImg &&
        company == other.company &&
        phoneCountryCode == other.phoneCountryCode &&
        followerCounter == other.followerCounter &&
        isProducer == other.isProducer &&
        isManager == other.isManager;
  }

  @override
  int get hashCode => const ListEquality().hash([
        userId,
        firstName,
        lastName,
        phone,
        email,
        type,
        img,
        profileImg,
        company,
        phoneCountryCode,
        followerCounter,
        isProducer,
        isManager
      ]);
}

UserModelStruct createUserModelStruct({
  int? userId,
  String? firstName,
  String? lastName,
  String? phone,
  String? email,
  int? type,
  String? img,
  String? profileImg,
  String? company,
  String? phoneCountryCode,
  int? followerCounter,
  int? isProducer,
  int? isManager,
}) =>
    UserModelStruct(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      email: email,
      type: type,
      img: img,
      profileImg: profileImg,
      company: company,
      phoneCountryCode: phoneCountryCode,
      followerCounter: followerCounter,
      isProducer: isProducer,
      isManager: isManager,
    );
