import 'dart:convert';

import '../database.dart';
import 'add_on_view.dart';

class AttendeeTable extends SupabaseTable<AttendeeRow> {
  @override
  String get tableName => 'attendee';

  @override
  AttendeeRow createRow(Map<String, dynamic> data) => AttendeeRow(data);
}

class AttendeeRow extends SupabaseDataRow {
  AttendeeRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AttendeeTable();

  int get uid => getField<int>('uid')!;

  set uid(int value) => setField<int>('uid', value);

  int get eventId => getField<int>('event_id')!;

  set eventId(int value) => setField<int>('event_id', value);

  int get purchaseId => getField<int>('purchase_id')!;

  set purchaseId(int value) => setField<int>('purchase_id', value);

  int get ticketId => getField<int>('ticket_id')!;

  set ticketId(int value) => setField<int>('ticket_id', value);

  String get ticketName => getField<String>('ticket_name')!;

  set ticketName(String value) => setField<String>('ticket_name', value);

  String? get ticketHash => getField<String>('ticket_hash');

  set ticketHash(String? value) => setField<String>('ticket_hash', value);

  int get ticketType => getField<int>('ticket_type')!;

  set ticketType(int value) => setField<int>('ticket_type', value);

  int get ticketStatus => getField<int>('ticket_status')!;

  set ticketStatus(int value) => setField<int>('ticket_status', value);

  String? get name => getField<String>('name');

  set name(String? value) => setField<String>('name', value);

  String? get email => getField<String>('email');

  set email(String? value) => setField<String>('email', value);

  String? get phone => getField<String>('phone');

  set phone(String? value) => setField<String>('phone', value);

  String? get status => getField<String>('status');

  set status(String? value) => setField<String>('status', value);

  int get id => getField<int>('id')!;

  set id(int value) => setField<int>('id', value);

  int get transactionNumber => getField<int>('transaction_number')!;

  set transactionNumber(int value) =>
      setField<int>('transaction_number', value);

  bool get isCsvRecord => getField<bool>('is_csv_record')!;

  set isCsvRecord(bool value) => setField<bool>('is_csv_record', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');

  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);

  String? get lastUpdate => getField<String>('last_update');

  set lastUpdate(String? value) => setField<String>('last_update', value);

  String? get profileImg => getField<String>('profile_img');

  set profileImg(String? value) => setField<String>('profile_img', value);

  bool get statusUpdate => getField<bool>('status_update')??false;

  set statusUpdate(bool value) => setField<bool>('status_update', value);

  String? get ticketComment => getField<String>('ticket_comment');

  set ticketComment(String? value) => setField<String>('ticket_comment', value);

  String? get remark => getField<String>('remark');

  set remark(String? value) => setField<String>('remark', value);

  String? get seatRow => getField<String>('seat_row');

  set seatRow(String? value) => setField<String>('seat_row', value);

  String? get seatSeat => getField<String>('seat_seat');

  set seatSeat(String? value) => setField<String>('seat_seat', value);

  String? get seatSection => getField<String>('seat_section');

  set seatSection(String? value) => setField<String>('seat_section', value);

  String? get seatTable => getField<String>('seat_table');

  set seatTable(String? value) => setField<String>('seat_table', value);

  int? get userId => getField<int>('user_id');

  set userId(int? value) => setField<int>('user_id', value);

  DateTime? get superUpdatedAt => getField<DateTime>('super_updated_at');

  set superUpdatedAt(DateTime? value) =>
      setField<DateTime>('super_updated_at', value);

  int? get salesmanId => getField<int>('salesman_id');

  set salesmanId(int? value) => setField<int>('salesman_id', value);

  String? get sellerName => getField<String>('seller_name');

  set sellerName(String? value) => setField<String>('seller_name', value);

  List<int> get managerIds => getListField<int>('manager_ids');

  set managerIds(List<int>? value) => setListField<int>('manager_ids', value);

  DateTime? get defragAt => getField<DateTime>('defrag_at');

  set defragAt(DateTime? value) => setField<DateTime>('defrag_at', value);

  List<AddOnRow> addOns = [];


  void addOnsList(List<AddOnRow> value) {
    addOns = value;
  }

  void setAddOns(List<Map<String, dynamic>> data) {
    addOns =
        data.map((e) => AddOnRow(Map<String, dynamic>.from(e))).toList();
  }

  static AttendeeRow mapAttendeeWithAddons(Map<String, dynamic> rowData)
  {
    final attendee = AttendeeRow(Map<String, dynamic>.from(rowData));

    // ✅ Parse JSON "add_ons" into List<AddOnViewRow>
    if (rowData['add_ons'] != null) {
      try {
        final raw = rowData['add_ons'];
        final list = raw is String
            ? List<Map<String, dynamic>>.from(jsonDecode(raw))
            : List<Map<String, dynamic>>.from(raw);
        attendee.setAddOns(list);
      } catch (e) {
        print('⚠️ Failed to parse add_ons: $e');
        attendee.setAddOns([]);
      }
    }
    return attendee;
  }

}
