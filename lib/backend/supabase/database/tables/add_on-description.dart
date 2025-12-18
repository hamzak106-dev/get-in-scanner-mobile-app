import '../database.dart';

class AddOnDescriptionTable extends SupabaseTable<AddOnDescriptionRow> {
  @override
  String get tableName => 'add_on_descriptions';

  @override
  AddOnDescriptionRow createRow(Map<String, dynamic> data) =>
      AddOnDescriptionRow(data);
}

class AddOnDescriptionRow extends SupabaseDataRow {
  AddOnDescriptionRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AddOnDescriptionTable();

  int get id => getField<int>('desc_id')!;
  set id(int value) => setField<int>('desc_id', value);

  int get addonId => getField<int>('addon_id')!;
  set addonId(int value) => setField<int>('addon_id', value);

  String get lang => getField<String>('lang')!;
  set lang(String value) => setField<String>('lang', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String?>('description', value);
}
