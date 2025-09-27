import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

List<DocumentReference>? uniqueValueShortlist(
    List<DocumentReference>? inputList) {
  // null safety
  inputList ??= [];

// Create a Set from the input list
  Set<DocumentReference> uniqueSet = Set<DocumentReference>.from(inputList);

  // Convert the Set back to a List
  List<DocumentReference> uniqueList = uniqueSet.toList();

  return uniqueList;
}

int maximumDate() {
  // get current date time, add two months, convert to unix and return
  DateTime now = DateTime.now();
  DateTime twoMonthsLater = now.add(Duration(days: 60));
  int unixTime = twoMonthsLater.millisecondsSinceEpoch ~/ 1000;
  return unixTime;
}

List<DocumentReference>? removeDocumentRefFromList(
  List<DocumentReference> documentRefs,
  DocumentReference singleDocumentRef,
) {
  // Filter out the single document from the list
  List<DocumentReference> updatedList =
      documentRefs.where((docRef) => docRef != singleDocumentRef).toList();

  return updatedList;
}

String? trimText(String input) {
  // takes input and removes white spaces at brginning and end
  return input.trim();
}

String addDimensionToFirebaseUrl(
  int dimension,
  String inputUrl,
) {
  // Split the URL into parts
  Uri uri = Uri.parse(inputUrl);
  List<String> pathSegments = uri.pathSegments;

  // Find the last path segment which represents the filename
  String filename = pathSegments.last;

  // Split the filename and extension
  List<String> filenameParts = filename.split('.');
  String name = filenameParts[0];
  String extension = filenameParts[1];

  // Insert the dimension before the extension
  String modifiedFilename = '$name\_$dimension' 'x' '$dimension.$extension';

  // Replace the last path segment with the modified filename
  pathSegments[pathSegments.length - 1] = modifiedFilename;

  // Reconstruct the URL
  String modifiedPath = pathSegments.join('/');
  String modifiedUrl = uri.replace(path: modifiedPath).toString();

  return modifiedUrl;
}
