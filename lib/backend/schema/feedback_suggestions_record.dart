import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FeedbackSuggestionsRecord extends FirestoreRecord {
  FeedbackSuggestionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "date_time" field.
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  bool hasDateTime() => _dateTime != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  bool hasPhone() => _phone != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "app_version" field.
  String? _appVersion;
  String get appVersion => _appVersion ?? '';
  bool hasAppVersion() => _appVersion != null;

  void _initializeFields() {
    _category = snapshotData['category'] as String?;
    _message = snapshotData['message'] as String?;
    _dateTime = snapshotData['date_time'] as DateTime?;
    _email = snapshotData['email'] as String?;
    _phone = snapshotData['phone'] as String?;
    _name = snapshotData['name'] as String?;
    _appVersion = snapshotData['app_version'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('feedback_suggestions');

  static Stream<FeedbackSuggestionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FeedbackSuggestionsRecord.fromSnapshot(s));

  static Future<FeedbackSuggestionsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => FeedbackSuggestionsRecord.fromSnapshot(s));

  static FeedbackSuggestionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FeedbackSuggestionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FeedbackSuggestionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FeedbackSuggestionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FeedbackSuggestionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FeedbackSuggestionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFeedbackSuggestionsRecordData({
  String? category,
  String? message,
  DateTime? dateTime,
  String? email,
  String? phone,
  String? name,
  String? appVersion,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'category': category,
      'message': message,
      'date_time': dateTime,
      'email': email,
      'phone': phone,
      'name': name,
      'app_version': appVersion,
    }.withoutNulls,
  );

  return firestoreData;
}

class FeedbackSuggestionsRecordDocumentEquality
    implements Equality<FeedbackSuggestionsRecord> {
  const FeedbackSuggestionsRecordDocumentEquality();

  @override
  bool equals(FeedbackSuggestionsRecord? e1, FeedbackSuggestionsRecord? e2) {
    return e1?.category == e2?.category &&
        e1?.message == e2?.message &&
        e1?.dateTime == e2?.dateTime &&
        e1?.email == e2?.email &&
        e1?.phone == e2?.phone &&
        e1?.name == e2?.name &&
        e1?.appVersion == e2?.appVersion;
  }

  @override
  int hash(FeedbackSuggestionsRecord? e) => const ListEquality().hash([
        e?.category,
        e?.message,
        e?.dateTime,
        e?.email,
        e?.phone,
        e?.name,
        e?.appVersion
      ]);

  @override
  bool isValidKey(Object? o) => o is FeedbackSuggestionsRecord;
}
