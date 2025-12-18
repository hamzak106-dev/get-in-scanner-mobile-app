import 'dart:async';

Future cancelSubscription(StreamSubscription subscription) async {
  try {
    await subscription.cancel().timeout(
      const Duration(seconds: 1),
      onTimeout: () {
        print("SUBSCRIPTION CANCEL TIMEOUT – forced close.");
        return;
      },
    );
  } catch (e) {
    print("SUBSCRIPTION CANCEL ERROR ==>> $e");
  }
}
