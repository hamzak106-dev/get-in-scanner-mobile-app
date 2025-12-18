import 'package:g_e_t_i_n_scanner/custom_code/actions/init_power_sync.dart';
import 'package:sqlite3/src/result_set.dart';

class PowerSyncHelper {
  static final PowerSyncHelper _instance = PowerSyncHelper._internal();
  factory PowerSyncHelper() => _instance;
  PowerSyncHelper._internal();

  // Generic query method
  Future<List<Map<String, dynamic>>> query(String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    String sql = 'SELECT * FROM $table';
    
    if (where != null) {
      sql += ' WHERE $where';
    }
    
    if (orderBy != null) {
      sql += ' ORDER BY $orderBy';
    }
    
    if (limit != null) {
      sql += ' LIMIT $limit';
    }
    
    if (offset != null) {
      sql += ' OFFSET $offset';
    }

    return await db.getAll(sql, whereArgs ?? []);
  }

  // Get single record
  Future<Map<String, dynamic>?> getSingle(String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final results = await query(table, where: where, whereArgs: whereArgs, limit: 1);
    return results.isNotEmpty ? results.first : null;
  }

  // Insert record
  Future<ResultSet> insert(String table, Map<String, dynamic> data) async {
    final columns = data.keys.join(', ');
    final placeholders = List.filled(data.length, '?').join(', ');
    final values = data.values.toList();

    final sql = 'INSERT INTO $table ($columns) VALUES ($placeholders)';
    return await db.execute(sql, values);
  }

  // Update record
  Future<ResultSet> update(String table, Map<String, dynamic> data, {
    required String where,
    List<dynamic>? whereArgs,
  }) async {
    final setClause = data.keys.map((key) => '$key = ?').join(', ');
    final values = [...data.values, ...?whereArgs];

    final sql = 'UPDATE $table SET $setClause WHERE $where';
    return await db.execute(sql, values);
  }

  // Delete record
  Future<ResultSet> delete(String table, {
    required String where,
    List<dynamic>? whereArgs,
  }) async {
    final sql = 'DELETE FROM $table WHERE $where';
    return await db.execute(sql, whereArgs ?? []);
  }

  // Watch table changes
  Stream<List<Map<String, dynamic>>> watch(String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
  }) {
    String sql = 'SELECT * FROM $table';
    
    if (where != null) {
      sql += ' WHERE $where';
    }
    
    if (orderBy != null) {
      sql += ' ORDER BY $orderBy';
    }

    return db.watch(sql, parameters: whereArgs ?? []);
  }

  // Common table operations
  Future<List<Map<String, dynamic>>> getEvents({
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    return await query('events', where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> getAttendees({
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    return await query('attendee', where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> getCheckInLogs({
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    return await query('check_in_logs', where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> getPins({
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    return await query('pin', where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> getDevices({
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    return await query('device', where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> getCreators({
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    return await query('creators', where: where, whereArgs: whereArgs);
  }

  // Watch streams for each table
  Stream<List<Map<String, dynamic>>> watchEvents({
    String? where,
    List<dynamic>? whereArgs,
  }) {
    return watch('events', where: where, whereArgs: whereArgs);
  }

  Stream<List<Map<String, dynamic>>> watchAttendees({
    String? where,
    List<dynamic>? whereArgs,
  }) {
    return watch('attendee', where: where, whereArgs: whereArgs);
  }

  Stream<List<Map<String, dynamic>>> watchCheckInLogs({
    String? where,
    List<dynamic>? whereArgs,
  }) {
    return watch('check_in_logs', where: where, whereArgs: whereArgs);
  }

  Stream<List<Map<String, dynamic>>> watchPins({
    String? where,
    List<dynamic>? whereArgs,
  }) {
    return watch('pin', where: where, whereArgs: whereArgs);
  }

  Stream<List<Map<String, dynamic>>> watchDevices({
    String? where,
    List<dynamic>? whereArgs,
  }) {
    return watch('device', where: where, whereArgs: whereArgs);
  }

  Stream<List<Map<String, dynamic>>> watchCreators({
    String? where,
    List<dynamic>? whereArgs,
  }) {
    return watch('creators', where: where, whereArgs: whereArgs);
  }
} 