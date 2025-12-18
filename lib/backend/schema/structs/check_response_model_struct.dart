// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CheckResponseModelStruct extends BaseStruct {
  CheckResponseModelStruct({
    OriginalModelStruct? original,
  }) : _original = original;

  // "original" field.
  OriginalModelStruct? _original;
  OriginalModelStruct get original => _original ?? OriginalModelStruct();
  set original(OriginalModelStruct? val) => _original = val;

  void updateOriginal(Function(OriginalModelStruct) updateFn) {
    updateFn(_original ??= OriginalModelStruct());
  }

  bool hasOriginal() => _original != null;

  static CheckResponseModelStruct fromMap(Map<String, dynamic> data) =>
      CheckResponseModelStruct(
        original: data['original'] is OriginalModelStruct
            ? data['original']
            : OriginalModelStruct.maybeFromMap(data['original']),
      );

  static CheckResponseModelStruct? maybeFromMap(dynamic data) => data is Map
      ? CheckResponseModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'original': _original?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'original': serializeParam(
          _original,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static CheckResponseModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CheckResponseModelStruct(
        original: deserializeStructParam(
          data['original'],
          ParamType.DataStruct,
          false,
          structBuilder: OriginalModelStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'CheckResponseModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CheckResponseModelStruct && original == other.original;
  }

  @override
  int get hashCode => const ListEquality().hash([original]);
}

CheckResponseModelStruct createCheckResponseModelStruct({
  OriginalModelStruct? original,
}) =>
    CheckResponseModelStruct(
      original: original ?? OriginalModelStruct(),
    );
