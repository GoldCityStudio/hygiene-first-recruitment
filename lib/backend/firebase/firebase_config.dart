import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // For now, return web options for all platforms
    return web;
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyBW_4DPKHWq3IBLJqEGhV3NuIVkmpCLxHQ",
    authDomain: "hygiene-recruitment-cck397.firebaseapp.com",
    projectId: "hygiene-recruitment-cck397",
    storageBucket: "hygiene-recruitment-cck397.firebasestorage.app",
    messagingSenderId: "1072617552128",
    appId: "1:1072617552128:web:e791ee7cad3426a3409be5",
  );
}
