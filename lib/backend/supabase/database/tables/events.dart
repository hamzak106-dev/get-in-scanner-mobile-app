import 'package:g_e_t_i_n_scanner/flutter_flow/firebase_remote_config_util.dart';

import '../database.dart';

class EventsTable extends SupabaseTable<EventsRow> {
  @override
  String get tableName => 'events';

  @override
  EventsRow createRow(Map<String, dynamic> data) => EventsRow(data);
}

class EventsRow extends SupabaseDataRow {
  EventsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => EventsTable();

  int get uid => getField<int>('uid')!;
  set uid(int value) => setField<int>('uid', value);

  int get eventId => getField<int>('event_id')!;
  set eventId(int value) => setField<int>('event_id', value);

  String get title => getField<String>('title')!;
  set title(String value) => setField<String>('title', value);

  DateTime get startDate => getField<DateTime>('start_date')!;

  set startDate(DateTime value) => setField<DateTime>('start_date', value);

  DateTime get endDate => getField<DateTime>('end_date')!;
  set endDate(DateTime value) => setField<DateTime>('end_date', value);

  String get address => getField<String>('address')!;
  set address(String value) => setField<String>('address', value);

  String? get accessCode => getField<String>('access_code');
  set accessCode(String? value) => setField<String>('access_code', value);

  int? get pin => getField<int>('pin');
  set pin(int? value) => setField<int>('pin', value);

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get creatorUser => getField<int>('creator_user')!;
  set creatorUser(int value) => setField<int>('creator_user', value);

  int? get totalAttendees => getField<int>('total_attendees');
  set totalAttendees(int? value) => setField<int>('total_attendees', value);

  String get syncStatus => getField<String>('sync_status')!;
  set syncStatus(String value) => setField<String>('sync_status', value);

  int? get priority => getField<int>('priority');
  set priority(int? value) => setField<int>('priority', value);

  double get fetchedAttendees => getField<double>('fetched_attendees')!;
  set fetchedAttendees(double value) => setField<double>('fetched_attendees', value);

  String get cronStatus => getField<String>('cron_status')!;
  set cronStatus(String value) => setField<String>('cron_status', value);

  List<int> get headSellerIds => getListField<int>('head_seller_ids');
  set headSellerIds(List<int>? value) => setListField<int>('head_seller_ids', value);

  List<int> get managerIds => getListField<int>('manager_ids');
  set managerIds(List<int>? value) => setListField<int>('manager_ids', value);

  List<int> get sellerIds => getListField<int>('seller_ids');
  set sellerIds(List<int>? value) => setListField<int>('seller_ids', value);

  bool? get isLive => getField<bool>('is_live');
  set isLive(bool? value) => setField<bool>('is_live', value);

  DateTime? get defragAt => getField<DateTime>('defrag_at');
  set defragAt(DateTime? value) => setField<DateTime>('defrag_at', value);

  String? get city => getField<String>('city');
  set city(String? value) => setField<String>('city', value);

  String? get event_image => getField<String>('event_image');
  set event_image(String? value) => setField<String>('event_image', value);
}
