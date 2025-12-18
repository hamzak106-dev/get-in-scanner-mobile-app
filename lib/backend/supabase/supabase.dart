import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

import '../../config/flavor_helper.dart';

export 'database/database.dart';

class SupaFlow {
  SupaFlow._();

  static SupaFlow? _instance;

  static SupaFlow get instance => _instance ??= SupaFlow._();

  final _supabase = Supabase.instance.client;

  static SupabaseClient get client => instance._supabase;

  static Future initialize() => Supabase.initialize(
        url: FlavorHelper.appFlavor.sbApiUrl,
        anonKey: FlavorHelper.appFlavor.sbAnonKey,
        debug: kDebugMode,
        authOptions:
            FlutterAuthClientOptions(authFlowType: AuthFlowType.pkce),
      );
}
