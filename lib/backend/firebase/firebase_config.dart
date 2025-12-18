import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart' as devOptions;

Future initFirebase({bool devFlavor = false}) async {
  if(devFlavor) {
    await Firebase.initializeApp(
        options: devOptions.DefaultFirebaseOptions.currentPlatform);
  } else if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCqd34sK2mM8U8wz4EphWoM_1KYyEybL-U",
            authDomain: "scanner-dev-5489c.firebaseapp.com",
            projectId: "scanner-dev-5489c",
            storageBucket: "scanner-dev-5489c.firebasestorage.app",
            messagingSenderId: "910115388794",
            appId: "1:910115388794:web:185b9cea88a0cecde7eac3",
            measurementId: "G-7JVMLBHQ3C"));
  } else {
    await Firebase.initializeApp();
  }
}
