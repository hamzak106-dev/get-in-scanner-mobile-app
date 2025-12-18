import '../database.dart';

class ImageTable extends SupabaseTable<ImageRow> {
  @override
  String get tableName => 'images';

  @override
  ImageRow createRow(Map<String, dynamic> data) => ImageRow(data);
}

class ImageRow extends SupabaseDataRow {
  ImageRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ImageTable();

  int get id => getField<int>('image_id')!; // external id
  set id(int value) => setField<int>('image_id', value);

  String get fileName => getField<String>('file_name')!;
  set fileName(String value) => setField<String>('file_name', value);

  String get fileUrl => getField<String>('file_url')!;
  set fileUrl(String value) => setField<String>('file_url', value);
}
