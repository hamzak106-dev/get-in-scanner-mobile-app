import '../database.dart';
import 'add_on-description.dart';
import 'images.dart';

class AddOnViewTable extends SupabaseTable<AddOnViewRow> {
  @override
  String get tableName => 'add_on_view'; // matches your SQL view

  @override
  AddOnViewRow createRow(Map<String, dynamic> data) => AddOnViewRow(data);
}

class AddOnViewRow extends SupabaseDataRow {
  AddOnViewRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AddOnViewTable();

  int get addOnId => getField<int>('addon_id')!;
  set addOnId(int value) => setField<int>('addon_id', value);

  int get status => getField<int>('status')!;
  set status(int value) => setField<int>('status', value);

  String? get imageUrl => getField<String>('image_url'); // ✅ no !
  set imageUrl(String? value) => setField<String?>('image_url', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String?>('name', value);

  String? get lang => getField<String>('lang');
  set lang(String? value) => setField<String?>('lang', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String?>('description', value);
}
