// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PinEventStruct extends BaseStruct {
  PinEventStruct({
    int? uid,
    int? eventId,
    String? title,
    int? creatorUser,
    List<PinTicketStruct>? tickets,
    bool? isSelected,
  })  : _uid = uid,
        _eventId = eventId,
        _title = title,
        _creatorUser = creatorUser,
        _tickets = tickets,
        _isSelected = isSelected;

  // "uid" field.
  int? _uid;
  int get uid => _uid ?? 0;
  set uid(int? val) => _uid = val;

  void incrementUid(int amount) => uid = uid + amount;

  bool hasUid() => _uid != null;

  // "event_id" field.
  int? _eventId;
  int get eventId => _eventId ?? 0;
  set eventId(int? val) => _eventId = val;

  void incrementEventId(int amount) => eventId = eventId + amount;

  bool hasEventId() => _eventId != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "creator_user" field.
  int? _creatorUser;
  int get creatorUser => _creatorUser ?? 0;
  set creatorUser(int? val) => _creatorUser = val;

  void incrementCreatorUser(int amount) => creatorUser = creatorUser + amount;

  bool hasCreatorUser() => _creatorUser != null;

  // "tickets" field.
  List<PinTicketStruct>? _tickets;
  List<PinTicketStruct> get tickets => _tickets ?? const [];
  set tickets(List<PinTicketStruct>? val) => _tickets = val;

  void updateTickets(Function(List<PinTicketStruct>) updateFn) {
    updateFn(_tickets ??= []);
  }

  bool hasTickets() => _tickets != null;

  // "is_selected" field.
  bool? _isSelected;
  bool get isSelected => _isSelected ?? false;
  set isSelected(bool? val) => _isSelected = val;

  bool hasIsSelected() => _isSelected != null;

  static PinEventStruct fromMap(Map<String, dynamic> data) => PinEventStruct(
        uid: castToType<int>(data['uid']),
        eventId: castToType<int>(data['event_id']),
        title: data['title'] as String?,
        creatorUser: castToType<int>(data['creator_user']),
        tickets: getStructList(
          data['tickets'],
          PinTicketStruct.fromMap,
        ),
        isSelected: data['is_selected'] as bool?,
      );

  static PinEventStruct? maybeFromMap(dynamic data) =>
      data is Map ? PinEventStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'uid': _uid,
        'event_id': _eventId,
        'title': _title,
        'creator_user': _creatorUser,
        'tickets': _tickets?.map((e) => e.toMap()).toList(),
        'is_selected': _isSelected,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'uid': serializeParam(
          _uid,
          ParamType.int,
        ),
        'event_id': serializeParam(
          _eventId,
          ParamType.int,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'creator_user': serializeParam(
          _creatorUser,
          ParamType.int,
        ),
        'tickets': serializeParam(
          _tickets,
          ParamType.DataStruct,
          isList: true,
        ),
        'is_selected': serializeParam(
          _isSelected,
          ParamType.bool,
        ),
      }.withoutNulls;

  static PinEventStruct fromSerializableMap(Map<String, dynamic> data) =>
      PinEventStruct(
        uid: deserializeParam(
          data['uid'],
          ParamType.int,
          false,
        ),
        eventId: deserializeParam(
          data['event_id'],
          ParamType.int,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        creatorUser: deserializeParam(
          data['creator_user'],
          ParamType.int,
          false,
        ),
        tickets: deserializeStructParam<PinTicketStruct>(
          data['tickets'],
          ParamType.DataStruct,
          true,
          structBuilder: PinTicketStruct.fromSerializableMap,
        ),
        isSelected: deserializeParam(
          data['is_selected'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'PinEventStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PinEventStruct &&
        uid == other.uid &&
        eventId == other.eventId &&
        title == other.title &&
        creatorUser == other.creatorUser &&
        listEquality.equals(tickets, other.tickets) &&
        isSelected == other.isSelected;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([uid, eventId, title, creatorUser, tickets, isSelected]);
}

PinEventStruct createPinEventStruct({
  int? uid,
  int? eventId,
  String? title,
  int? creatorUser,
  bool? isSelected,
}) =>
    PinEventStruct(
      uid: uid,
      eventId: eventId,
      title: title,
      creatorUser: creatorUser,
      isSelected: isSelected,
    );
