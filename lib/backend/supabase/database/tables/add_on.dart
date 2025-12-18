import '../database.dart';
import 'add_on-description.dart';
import 'images.dart';

class AddOnTable extends SupabaseTable<AddOnRow> {
  @override
  String get tableName => 'add_on_view'; // matches your SQL view

  @override
  AddOnRow createRow(Map<String, dynamic> data) => AddOnRow(data);
}

class AddOnRow extends SupabaseDataRow {
  AddOnRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AddOnTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get addonId => getField<int>('addon_id')!;
  set addonId(int value) => setField<int>('addon_id', value);

  int get eventId => getField<int>('event_id')!;
  set eventId(int value) => setField<int>('event_id', value);

  double get price => getField<double>('price')!;
  set price(double value) => setField<double>('price', value);

  int get status => getField<int>('status')!;
  set status(int value) => setField<int>('status', value);
String get attendeeAddOnId => getField<String>('attendee_add_on_id').toString();
  set attendeeAddOnId(String value) => setField<String>('attendee_add_on_id', value);

  int? get imageId => getField<int>('image_id');
  set imageId(int? value) => setField<int?>('image_id', value);

  String? get imageUrl => getField<String>('image_url');
  set imageUrl(String? value) => setField<String?>('image_url', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String?>('name', value);

  String? get lang => getField<String>('lang');
  set lang(String? value) => setField<String?>('lang', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String?>('description', value);
}

