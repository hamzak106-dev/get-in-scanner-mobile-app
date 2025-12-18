// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PinTicketStruct extends BaseStruct {
  PinTicketStruct({
    int? ticketId,
    String? ticketName,
    bool? isSelected,
  })  : _ticketId = ticketId,
        _ticketName = ticketName,
        _isSelected = isSelected;

  // "ticket_id" field.
  int? _ticketId;
  int get ticketId => _ticketId ?? 0;
  set ticketId(int? val) => _ticketId = val;

  void incrementTicketId(int amount) => ticketId = ticketId + amount;

  bool hasTicketId() => _ticketId != null;

  // "ticket_name" field.
  String? _ticketName;
  String get ticketName => _ticketName ?? '';
  set ticketName(String? val) => _ticketName = val;

  bool hasTicketName() => _ticketName != null;

  // "is_selected" field.
  bool? _isSelected;
  bool get isSelected => _isSelected ?? false;
  set isSelected(bool? val) => _isSelected = val;

  bool hasIsSelected() => _isSelected != null;

  static PinTicketStruct fromMap(Map<String, dynamic> data) => PinTicketStruct(
        ticketId: castToType<int>(data['ticket_id']),
        ticketName: data['ticket_name'] as String?,
        isSelected: data['is_selected'] as bool?,
      );

  static PinTicketStruct? maybeFromMap(dynamic data) => data is Map
      ? PinTicketStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'ticket_id': _ticketId,
        'ticket_name': _ticketName,
        'is_selected': _isSelected,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'ticket_id': serializeParam(
          _ticketId,
          ParamType.int,
        ),
        'ticket_name': serializeParam(
          _ticketName,
          ParamType.String,
        ),
        'is_selected': serializeParam(
          _isSelected,
          ParamType.bool,
        ),
      }.withoutNulls;

  static PinTicketStruct fromSerializableMap(Map<String, dynamic> data) =>
      PinTicketStruct(
        ticketId: deserializeParam(
          data['ticket_id'],
          ParamType.int,
          false,
        ),
        ticketName: deserializeParam(
          data['ticket_name'],
          ParamType.String,
          false,
        ),
        isSelected: deserializeParam(
          data['is_selected'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'PinTicketStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PinTicketStruct &&
        ticketId == other.ticketId &&
        ticketName == other.ticketName &&
        isSelected == other.isSelected;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([ticketId, ticketName, isSelected]);
}

PinTicketStruct createPinTicketStruct({
  int? ticketId,
  String? ticketName,
  bool? isSelected,
}) =>
    PinTicketStruct(
      ticketId: ticketId,
      ticketName: ticketName,
      isSelected: isSelected,
    );
