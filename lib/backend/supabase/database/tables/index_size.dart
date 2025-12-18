import '../database.dart';

class IndexSizeTable extends SupabaseTable<IndexSizeRow> {
  @override
  String get tableName => 'index_size';

  @override
  IndexSizeRow createRow(Map<String, dynamic> data) => IndexSizeRow(data);
}

class IndexSizeRow extends SupabaseDataRow {
  IndexSizeRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => IndexSizeTable();

  int? get pgIndexesSize => getField<int>('pg_indexes_size');
  set pgIndexesSize(int? value) => setField<int>('pg_indexes_size', value);
}
