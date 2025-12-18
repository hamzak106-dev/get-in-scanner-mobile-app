import 'dart:developer';

import 'package:shorebird_code_push/shorebird_code_push.dart'
    show ShorebirdUpdater, UpdateException, UpdateStatus;

void checkForUpdates() async {
  final updater = ShorebirdUpdater();
  final status = await updater.checkForUpdate();

  if (status == UpdateStatus.outdated) {
    try {
      await updater.update();
    } on UpdateException catch (error) {
      log('Error during update: $error');
    }
  }
}
