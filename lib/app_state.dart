import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/backend/schema/structs/index.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _hasSeenSplashPrompt = prefs.getBool('ff_hasSeenSplashPrompt') ?? false;
    });


    _safeInit(() {
      if (prefs.containsKey('ff_splashScreenStatus')) {
        _splashScreenStatus = prefs.getString('ff_splashScreenStatus') ?? 'Enabled';
      }
    });

    _safeInit(() {


      if (prefs.containsKey('ff_user')) {
        try {
          final serializedData = prefs.getString('ff_user') ?? '{}';
          _user = LoggedInModelStruct.fromSerializableMap(
              jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
      if (prefs.containsKey('ff_tapToPayTutorialDone')) {
        _tapToPayTutorialDone =
            prefs.getBool('ff_tapToPayTutorialDone') ?? _tapToPayTutorialDone;
      }
    });
    _safeInit(() {
      _hasFirstSync = prefs.getBool('ff_hasFirstSync') ?? _hasFirstSync;
    });
  }

  // Default splash screen status
  String _splashScreenStatus = 'Enabled';

  String get splashScreenStatus => _splashScreenStatus;

  set splashScreenStatus(String value) {
    _splashScreenStatus = value;
    prefs.setString('ff_splashScreenStatus', value);
    notifyListeners();
  }

  // In FFAppState
  bool _hasSeenSplashPrompt = false;

  bool get hasSeenSplashPrompt => _hasSeenSplashPrompt;

  set hasSeenSplashPrompt(bool value) {
    _hasSeenSplashPrompt = value;
    prefs.setBool('ff_hasSeenSplashPrompt', value);
  }


  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _tapToPayTutorialDone = true;

  bool get tapToPayTutorialDone => _tapToPayTutorialDone;

  set tapToPayTutorialDone(bool value) {
    _tapToPayTutorialDone = value;
    prefs.setBool('ff_tapToPayTutorialDone', value);
  }

  late SharedPreferences prefs;

  String _uuid = '';

  String get uuid => _uuid;

  set uuid(String value) {
    _uuid = value;
  }

  String _deviceName = '';

  String get deviceName => _deviceName;

  set deviceName(String value) {
    _deviceName = value;
  }

  LoggedInModelStruct _user = LoggedInModelStruct();

  LoggedInModelStruct get user => _user;

  set user(LoggedInModelStruct value) {
    _user = value;
    prefs.setString('ff_user', value.serialize());
  }

  void updateUserStruct(Function(LoggedInModelStruct) updateFn) {
    updateFn(_user);
    prefs.setString('ff_user', _user.serialize());
  }

  bool _hasFirstSync = false;

  bool get hasFirstSync => _hasFirstSync;

  set hasFirstSync(bool value) {
    _hasFirstSync = value;
    prefs.setBool('ff_hasFirstSync', value);
  }

  bool _isOnline = true;

  bool get isOnline => _isOnline;

  set isOnline(bool value) {
    _isOnline = value;
  }

  String _multicastAddress = '239.95.88.100';

  String get multicastAddress => _multicastAddress;

  set multicastAddress(String value) {
    _multicastAddress = value;
  }

  int _multicastPort = 9588;

  int get multicastPort => _multicastPort;

  set multicastPort(int value) {
    _multicastPort = value;
  }

  List<dynamic> _selectedEvent = [];

  List<dynamic> get selectedEvent => _selectedEvent;

  set selectedEvent(List<dynamic> value) {
    _selectedEvent = value;
  }

  void addToSelectedEvent(dynamic value) {
    selectedEvent.add(value);
  }

  void removeFromSelectedEvent(dynamic value) {
    selectedEvent.remove(value);
  }

  void removeAtIndexFromSelectedEvent(int index) {
    selectedEvent.removeAt(index);
  }

  void updateSelectedEventAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    selectedEvent[index] = updateFn(_selectedEvent[index]);
  }

  void insertAtIndexInSelectedEvent(int index, dynamic value) {
    selectedEvent.insert(index, value);
  }

  SyncStatusModelStruct _syncStatus = SyncStatusModelStruct();

  SyncStatusModelStruct get syncStatus => _syncStatus;

  set syncStatus(SyncStatusModelStruct value) {
    _syncStatus = value;
  }

  void updateSyncStatusStruct(Function(SyncStatusModelStruct) updateFn) {
    updateFn(_syncStatus);
  }

  UserModelStruct _selectedProducer = UserModelStruct();

  UserModelStruct get selectedProducer => _selectedProducer;

  set selectedProducer(UserModelStruct value) {
    _selectedProducer = value;
  }

  void updateSelectedProducerStruct(Function(UserModelStruct) updateFn) {
    updateFn(_selectedProducer);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}


Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
