import '../database.dart';

class PinTable extends SupabaseTable<PinRow> {
  @override
  String get tableName => 'pin';

  @override
  PinRow createRow(Map<String, dynamic> data) => PinRow(data);
}

class PinRow extends SupabaseDataRow {
  PinRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PinTable();

  int get uid => getField<int>('uid')!;
  set uid(int value) => setField<int>('uid', value);

  int? get userId => getField<int>('user_id');
  set userId(int? value) => setField<int>('user_id', value);

  String get accessCode => getField<String>('access_code')!;
  set accessCode(String value) => setField<String>('access_code', value);

  int get pin => getField<int>('pin')!;
  set pin(int value) => setField<int>('pin', value);

  String get type => getField<String>('type')!;
  set type(String value) => setField<String>('type', value);

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get permissions => getField<int>('permissions') ?? 0;
  set permissions(int value) => setField<int>('permissions', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  bool? get isEnable => getField<bool>('is_enable');
  set isEnable(bool? value) => setField<bool>('is_enable', value);

  String? get eventIds => getField<String>('event_ids');
  set eventIds(String? value) => setField<String>('event_ids', value);

  String? get ticketIds => getField<String>('ticket_ids');
  set ticketIds(String? value) => setField<String>('ticket_ids', value);

  int? get createdBy => getField<int>('created_by');
  set createdBy(int? value) => setField<int>('created_by', value);

  DateTime? get defragAt => getField<DateTime>('defrag_at');
  set defragAt(DateTime? value) => setField<DateTime>('defrag_at', value);
}
