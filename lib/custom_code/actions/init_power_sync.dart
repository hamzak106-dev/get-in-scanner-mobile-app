// Automatic FlutterFlow imports
import 'dart:async';
import 'dart:math' show min;

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:g_e_t_i_n_scanner/backend/schema/enums/enums.dart';
import 'package:path/path.dart';
// Imports custom functions

import 'package:path_provider/path_provider.dart';
import 'package:powersync/powersync.dart' as powersync;
import 'package:supabase_flutter/supabase_flutter.dart';

import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_util.dart';
import '../../config/flavor_helper.dart';
import 'index.dart'; // Imports other custom actions

/**************************************************************

    POWERSYNC SETUP INSTRUCTIONS

    // Paste your PowerSync Client Schema here.
    // We recommend generating this from the dashboard using the "Generate client-side schema" action
    // See docs https://docs.powersync.com/usage/tools/powersync-dashboard#actions

    // NB: You need to prefix all Schema, Table, Column and Index calls with "powersync." due to a FF limitation

 **************************************************************/

const powersync.Schema schema = powersync.Schema([
  powersync.Table('events', [
    powersync.Column.integer('uid'),
    powersync.Column.integer('event_id'),
    powersync.Column.text('title'),
    powersync.Column.text('start_date'),
    powersync.Column.text('end_date'),
    powersync.Column.text('address'),
    powersync.Column.integer('creator_user'),
    powersync.Column.text('access_code'),
    powersync.Column.integer('total_attendees'),
    powersync.Column.integer('pin'),
    powersync.Column.text('sync_status'),
    powersync.Column.text('manager_ids'),
    powersync.Column.integer('priority'),
    powersync.Column.text('city'),
    powersync.Column.text('event_image'),
    powersync.Column.text('is_available_pos'),
  ]),
  powersync.Table('attendee', [
    powersync.Column.integer('uid'),
    powersync.Column.integer('event_id'),
    powersync.Column.integer('purchase_id'),
    powersync.Column.integer('transaction_number'),
    powersync.Column.integer('ticket_id'),
    powersync.Column.text('ticket_name'),
    powersync.Column.text('ticket_hash'),
    powersync.Column.integer('ticket_type'),
    powersync.Column.integer('ticket_status'),
    powersync.Column.text('name'),
    powersync.Column.text('email'),
    powersync.Column.text('phone'),
    powersync.Column.text('profile_img'),
    powersync.Column.text('status'),
    powersync.Column.integer('is_csv_record'),
    powersync.Column.text('updated_at'),
    powersync.Column.text('ticket_comment'),
    powersync.Column.text('remark'),
    powersync.Column.text('seat_row'),
    powersync.Column.text('seat_seat'),
    powersync.Column.text('seat_section'),
    powersync.Column.text('seat_table'),
    powersync.Column.integer('user_id'),
    powersync.Column.text('manager_ids'),
    powersync.Column.integer('salesman_id'),
    powersync.Column.text('seller_name')
  ]),
  powersync.Table('attendee_add_ons', [
    powersync.Column.integer('addon_id'),
    powersync.Column.integer('attendee_uid'),
    powersync.Column.integer('status'), // default 0 in Postgres
    powersync.Column.integer('event_id'),
  ]),
  powersync.Table('add_ons', [
    powersync.Column.integer('addon_id'), // external unique ID
    powersync.Column.integer('event_id'),
    powersync.Column.text('price'), // store decimal as text
    powersync.Column.integer('status'),
    powersync.Column.text('image_url'),
  ]),
  powersync.Table('add_on_descriptions', [
    // powersync.Column.integer('desc_id'), // external unique ID
    powersync.Column.integer('addon_id'),
    powersync.Column.text('lang'),
    powersync.Column.text('name'),
    powersync.Column.text('description'),
  ]),
  powersync.Table('check_in_logs', [
    powersync.Column.integer('uid'),
    powersync.Column.integer('attendee_id'),
    powersync.Column.integer('device_id'),
    powersync.Column.text('status'),
    powersync.Column.text('created_at'),
    powersync.Column.text('scan_at'),
    powersync.Column.integer('event_id'),
    powersync.Column.integer('user_id'),
    powersync.Column.text('scan_result')
  ]),
  powersync.Table('pin', [
    powersync.Column.integer('uid'),
    powersync.Column.integer('user_id'),
    powersync.Column.text('access_code'),
    powersync.Column.integer('pin'),
    powersync.Column.text('type'),
    powersync.Column.integer('permissions'),
    powersync.Column.text('name'),
    powersync.Column.integer('is_enable'),
    powersync.Column.text('event_ids'),
    powersync.Column.text('ticket_ids'),
    powersync.Column.integer('created_by')
  ]),
  powersync.Table('device', [
    powersync.Column.integer('uid'),
    powersync.Column.text('sync_status'),
    powersync.Column.integer('pin_id'),
    powersync.Column.text('version'),
    powersync.Column.text('name'),
    powersync.Column.text('last_sync'),
    powersync.Column.integer('successful_scan'),
    powersync.Column.integer('failed_scan'),
    powersync.Column.integer('total_scan'),
    powersync.Column.text('device_id'),
    powersync.Column.integer('isAdmin'),
    powersync.Column.text('updated_at'),
    powersync.Column.integer('user_id'),
    powersync.Column.integer('tap_to_pay_enabled')
  ]),
  powersync.Table('creators', [
    powersync.Column.integer('uid'),
    powersync.Column.integer('user_id'),
    powersync.Column.text('name'),
    powersync.Column.text('email'),
    powersync.Column.text('refresh_token'),
    powersync.Column.text('session_token'),
    powersync.Column.text('phone_country_code'),
    powersync.Column.text('phone'),
    powersync.Column.text('profile_img'),
    powersync.Column.integer('follower_counter'),
    powersync.Column.integer('isProducer')
  ])
]);
/**************************************************************
    END POWERSYNC SETUP

 **************************************************************/

// const PowerSyncEndpoint = FFAppConstants.powerSyncUrl;

late powersync.PowerSyncDatabase db;

// PowerSync status subscription + connection guards
StreamSubscription<powersync.SyncStatus>? powerSyncStatusSubscription;
bool _powerSyncIsConnecting = false;

//create one of these for each of your watch() queries
StreamSubscription eventsSubscription = Stream<void>.empty().listen((event) {});
StreamSubscription attendeesSubscription =
    Stream<void>.empty().listen((event) {});
StreamSubscription checkInLogsSubscription =
    Stream<void>.empty().listen((event) {});

StreamSubscription listsSubscription = Stream<void>.empty().listen((event) {});

StreamSubscription attendeeDetailsSubscription =
    Stream<void>.empty().listen((attendee) {});

StreamSubscription deviceSubscription =
    Stream<void>.empty().listen((device) {});

StreamSubscription pinSubscription = Stream<void>.empty().listen((pin) {});

StreamSubscription byTicketSubscription = Stream<void>.empty().listen((pin) {});

StreamSubscription byPinSubscription = Stream<void>.empty().listen((pin) {});

StreamSubscription byDeviceSubscription = Stream<void>.empty().listen((device) {});

StreamSubscription deviceDetailSubscription =
    Stream<void>.empty().listen((device) {});

StreamSubscription addonSubscription = Stream<void>.empty().listen((addon) {});
StreamSubscription addonsListSubscription =
    Stream<void>.empty().listen((addons) {});

const bool kIsWeb = bool.fromEnvironment('dart.library.js_util');

/// Postgres Response codes that we cannot recover from by retrying.
final List<RegExp> fatalResponseCodes = [
  // Class 22 — Data Exception
  // Examples include data type mismatch.
  RegExp(r'^22...$'),
  // Class 23 — Integrity Constraint Violation.
  // Examples include NOT NULL, FOREIGN KEY and UNIQUE violations.
  RegExp(r'^23...$'),
  // INSUFFICIENT PRIVILEGE - typically a row-level security violation
  RegExp(r'^42501$'),
];

class SupabaseConnector extends powersync.PowerSyncBackendConnector {
  powersync.PowerSyncDatabase db;
  Future<void>? _refreshFuture;

  SupabaseConnector(this.db);

  /// Get a Supabase token to authenticate against the PowerSync instance.
  @override
  Future<powersync.PowerSyncCredentials?> fetchCredentials() async {
    // Wait for pending session refresh if any
    await _refreshFuture;

    // Ensure Supabase is initialized before accessing client
    try {
      final session = Supabase.instance.client.auth.currentSession;
      if (session == null) {
        return null;
      }

      final token = session.accessToken;
      debugPrint('\nUser ID:\n${FFAppState().user.userId}\n\n');

      return powersync.PowerSyncCredentials(
          endpoint: FlavorHelper.appFlavor.powerSyncUrl,
          token: token,
          userId: "${FFAppState().user.userId}");
    } catch (e) {
      debugPrint('Error fetching credentials: $e');
      return null;
    }
  }

  @override
  void invalidateCredentials() {
    _refreshFuture = Supabase.instance.client.auth
        .refreshSession()
        .timeout(const Duration(seconds: 5))
        .then((response) => null, onError: (error) => null);
  }

  // Upload pending changes to Supabase.
  @override
  Future<void> uploadData(powersync.PowerSyncDatabase database) async {
    final transaction = await database.getNextCrudTransaction();
    if (transaction == null) {
      return;
    }

    final rest = Supabase.instance.client.rest;
    powersync.CrudEntry? lastOp;
    try {
      for (var op in transaction.crud) {
        lastOp = op;

        final table = rest.from(op.table);
        if (op.op == powersync.UpdateType.put) {
          var data = Map<String, dynamic>.of(op.opData!);
          await table.upsert(data);
        } else if (op.op == powersync.UpdateType.patch) {
          var data = Map<String, dynamic>.of(op.opData!);
          await table.update(data).eq('id', op.id);
        } else if (op.op == powersync.UpdateType.delete) {
          await table.delete().eq('id', op.id);
        }
      }

      await transaction.complete();
    } on PostgrestException catch (e) {
      if (e.code != null &&
          fatalResponseCodes.any((re) => re.hasMatch(e.code!))) {
        print('Data upload error - discarding $lastOp' + e.toString());
        await transaction.complete();
      } else {
        rethrow;
      }
    }
  }
}

bool isLoggedIn() {
  try {
    return Supabase.instance.client.auth.currentSession?.accessToken != null;
  } catch (e) {
    return false;
  }
}

Future initPowerSync() async {
  db = powersync.PowerSyncDatabase(
      schema: schema, path: await getDatabasePath());
  await db.initialize();

  // If the user is already logged in, attempt to connect and attach listener
  if (isLoggedIn()) {
    if (kDebugMode) debugPrint('\nPowerSync: user is logged in, attempting connect');
    var clientParam = getClientParam();
    if (kDebugMode) debugPrint('\nPowerSync clientParam: $clientParam');
    // currentConnector = SupabaseConnector(db);  // connector created inside tryConnectPowerSync

    // use guarded connect + subscription
    await tryConnectPowerSync();
  } else if (functions.checkJson(FFAppState().user.toMap())) {
    await supabaseLogin();
  }

  // Listen for auth state changes and react accordingly
  try {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
      final AuthChangeEvent event = data.event;
      if (kDebugMode) debugPrint('AuthChangeEvent ======>>> $event');

      if (event == AuthChangeEvent.signedIn) {
        // On sign-in, (re)establish connection
        await tryConnectPowerSync();
      } else if (event == AuthChangeEvent.signedOut) {
        // On sign-out, cancel listeners and clear DB
        try {
          await powerSyncStatusSubscription?.cancel();
        } catch (_) {}
        try {
          await db.disconnectAndClear();
        } catch (_) {}
      } else if (event == AuthChangeEvent.tokenRefreshed) {
        // Token rotation: let connector refresh credentials if needed, then reconnect
        try {
          // The connector may be freshly created inside tryConnectPowerSync
          await tryConnectPowerSync();
        } catch (e) {
          if (kDebugMode) debugPrint('[PowerSync] tokenRefreshed handling failed: $e');
        }
      }
    });
  } catch (e) {
    if (kDebugMode) debugPrint('Error setting up onAuthStateChange listener: $e');
  }

  return;
}

Future<String> getDatabasePath() async {
  var path = 'powersync-sqlite.db';
  if (!kIsWeb) {
    final dir = await getApplicationSupportDirectory();
    path = join(dir.path, path);
  }
  return path;
}

Map<String, dynamic> getClientParam() {
  final user = FFAppState().user;
  final userId = user.userId;

  if (user.profile != Profile.scanner) {
    return {'user_id': userId, 'type': user.profile?.name};
  }

  debugPrint("\n\n=========== PIN ============");
  debugPrint("=========== ${FFAppState().user.pinType} ============");

  if (FFAppState().user.pinType == 'SYSTEM') {
    return {'user_id': userId, 'type': user.profile?.name};
  } else {
    return {
      'user_id': userId,
      'type': 'onsite',
      'event_ids': FFAppState().user.eventIds,
    };
  }
}

Future<void> initializePowerSync() async {
  const int maxRetries = 5;
  int retryCount = 0;
  const Duration initialDelay = Duration(seconds: 2);

  while (retryCount < maxRetries) {
    try {
      await setupPowerSync();
      debugPrint('PowerSync initialized successfully.');
      break; 
    } catch (e, stackTrace) {
      retryCount++;
      debugPrint(
          'PowerSync initialization failed (Attempt: $retryCount/$maxRetries). Error: $e');
      debugPrint('StackTrace: $stackTrace');

      if (retryCount >= maxRetries) {
        debugPrint('Max retry attempts reached. Unable to initialize PowerSync.');
        rethrow; 
      }

      final delay = initialDelay * retryCount;
      await Future.delayed(delay);
    }
  }
}

Future<void> setupPowerSync() async {
  db = powersync.PowerSyncDatabase(
    schema: schema,
    path: await getDatabasePath(),
  );
  await db.initialize();
}

// Public helper: attach a resilient PowerSync status listener (reusable)
Future<void> attachPowerSyncStatusListener() async {
  try {
    await powerSyncStatusSubscription?.cancel();
  } catch (_) {}

  powerSyncStatusSubscription = db.statusStream.listen(
    (event) {
      final entries = List.of(event.priorityStatusEntries)
        ..sort((a, b) => powersync.StreamPriority.comparator(a.priority, b.priority));

      bool syncedFor(int priority) {
        return entries
            .firstWhereOrNull((e) => e.priority.priorityNumber == priority)
            ?.hasSynced ??
            false;
      }

      FFAppState().update(() {
        var syncStatus = SyncStatusModelStruct(
          hasSynced: event.uploadError == null,
          lastSync: event.lastSyncedAt,
          uploading: event.uploading,
          downloading: event.downloading,
          uploadError: event.uploadError != null,
          downloadError: event.downloadError != null,
          isConnected: event.connected,
          prioritySyncedStatus: [
            syncedFor(0),
            syncedFor(1),
            syncedFor(2),
            syncedFor(3),
          ],
        );
        if (syncStatus != FFAppState().syncStatus) {
          FFAppState().syncStatus = syncStatus;
        }
      });
    },
    onError: (Object e, StackTrace s) async {
      if (kDebugMode) debugPrint('[PowerSync] statusStream error: $e');
      final msg = e.toString();
      if (msg.contains('Connection closed while receiving data') ||
          msg.contains('ClientException') ||
          msg.contains('SocketException')) {
        // schedule reconnect with backoff
        await tryConnectPowerSync();
        if (db.connected) await attachPowerSyncStatusListener();
      } else {
        if (kDebugMode) debugPrint('[PowerSync] unexpected statusStream error: $e');
        await tryConnectPowerSync();
        if (db.connected) await attachPowerSyncStatusListener();
      }
    },
    onDone: () async {
      if (kDebugMode) debugPrint('[PowerSync] statusStream done');
      // Server closed the stream — attempt reconnect
      await tryConnectPowerSync();
      if (db.connected) await attachPowerSyncStatusListener();
    },
    cancelOnError: false,
  );
}

// Public helper: attempt a guarded connect with exponential backoff
Future<void> tryConnectPowerSync({int maxAttempts = 6}) async {
  if (!isLoggedIn()) return;
  if (_powerSyncIsConnecting) return;

  _powerSyncIsConnecting = true;
  Duration delay = const Duration(seconds: 1);
  int attempts = 0;

  while (attempts < maxAttempts && isLoggedIn()) {
    attempts++;
    try {
      if (db.connected) {
        // already connected -> ensure listener attached
        try {
          await attachPowerSyncStatusListener();
        } catch (_) {}
        break;
      }

      // ensure previous connection closed
      try {
        await db.disconnect();
      } catch (_) {}

      final connector = SupabaseConnector(db);
      await db.connect(connector: connector, params: getClientParam());

      // connected — attach listener
      try {
        await attachPowerSyncStatusListener();
      } catch (e) {
        if (kDebugMode) debugPrint('[PowerSync] attach status listener failed in tryConnectPowerSync: $e');
      }

      break;
    } catch (e) {
      if (kDebugMode) debugPrint('[PowerSync] tryConnectPowerSync attempt $attempts failed: $e');
      await Future.delayed(delay);
      delay = Duration(seconds: min(delay.inSeconds * 2, 30));
    }
  }

  _powerSyncIsConnecting = false;
}
