// ignore_for_file: unnecessary_getters_setters

import 'dart:developer';

import '/backend/schema/util/schema_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart';

class TapToPayResponseStruct extends BaseStruct {
  TapToPayResponseStruct({
    String? code,
    TapToPayDataStruct? data,
  })  : _code = code,
        _data = data;

  // "code" field
  String? _code;

  String get code => _code ?? '';

  set code(String? val) => _code = val;

  bool hasCode() => _code != null;

  // "data" field
  TapToPayDataStruct? _data;

  TapToPayDataStruct get data => _data ?? TapToPayDataStruct();

  set data(TapToPayDataStruct? val) => _data = val;

  bool hasData() => _data != null;

  static TapToPayResponseStruct? maybeFromMap(dynamic data) =>
      data.isEmpty ? null : fromMap(data);

  static TapToPayResponseStruct fromMap(Map<String, dynamic> data) =>
      TapToPayResponseStruct(
        code: data['code'] as String?,
        data: data['data'] != null
            ? TapToPayDataStruct.maybeFromMap(data['data'])
            : null,
      );

  Map<String, dynamic> toMap() => {
        'code': _code,
        'data': _data?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() {
    return {
      'code': serializeParam(
        _code,
        ParamType.String,
      ),
      'data': serializeParam(
        _data,
        ParamType.DataStruct,
      ),
    }.withoutNulls;
  }
}

// ---------- Data Struct ----------
class TapToPayDataStruct extends BaseStruct {
  TapToPayDataStruct({
    int? posTransactionId,
    String? hash,
    TapToPayStruct? tapToPay,
    TerminalStruct? terminal,
  })  : _tapToPay = tapToPay,
        _terminal = terminal,
        posTransactionId = posTransactionId,
        hash = hash;

  // pos_transaction_id
  int? posTransactionId;

  int getPosTransactionId() => posTransactionId ?? 0;

  setPosTransactionId(int? val) => posTransactionId = val;

  bool hasPosTransactionId() => posTransactionId != null;

  // hash
  String? hash;

  String getHash() => hash ?? '';

  setHash(String? val) => hash = val;

  bool hasHash() => hash != null;

  // transaction_id
  // String? transactionId;
  // String getTransactionId() => transactionId ?? '';
  // setTransactionId(String? val) => transactionId = val;
  // bool hasTransactionId() => transactionId != null;
  //
  // // payment_intent_client_secret
  // String? paymentIntentClientSecret;
  // String getPaymentIntentClientSecret() => paymentIntentClientSecret ?? '';
  // setPaymentIntentClientSecret(String? val) => paymentIntentClientSecret = val;
  // bool hasPaymentIntentClientSecret() => paymentIntentClientSecret != null;

  // "tap_to_pay" field
  TapToPayStruct? _tapToPay;

  TapToPayStruct get tapToPay => _tapToPay ?? TapToPayStruct();

  set tapToPay(TapToPayStruct? val) => _tapToPay = val;

  bool hasTapToPay() => _tapToPay != null;

  // "terminal" field
  TerminalStruct? _terminal;

  TerminalStruct get terminal => _terminal ?? TerminalStruct();

  set terminal(TerminalStruct? val) => _terminal = val;

  bool hasTerminal() => _terminal != null;

  static TapToPayDataStruct fromMap(Map<String, dynamic> data) =>
      TapToPayDataStruct(
        posTransactionId: data['pos_transaction_id'] as int?,
        hash: data['hash'] as String?,
        tapToPay: data['tap_to_pay'] != null &&
                data['tap_to_pay']?.isEmpty == false
            ? TapToPayStruct.fromMap(data['tap_to_pay'] as Map<String, dynamic>)
            : null,
        terminal: data['terminal'] != null && data['terminal']?.isEmpty == false
            ? TerminalStruct.fromMap(data['terminal'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toMap() => {
        'pos_transaction_id': posTransactionId,
        'hash': hash,
        'tap_to_pay': _tapToPay?.toMap(),
        'terminal': _terminal?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() {
    return {
      'pos_transaction_id': serializeParam(
        posTransactionId,
        ParamType.int,
      ),
      'hash': serializeParam(
        hash,
        ParamType.String,
      ),
      'tap_to_pay': serializeParam(
        _tapToPay,
        ParamType.DataStruct,
      ),
      'terminal': serializeParam(
        _terminal,
        ParamType.DataStruct,
      ),
    }.withoutNulls;
  }

  static TapToPayDataStruct? maybeFromMap(data) {
    return data is Map<String, dynamic>
        ? TapToPayDataStruct.fromMap(data)
        : null;
  }
}

// ---------- TapToPay Struct ----------
class TapToPayStruct extends BaseStruct {
  TapToPayStruct({
    String? token,
    String? clientSecret,
  })  : _token = token,
        _clientSecret = clientSecret;

  String? _token;

  String get token => _token ?? '';

  set token(String? val) => _token = val;

  bool hasToken() => _token != null;

  String? _clientSecret;

  String get clientSecret => _clientSecret ?? '';

  set clientSecret(String? val) => _clientSecret = val;

  bool hasClientSecret() => _clientSecret != null;

  static TapToPayStruct fromMap(Map<String, dynamic> data) => TapToPayStruct(
        token: data['token'] as String?,
        clientSecret: data['client_secret'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'token': _token,
        'client_secret': _clientSecret,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() {
    return {
      'token': serializeParam(
        _token,
        ParamType.String,
      ),
      'client_secret': serializeParam(
        _clientSecret,
        ParamType.String,
      ),
    }.withoutNulls;
  }
}

// ---------- Terminal Struct ----------
class TerminalStruct extends BaseStruct {
  TerminalStruct({TerminalConnectionStruct? connections, String? location})
      : _connections = connections,
        _location = location;

  TerminalConnectionStruct? _connections;

  TerminalConnectionStruct get connections =>
      _connections ?? TerminalConnectionStruct();

  set connections(TerminalConnectionStruct? val) => _connections = val;

  bool hasConnections() => _connections != null;

  String? _location;

  String get location => _location ?? '';

  set location(String? val) => _location = val;

  bool hasLocation() => _location != null;

  static TerminalStruct fromMap(Map<String, dynamic> data) => TerminalStruct(
      connections: data['connections'] != null
          ? TerminalConnectionStruct.fromMap(
              data['connections'] as Map<String, dynamic>)
          : null,
      location: data['location']);

  Map<String, dynamic> toMap() => {
        'connections': _connections?.toMap(),
        'location': _location
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() {
    return {
      'connections': serializeParam(
        _connections,
        ParamType.DataStruct,
      ),
      'location': serializeParam(_location, ParamType.String)
    }.withoutNulls;
  }

  static TerminalStruct? maybeFromMap(dynamic jsonBody) {
    log("TerminalStruct jsonBody: ${TerminalStruct.fromMap(jsonBody).location}");
    return jsonBody is Map<String, dynamic>
        ? TerminalStruct.fromMap(jsonBody)
        : null;
  }
}

// ---------- Terminal Connection Struct ----------
class TerminalConnectionStruct extends BaseStruct {
  TerminalConnectionStruct({
    String? object,
    String? secret,
  })  : _object = object,
        _secret = secret;

  String? _object;

  String get object => _object ?? '';

  set object(String? val) => _object = val;

  bool hasObject() => _object != null;

  String? _secret;

  String get secret => _secret ?? '';

  set secret(String? val) => _secret = val;

  bool hasSecret() => _secret != null;

  static TerminalConnectionStruct fromMap(Map<String, dynamic> data) =>
      TerminalConnectionStruct(
        object: data['object'] as String?,
        secret: data['secret'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'object': _object,
        'secret': _secret,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() {
    return {
      'object': serializeParam(
        _object,
        ParamType.String,
      ),
    };
  }
}
