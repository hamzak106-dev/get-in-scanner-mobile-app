import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../config/flavor_helper.dart';

export 'database/database.dart';

class SupaFlow {
  SupaFlow._();

  static SupaFlow? _instance;

  static SupaFlow get instance => _instance ??= SupaFlow._();

  // Lazily return the Supabase client instead of capturing it during construction.
  static SupabaseClient get client => Supabase.instance.client;

  static Future initialize() => Supabase.initialize(
        url: FlavorHelper.appFlavor.sbApiUrl,
        anonKey: FlavorHelper.appFlavor.sbAnonKey,
        debug: kDebugMode,
        authOptions:
            FlutterAuthClientOptions(authFlowType: AuthFlowType.pkce),
      );
}
