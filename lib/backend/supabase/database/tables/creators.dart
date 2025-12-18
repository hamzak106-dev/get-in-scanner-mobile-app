import '../database.dart';

class CreatorsTable extends SupabaseTable<CreatorsRow> {
  @override
  String get tableName => 'creators';

  @override
  CreatorsRow createRow(Map<String, dynamic> data) => CreatorsRow(data);
}

class CreatorsRow extends SupabaseDataRow {
  CreatorsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CreatorsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get uid => getField<int>('uid')!;
  set uid(int value) => setField<int>('uid', value);

  int get userId => getField<int>('user_id')!;
  set userId(int value) => setField<int>('user_id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  String? get refreshToken => getField<String>('refresh_token');
  set refreshToken(String? value) => setField<String>('refresh_token', value);

  String? get sessionToken => getField<String>('session_token');
  set sessionToken(String? value) => setField<String>('session_token', value);

  String? get phoneCountryCode => getField<String>('phone_country_code');
  set phoneCountryCode(String? value) =>
      setField<String>('phone_country_code', value);

  String? get phone => getField<String>('phone');
  set phone(String? value) => setField<String>('phone', value);

  String? get profileImg => getField<String>('profile_img');
  set profileImg(String? value) => setField<String>('profile_img', value);

  int? get followerCounter => getField<int>('follower_counter');
  set followerCounter(int? value) => setField<int>('follower_counter', value);

  int? get isManager => getField<int>('isManager');
  set isManager(int? value) => setField<int>('isManager', value);

  DateTime? get defragAt => getField<DateTime>('defrag_at');
  set defragAt(DateTime? value) => setField<DateTime>('defrag_at', value);
}
