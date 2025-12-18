import '../database.dart';

class TriggerLogsTable extends SupabaseTable<TriggerLogsRow> {
  @override
  String get tableName => 'trigger_logs';

  @override
  TriggerLogsRow createRow(Map<String, dynamic> data) => TriggerLogsRow(data);
}

class TriggerLogsRow extends SupabaseDataRow {
  TriggerLogsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TriggerLogsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get triggerName => getField<String>('trigger_name');
  set triggerName(String? value) => setField<String>('trigger_name', value);

  String? get tableNameField => getField<String>('table_name');
  set tableNameField(String? value) => setField<String>('table_name', value);

  int? get recordId => getField<int>('record_id');
  set recordId(int? value) => setField<int>('record_id', value);

  String? get oldStatus => getField<String>('old_status');
  set oldStatus(String? value) => setField<String>('old_status', value);

  String? get newStatus => getField<String>('new_status');
  set newStatus(String? value) => setField<String>('new_status', value);

  String? get httpResponse => getField<String>('http_response');
  set httpResponse(String? value) => setField<String>('http_response', value);

  DateTime? get executedAt => getField<DateTime>('executed_at');
  set executedAt(DateTime? value) => setField<DateTime>('executed_at', value);

  bool get apiSuccess => getField<bool>('api_success')!;
  set apiSuccess(bool value) => setField<bool>('api_success', value);

  int? get attendeeId => getField<int>('attendee_id');
  set attendeeId(int? value) => setField<int>('attendee_id', value);
}
