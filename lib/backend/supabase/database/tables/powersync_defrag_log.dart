import '../database.dart';

class PowersyncDefragLogTable extends SupabaseTable<PowersyncDefragLogRow> {
  @override
  String get tableName => 'powersync_defrag_log';

  @override
  PowersyncDefragLogRow createRow(Map<String, dynamic> data) =>
      PowersyncDefragLogRow(data);
}

class PowersyncDefragLogRow extends SupabaseDataRow {
  PowersyncDefragLogRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PowersyncDefragLogTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get runTimestamp => getField<DateTime>('run_timestamp')!;
  set runTimestamp(DateTime value) =>
      setField<DateTime>('run_timestamp', value);

  double get durationSeconds => getField<double>('duration_seconds')!;
  set durationSeconds(double value) =>
      setField<double>('duration_seconds', value);

  int get totalRowsUpdated => getField<int>('total_rows_updated')!;
  set totalRowsUpdated(int value) => setField<int>('total_rows_updated', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
