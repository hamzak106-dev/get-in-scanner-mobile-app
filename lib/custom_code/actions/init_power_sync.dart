// Automatic FlutterFlow imports
import 'dart:async';

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

    // Use Supabase token for PowerSync
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) {
      // Not logged in
      return null;
    }

    // Use the access token to authenticate against PowerSync
    final token = session.accessToken;

    debugPrint('\nUser ID:\n${FFAppState().user.userId}\n\n');

    return powersync.PowerSyncCredentials(
        endpoint: FlavorHelper.appFlavor.powerSyncUrl,
        token: token,
        userId: "${FFAppState().user.userId}");
  }

  @override
  void invalidateCredentials() {
    // Trigger a session refresh if auth fails on PowerSync.
    // Generally, sessions should be refreshed automatically by Supabase.
    // However, in some cases it can be a while before the session refresh is
    // retried. We attempt to trigger the refresh as soon as we get an auth
    // failure on PowerSync.
    //
    // This could happen if the device was offline for a while and the session
    // expired, and nothing else attempt to use the session it in the meantime.
    //
    // Timeout the refresh call to avoid waiting for long retries,
    // and ignore any errors. Errors will surface as expired tokens.
    _refreshFuture = Supabase.instance.client.auth
        .refreshSession()
        .timeout(const Duration(seconds: 5))
        .then((response) => null, onError: (error) => null);
  }

  // Upload pending changes to Supabase.
  @override
  Future<void> uploadData(powersync.PowerSyncDatabase database) async {
    // This function is called whenever there is data to upload, whether the
    // device is online or offline.
    // If this call throws an error, it is retried periodically.
    final transaction = await database.getNextCrudTransaction();
    if (transaction == null) {
      return;
    }

    final rest = Supabase.instance.client.rest;
    powersync.CrudEntry? lastOp;
    try {
      // Note: If transactional consistency is important, use database functions
      // or edge functions to process the entire transaction in a single call.
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

      // All operations successful.
      await transaction.complete();
    } on PostgrestException catch (e) {
      if (e.code != null &&
          fatalResponseCodes.any((re) => re.hasMatch(e.code!))) {
        /// Instead of blocking the queue with these errors,
        /// discard the (rest of the) transaction.
        ///
        /// Note that these errors typically indicate a bug in the application.
        /// If protecting against data loss is important, save the failing records
        /// elsewhere instead of discarding, and/or notify the user.
        print('Data upload error - discarding $lastOp' + e.toString());
        await transaction.complete();
      } else {
        // Error may be retryable - e.g. network error or temporary server error.
        // Throwing an error here causes this call to be retried after a delay.
        rethrow;
      }
    }
  }
}

bool isLoggedIn() {
  return Supabase.instance.client.auth.currentSession?.accessToken != null;
}

Future initPowerSync() async {
  db = powersync.PowerSyncDatabase(
      schema: schema, path: await getDatabasePath());
  await db.initialize();

  SupabaseConnector? currentConnector;

  if (isLoggedIn()) {
    // If the user is already logged in, connect immediately.
    // Otherwise, connect once logged in.
    debugPrint(
        '\nSupabase session token:\n${Supabase.instance.client.auth.currentSession?.accessToken}');
    var clientParam = getClientParam();
    debugPrint('\nClientParam: $clientParam');
    currentConnector = SupabaseConnector(db);
    db.connect(connector: currentConnector, params: clientParam);

    db.statusStream.listen(
      (event) {
        if (kDebugMode) {
          print("=========== SYNC STATUS ============");
          print(event.toString());
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
              event.statusForPriority(powersync.BucketPriority(0)).hasSynced ??
                  false,
              event.statusForPriority(powersync.BucketPriority(1)).hasSynced ??
                  false,
              event.statusForPriority(powersync.BucketPriority(2)).hasSynced ??
                  false,
              event.statusForPriority(powersync.BucketPriority(3)).hasSynced ??
                  false,
            ],
          );
          if (syncStatus != FFAppState().syncStatus) {
            // debugPrint("\n\n=========== SYNC STATUS UPDATE============");
            FFAppState().syncStatus = syncStatus;
          }
        });
      },
    );
  } else if (functions.checkJson(FFAppState().user.toMap()) &&
      (FFAppState().user.userId != null)) {
    await supabaseLogin();
  }

  Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
    final AuthChangeEvent event = data.event;
    debugPrint("AuthChangeEvent ======>>> $event");
    if (event == AuthChangeEvent.signedIn) {
      // Connect to PowerSync when the user is signed in
      var clientParam = getClientParam();
      currentConnector = SupabaseConnector(db);
      db.connect(connector: currentConnector!, params: clientParam);

      debugPrint(
          '\nSupabase session token:\n${Supabase.instance.client.auth.currentSession?.accessToken}');
      debugPrint('\nPowerSyncUrl:\n${FlavorHelper.appFlavor.powerSyncUrl}');
      debugPrint('\nClientParam: $clientParam');

      db.statusStream.listen(
        (event) {
          // if (kDebugMode) {
          //   debugPrint("=========== SYNC STATUS ============");
          //   debugPrint(event.toString());
          // }
          var syncStatus = SyncStatusModelStruct(
            hasSynced: event.uploadError == null,
            lastSync: event.lastSyncedAt,
            uploading: event.uploading,
            downloading: event.downloading,
            uploadError: event.uploadError != null,
            downloadError: event.downloadError != null,
            isConnected: event.connected,
            prioritySyncedStatus: [
              event.statusForPriority(powersync.BucketPriority(0)).hasSynced ??
                  false,
              event.statusForPriority(powersync.BucketPriority(1)).hasSynced ??
                  false,
              event.statusForPriority(powersync.BucketPriority(2)).hasSynced ??
                  false,
              event.statusForPriority(powersync.BucketPriority(3)).hasSynced ??
                  false,
            ],
          );
          if (syncStatus != FFAppState().syncStatus) {
            // debugPrint("\n\n=========== SYNC STATUS UPDATE============");
            FFAppState().syncStatus = syncStatus;
          }
        },
      );
    } else if (event == AuthChangeEvent.signedOut) {
      // Implicit sign out - disconnect, but don't delete data
      currentConnector = null;
      await db.disconnectAndClear();
    } else if (event == AuthChangeEvent.tokenRefreshed) {
      // Supabase token refreshed - trigger token refresh for PowerSync.
      currentConnector?.prefetchCredentials();
    }
  });

  return;
}

Future<String> getDatabasePath() async {
  var path = 'powersync-sqlite.db';
  // getApplicationSupportDirectory is not supported on Web
  if (!kIsWeb) {
    final dir = await getApplicationSupportDirectory();
    path = join(dir.path, path);
  }
  return path;
}

Map<String, dynamic> getClientParam() {
  final user = FFAppState().user;
  final userId = user.userId;

  // Handle non-scanner profiles
  if (user.profile != Profile.scanner) {
    return {'user_id': userId, 'type': user.profile?.name};
  }

  // Query pin for scanner profile
  debugPrint("\n\n=========== PIN ============");
  debugPrint("=========== ${FFAppState().user.pinType} ============");

  // Return profile type for system pins
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
