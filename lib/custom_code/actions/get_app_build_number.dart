// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/services.dart';

Future<int> getAppBuildNumber() async {
  // Add your function code here!

  try {
    final packageInfo = await PackageInfo.fromPlatform();
    final buildNumber = int.parse(packageInfo.buildNumber);
    return buildNumber;
  } on PlatformException catch (e) {
    print('Failed to get app build number: ${e.message}');
    return -1; // Return a default value or handle the error accordingly
  }
}
