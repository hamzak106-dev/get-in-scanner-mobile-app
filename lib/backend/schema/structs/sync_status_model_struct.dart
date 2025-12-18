// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SyncStatusModelStruct extends BaseStruct {
  SyncStatusModelStruct({
    DateTime? lastSync,
    bool? isConnected,
    bool? hasSynced,
    bool? uploading,
    bool? downloading,
    bool? uploadError,
    bool? downloadError,
    List<bool>? prioritySyncedStatus,
  })  : _lastSync = lastSync,
        _isConnected = isConnected,
        _hasSynced = hasSynced,
        _uploading = uploading,
        _downloading = downloading,
        _uploadError = uploadError,
        _downloadError = downloadError,
        _prioritySyncedStatus = prioritySyncedStatus;

  // "lastSync" field.
  DateTime? _lastSync;
  DateTime? get lastSync => _lastSync;
  set lastSync(DateTime? val) => _lastSync = val;

  bool hasLastSync() => _lastSync != null;

  // "isConnected" field.
  bool? _isConnected;
  bool get isConnected => _isConnected ?? false;
  set isConnected(bool? val) => _isConnected = val;

  bool hasIsConnected() => _isConnected != null;

  // "hasSynced" field.
  bool? _hasSynced;
  bool get hasSynced => _hasSynced ?? false;
  set hasSynced(bool? val) => _hasSynced = val;

  bool hasHasSynced() => _hasSynced != null;

  // "uploading" field.
  bool? _uploading;
  bool get uploading => _uploading ?? false;
  set uploading(bool? val) => _uploading = val;

  bool hasUploading() => _uploading != null;

  // "downloading" field.
  bool? _downloading;
  bool get downloading => _downloading ?? false;
  set downloading(bool? val) => _downloading = val;

  bool hasDownloading() => _downloading != null;

  // "uploadError" field.
  bool? _uploadError;
  bool get uploadError => _uploadError ?? false;
  set uploadError(bool? val) => _uploadError = val;

  bool hasUploadError() => _uploadError != null;

  // "downloadError" field.
  bool? _downloadError;
  bool get downloadError => _downloadError ?? false;
  set downloadError(bool? val) => _downloadError = val;

  bool hasDownloadError() => _downloadError != null;

  // "prioritySyncedStatus" field.
  List<bool>? _prioritySyncedStatus;
  List<bool> get prioritySyncedStatus => _prioritySyncedStatus ?? const [];
  set prioritySyncedStatus(List<bool>? val) => _prioritySyncedStatus = val;

  void updatePrioritySyncedStatus(Function(List<bool>) updateFn) {
    updateFn(_prioritySyncedStatus ??= [false, false, false, false]);
  }

  bool hasPrioritySyncedStatus() => _prioritySyncedStatus != null;

  static SyncStatusModelStruct fromMap(Map<String, dynamic> data) => SyncStatusModelStruct(
        lastSync: data['lastSync'] as DateTime?,
        isConnected: data['isConnected'] as bool?,
        hasSynced: data['hasSynced'] as bool?,
        uploading: data['uploading'] as bool?,
        downloading: data['downloading'] as bool?,
        uploadError: data['uploadError'] as bool?,
        downloadError: data['downloadError'] as bool?,
        prioritySyncedStatus: getDataList(data['prioritySyncedStatus']),
      );

  static SyncStatusModelStruct? maybeFromMap(dynamic data) =>
      data is Map ? SyncStatusModelStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'lastSync': _lastSync,
        'isConnected': _isConnected,
        'hasSynced': _hasSynced,
        'uploading': _uploading,
        'downloading': _downloading,
        'uploadError': _uploadError,
        'downloadError': _downloadError,
        'prioritySyncedStatus': _prioritySyncedStatus,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'lastSync': serializeParam(
          _lastSync,
          ParamType.DateTime,
        ),
        'isConnected': serializeParam(
          _isConnected,
          ParamType.bool,
        ),
        'hasSynced': serializeParam(
          _hasSynced,
          ParamType.bool,
        ),
        'uploading': serializeParam(
          _uploading,
          ParamType.bool,
        ),
        'downloading': serializeParam(
          _downloading,
          ParamType.bool,
        ),
        'uploadError': serializeParam(
          _uploadError,
          ParamType.bool,
        ),
        'downloadError': serializeParam(
          _downloadError,
          ParamType.bool,
        ),
        'prioritySyncedStatus': serializeParam(
          _prioritySyncedStatus,
          ParamType.bool,
          isList: true,
        ),
      }.withoutNulls;

  static SyncStatusModelStruct fromSerializableMap(Map<String, dynamic> data) => SyncStatusModelStruct(
        lastSync: deserializeParam(
          data['lastSync'],
          ParamType.DateTime,
          false,
        ),
        isConnected: deserializeParam(
          data['isConnected'],
          ParamType.bool,
          false,
        ),
        hasSynced: deserializeParam(
          data['hasSynced'],
          ParamType.bool,
          false,
        ),
        uploading: deserializeParam(
          data['uploading'],
          ParamType.bool,
          false,
        ),
        downloading: deserializeParam(
          data['downloading'],
          ParamType.bool,
          false,
        ),
        uploadError: deserializeParam(
          data['uploadError'],
          ParamType.bool,
          false,
        ),
        downloadError: deserializeParam(
          data['downloadError'],
          ParamType.bool,
          false,
        ),
        prioritySyncedStatus: deserializeParam<bool>(
          data['prioritySyncedStatus'],
          ParamType.bool,
          true,
        ),
      );

  @override
  String toString() => 'SyncStatusModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SyncStatusModelStruct &&
        lastSync == other.lastSync &&
        isConnected == other.isConnected &&
        hasSynced == other.hasSynced &&
        uploading == other.uploading &&
        downloading == other.downloading &&
        uploadError == other.uploadError &&
        downloadError == other.downloadError &&
        listEquality.equals(prioritySyncedStatus, other.prioritySyncedStatus);
  }

  @override
  int get hashCode => const ListEquality().hash(
      [lastSync, isConnected, hasSynced, uploading, downloading, uploadError, downloadError, prioritySyncedStatus]);
}

SyncStatusModelStruct createSyncStatusModelStruct({
  DateTime? lastSync,
  bool? isConnected,
  bool? hasSynced,
  bool? uploading,
  bool? downloading,
  bool? uploadError,
  bool? downloadError,
}) =>
    SyncStatusModelStruct(
      lastSync: lastSync,
      isConnected: isConnected,
      hasSynced: hasSynced,
      uploading: uploading,
      downloading: downloading,
      uploadError: uploadError,
      downloadError: downloadError,
    );
