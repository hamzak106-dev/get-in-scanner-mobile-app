import '../database.dart';

class CheckInLogsTable extends SupabaseTable<CheckInLogsRow> {
  @override
  String get tableName => 'check_in_logs';

  @override
  CheckInLogsRow createRow(Map<String, dynamic> data) => CheckInLogsRow(data);
}

class CheckInLogsRow extends SupabaseDataRow {
  CheckInLogsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CheckInLogsTable();

  int get uid => getField<int>('uid')!;
  set uid(int value) => setField<int>('uid', value);

  int? get attendeeId => getField<int>('attendee_id');
  set attendeeId(int? value) => setField<int>('attendee_id', value);

  int get deviceId => getField<int>('device_id')!;
  set deviceId(int value) => setField<int>('device_id', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  DateTime? get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  DateTime? get scanAt => getField<DateTime>('scan_at');
  set scanAt(DateTime? value) => setField<DateTime>('scan_at', value);

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int? get eventId => getField<int>('event_id');
  set eventId(int? value) => setField<int>('event_id', value);

  int? get userId => getField<int>('user_id');
  set userId(int? value) => setField<int>('user_id', value);

  String? get scanResult => getField<String>('scan_result');
  set scanResult(String? value) => setField<String>('scan_result', value);

  DateTime? get defragAt => getField<DateTime>('defrag_at');
  set defragAt(DateTime? value) => setField<DateTime>('defrag_at', value);
}
