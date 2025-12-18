import '../database.dart';

class DeviceTable extends SupabaseTable<DeviceRow> {
  @override
  String get tableName => 'device';

  @override
  DeviceRow createRow(Map<String, dynamic> data) => DeviceRow(data);
}

class DeviceRow extends SupabaseDataRow {
  DeviceRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => DeviceTable();

  int get uid => getField<int>('uid')!;

  set uid(int value) => setField<int>('uid', value);

  String? get syncStatus => getField<String>('sync_status');

  set syncStatus(String? value) => setField<String>('sync_status', value);

  int get pinId => getField<int>('pin_id')!;

  set pinId(int value) => setField<int>('pin_id', value);

  String get version => getField<String>('version')!;

  set version(String value) => setField<String>('version', value);

  String get name => getField<String>('name')!;

  set name(String value) => setField<String>('name', value);

  DateTime? get lastSync => getField<DateTime>('last_sync');

  set lastSync(DateTime? value) => setField<DateTime>('last_sync', value);

  int? get successfulScan => getField<int>('successful_scan');

  set successfulScan(int? value) => setField<int>('successful_scan', value);

  int? get failedScan => getField<int>('failed_scan');

  set failedScan(int? value) => setField<int>('failed_scan', value);

  int? get totalScan => getField<int>('total_scan');

  set totalScan(int? value) => setField<int>('total_scan', value);

  String? get deviceId => getField<String>('device_id');

  set deviceId(String? value) => setField<String>('device_id', value);

  int get id => getField<int>('id')!;

  set id(int value) => setField<int>('id', value);

  bool? get isAdmin => getField<bool>('isAdmin');

  set isAdmin(bool? value) => setField<bool>('isAdmin', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');

  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);

  int? get userId => getField<int>('user_id');

  set userId(int? value) => setField<int>('user_id', value);

  DateTime? get defragAt => getField<DateTime>('defrag_at');

  set defragAt(DateTime? value) => setField<DateTime>('defrag_at', value);

  bool get tapToPayEnabled => getField<bool>('tap_to_pay_enabled') ?? false;

  set tapToPayEnabled(bool value) =>
      setField<bool>('tap_to_pay_enabled', value);
}
