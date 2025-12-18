// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/services.dart';

Future soundHandler(ScanResult result) async {
  switch (result) {
    case ScanResult.NOT_FOUND:
      AudioPlayer().play(AssetSource("audios/audio_error.wav"));
      break;

    case ScanResult.USED:
      AudioPlayer().play(AssetSource("audios/audio_repeat.wav"));
      break;

    default:
      AudioPlayer().play(AssetSource("audios/audio_success.wav"));

    // case ScanResult.success:
    // break;
  }

  HapticFeedback.heavyImpact();
}
