// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PassKeyModelStruct extends BaseStruct {
  PassKeyModelStruct({
    List<String>? accounts,
    String? identifier,
  })  : _accounts = accounts,
        _identifier = identifier;

  // "accounts" field.
  List<String>? _accounts;
  List<String> get accounts => _accounts ?? const [];
  set accounts(List<String>? val) => _accounts = val;

  void updateAccounts(Function(List<String>) updateFn) {
    updateFn(_accounts ??= []);
  }

  bool hasAccounts() => _accounts != null;

  // "identifier" field.
  String? _identifier;
  String get identifier => _identifier ?? '';
  set identifier(String? val) => _identifier = val;

  bool hasIdentifier() => _identifier != null;

  static PassKeyModelStruct fromMap(Map<String, dynamic> data) =>
      PassKeyModelStruct(
        accounts: getDataList(data['accounts']),
        identifier: data['identifier'] as String?,
      );

  static PassKeyModelStruct? maybeFromMap(dynamic data) => data is Map
      ? PassKeyModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'accounts': _accounts,
        'identifier': _identifier,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'accounts': serializeParam(
          _accounts,
          ParamType.String,
          isList: true,
        ),
        'identifier': serializeParam(
          _identifier,
          ParamType.String,
        ),
      }.withoutNulls;

  static PassKeyModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      PassKeyModelStruct(
        accounts: deserializeParam<String>(
          data['accounts'],
          ParamType.String,
          true,
        ),
        identifier: deserializeParam(
          data['identifier'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PassKeyModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PassKeyModelStruct &&
        listEquality.equals(accounts, other.accounts) &&
        identifier == other.identifier;
  }

  @override
  int get hashCode => const ListEquality().hash([accounts, identifier]);
}

PassKeyModelStruct createPassKeyModelStruct({
  String? identifier,
}) =>
    PassKeyModelStruct(
      identifier: identifier,
    );
