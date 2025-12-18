// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ExportFileStruct extends BaseStruct {
  ExportFileStruct({
    String? name,
    String? path,
    String? nameOnly,
    int? size,
    Export? export,
  })  : _name = name,
        _path = path,
        _nameOnly = nameOnly,
        _size = size,
        _export = export;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "path" field.
  String? _path;
  String get path => _path ?? '';
  set path(String? val) => _path = val;

  bool hasPath() => _path != null;

  // "nameOnly" field.
  String? _nameOnly;
  String get nameOnly => _nameOnly ?? '';
  set nameOnly(String? val) => _nameOnly = val;

  bool hasNameOnly() => _nameOnly != null;

  // "size" field.
  int? _size;
  int get size => _size ?? 0;
  set size(int? val) => _size = val;

  void incrementSize(int amount) => size = size + amount;

  bool hasSize() => _size != null;

  // "export" field.
  Export? _export;
  Export? get export => _export;
  set export(Export? val) => _export = val;

  bool hasExport() => _export != null;

  static ExportFileStruct fromMap(Map<String, dynamic> data) =>
      ExportFileStruct(
        name: data['name'] as String?,
        path: data['path'] as String?,
        nameOnly: data['nameOnly'] as String?,
        size: castToType<int>(data['size']),
        export: data['export'] is Export
            ? data['export']
            : deserializeEnum<Export>(data['export']),
      );

  static ExportFileStruct? maybeFromMap(dynamic data) => data is Map
      ? ExportFileStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'path': _path,
        'nameOnly': _nameOnly,
        'size': _size,
        'export': _export?.serialize(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'path': serializeParam(
          _path,
          ParamType.String,
        ),
        'nameOnly': serializeParam(
          _nameOnly,
          ParamType.String,
        ),
        'size': serializeParam(
          _size,
          ParamType.int,
        ),
        'export': serializeParam(
          _export,
          ParamType.Enum,
        ),
      }.withoutNulls;

  static ExportFileStruct fromSerializableMap(Map<String, dynamic> data) =>
      ExportFileStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        path: deserializeParam(
          data['path'],
          ParamType.String,
          false,
        ),
        nameOnly: deserializeParam(
          data['nameOnly'],
          ParamType.String,
          false,
        ),
        size: deserializeParam(
          data['size'],
          ParamType.int,
          false,
        ),
        export: deserializeParam<Export>(
          data['export'],
          ParamType.Enum,
          false,
        ),
      );

  @override
  String toString() => 'ExportFileStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ExportFileStruct &&
        name == other.name &&
        path == other.path &&
        nameOnly == other.nameOnly &&
        size == other.size &&
        export == other.export;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([name, path, nameOnly, size, export]);
}

ExportFileStruct createExportFileStruct({
  String? name,
  String? path,
  String? nameOnly,
  int? size,
  Export? export,
}) =>
    ExportFileStruct(
      name: name,
      path: path,
      nameOnly: nameOnly,
      size: size,
      export: export,
    );
