import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TransactionStruct extends BaseStruct {
  TransactionStruct({
    String? transactionId,
    String? hash,
    String? status,
    double? amount,
    String? currency,
    int? eventId,
    List<dynamic>? charges,
  })
      : _transactionId = transactionId,
        _hash = hash,
        _status = status,
        _amount = amount,
        _currency = currency,
        _eventId = eventId,
        _charges = charges;

// "transaction_id" field
  String? _transactionId;

  String get transactionId => _transactionId ?? '';

  set transactionId(String? val) => _transactionId = val;

  bool hasTransactionId() => _transactionId != null;

// "hash" field
  String? _hash;

  String get hash => _hash ?? '';

  set hash(String? val) => _hash = val;

  bool hasHash() => _hash != null;

// "status" field
  String? _status;

  String get status => _status ?? '';

  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

// "amount" field
  double? _amount;

  double get amount => _amount ?? 0.0;

  set amount(double? val) => _amount = val;

  bool hasAmount() => _amount != null;

// "currency" field
  String? _currency;

  String get currency => _currency ?? '';

  set currency(String? val) => _currency = val;

  bool hasCurrency() => _currency != null;

// "event_id" field
  int? _eventId;

  int get eventId => _eventId ?? 0;

  set eventId(int? val) => _eventId = val;

  bool hasEventId() => _eventId != null;

// "charges" field
  List<dynamic>? _charges;

  List<dynamic> get charges => _charges ?? [];

  set charges(List<dynamic>? val) => _charges = val;

  bool hasCharges() => _charges != null && _charges!.isNotEmpty;

  static TransactionStruct fromMap(Map<String, dynamic> data) =>
      TransactionStruct(
        transactionId: data['transaction_id'] as String?,
        hash: data['hash'] as String?,
        status: data['status'] as String?,
        amount: (data['amount'] as num?)?.toDouble(),
        currency: data['currency'] as String?,
        eventId: data['event_id'] as int?,
        charges: data['charges'] as List?,
      );

  static TransactionStruct? maybeFromMap(dynamic data) {
    return data is Map<String, dynamic>
        ? TransactionStruct.fromMap(data)
        : null;
  }

  Map<String, dynamic> toMap() =>
      {
        'transaction_id': _transactionId,
        'hash': _hash,
        'status': _status,
        'amount': _amount,
        'currency': _currency,
        'event_id': _eventId,
        'charges': _charges,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() {
    return {
      'transaction_id': serializeParam(_transactionId, ParamType.String),
      'hash': serializeParam(_hash, ParamType.String),
      'status': serializeParam(_status, ParamType.String),
      'amount': serializeParam(_amount, ParamType.double),
      'currency': serializeParam(_currency, ParamType.String),
      'event_id': serializeParam(_eventId, ParamType.int),
      // 'charges': serializeParam(_charges, ParamType., true),
    }.withoutNulls;
  }
}