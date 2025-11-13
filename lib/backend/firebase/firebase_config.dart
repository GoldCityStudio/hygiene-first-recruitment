import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyBW_4DPKHWq3IBLJqEGhV3NuIVkmpCLxHQ",
    authDomain: "hygiene-recruitment-cck397.firebaseapp.com",
    projectId: "hygiene-recruitment-cck397",
    storageBucket: "hygiene-recruitment-cck397.firebasestorage.app",
    messagingSenderId: "1072617552128",
    appId: "1:1072617552128:web:e791ee7cad3426a3409be5",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyDw10HUqUGm7F93WZxXrD60_GHrs9XRh4g",
    appId: "1:1072617552128:android:c58f31fb12cdf75e409be5",
    messagingSenderId: "1072617552128",
    projectId: "hygiene-recruitment-cck397",
    storageBucket: "hygiene-recruitment-cck397.firebasestorage.app",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyCGtmCptzMxfb9xvZQ8bO8sN3hUWQsrRhA",
    appId: "1:1072617552128:ios:7dbe122c860fe9ba409be5",
    messagingSenderId: "1072617552128",
    projectId: "hygiene-recruitment-cck397",
    storageBucket: "hygiene-recruitment-cck397.firebasestorage.app",
    iosBundleId: "com.mycompany.jobconnect",
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "AIzaSyCGtmCptzMxfb9xvZQ8bO8sN3hUWQsrRhA",
    appId: "1:1072617552128:ios:7dbe122c860fe9ba409be5",
    messagingSenderId: "1072617552128",
    projectId: "hygiene-recruitment-cck397",
    storageBucket: "hygiene-recruitment-cck397.firebasestorage.app",
    iosBundleId: "com.mycompany.jobconnect",
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: "AIzaSyBW_4DPKHWq3IBLJqEGhV3NuIVkmpCLxHQ",
    authDomain: "hygiene-recruitment-cck397.firebaseapp.com",
    projectId: "hygiene-recruitment-cck397",
    storageBucket: "hygiene-recruitment-cck397.firebasestorage.app",
    messagingSenderId: "1072617552128",
    appId: "1:1072617552128:web:e791ee7cad3426a3409be5",
  );
}
