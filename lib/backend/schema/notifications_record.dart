import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationsRecord extends FirestoreRecord {
  NotificationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "notification_type" field.
  String? _notificationType;
  String get notificationType => _notificationType ?? '';
  bool hasNotificationType() => _notificationType != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  // "is_read" field.
  bool? _isRead;
  bool get isRead => _isRead ?? false;
  bool hasIsRead() => _isRead != null;

  // "application_ref" field.
  DocumentReference? _applicationRef;
  DocumentReference? get applicationRef => _applicationRef;
  bool hasApplicationRef() => _applicationRef != null;

  // "tagged_user_ref" field.
  DocumentReference? _taggedUserRef;
  DocumentReference? get taggedUserRef => _taggedUserRef;
  bool hasTaggedUserRef() => _taggedUserRef != null;

  // "notification_sound" field.
  String? _notificationSound;
  String get notificationSound => _notificationSound ?? '';
  bool hasNotificationSound() => _notificationSound != null;

  // "target_audience" field.
  String? _targetAudience;
  String get targetAudience => _targetAudience ?? '';
  bool hasTargetAudience() => _targetAudience != null;

  // "related_job" field.
  DocumentReference? _relatedJob;
  DocumentReference? get relatedJob => _relatedJob;
  bool hasRelatedJob() => _relatedJob != null;

  // "notification_title" field.
  String? _notificationTitle;
  String get notificationTitle => _notificationTitle ?? '';
  bool hasNotificationTitle() => _notificationTitle != null;

  // "notification_text" field.
  String? _notificationText;
  String get notificationText => _notificationText ?? '';
  bool hasNotificationText() => _notificationText != null;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  bool hasContent() => _content != null;

  // "parameter_data" field.
  String? _parameterData;
  String get parameterData => _parameterData ?? '';
  bool hasParameterData() => _parameterData != null;

  // "user_refs" field.
  String? _userRefs;
  String get userRefs => _userRefs ?? '';
  bool hasUserRefs() => _userRefs != null;

  // "initial_page_name" field.
  String? _initialPageName;
  String get initialPageName => _initialPageName ?? '';
  bool hasInitialPageName() => _initialPageName != null;

  // "recipient" field.
  List<String>? _recipient;
  List<String> get recipient => _recipient ?? const [];
  bool hasRecipient() => _recipient != null;

  // "tagged_company_ref" field.
  DocumentReference? _taggedCompanyRef;
  DocumentReference? get taggedCompanyRef => _taggedCompanyRef;
  bool hasTaggedCompanyRef() => _taggedCompanyRef != null;

  // "time_to_live" field.
  DateTime? _timeToLive;
  DateTime? get timeToLive => _timeToLive;
  bool hasTimeToLive() => _timeToLive != null;

  void _initializeFields() {
    _notificationType = snapshotData['notification_type'] as String?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _isRead = snapshotData['is_read'] as bool?;
    _applicationRef = snapshotData['application_ref'] as DocumentReference?;
    _taggedUserRef = snapshotData['tagged_user_ref'] as DocumentReference?;
    _notificationSound = snapshotData['notification_sound'] as String?;
    _targetAudience = snapshotData['target_audience'] as String?;
    _relatedJob = snapshotData['related_job'] as DocumentReference?;
    _notificationTitle = snapshotData['notification_title'] as String?;
    _notificationText = snapshotData['notification_text'] as String?;
    _content = snapshotData['content'] as String?;
    _parameterData = snapshotData['parameter_data'] as String?;
    _userRefs = snapshotData['user_refs'] as String?;
    _initialPageName = snapshotData['initial_page_name'] as String?;
    _recipient = getDataList(snapshotData['recipient']);
    _taggedCompanyRef =
        snapshotData['tagged_company_ref'] as DocumentReference?;
    _timeToLive = snapshotData['time_to_live'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('notifications');

  static Stream<NotificationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotificationsRecord.fromSnapshot(s));

  static Future<NotificationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotificationsRecord.fromSnapshot(s));

  static NotificationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotificationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotificationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotificationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotificationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotificationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotificationsRecordData({
  String? notificationType,
  DateTime? timestamp,
  bool? isRead,
  DocumentReference? applicationRef,
  DocumentReference? taggedUserRef,
  String? notificationSound,
  String? targetAudience,
  DocumentReference? relatedJob,
  String? notificationTitle,
  String? notificationText,
  String? content,
  String? parameterData,
  String? userRefs,
  String? initialPageName,
  DocumentReference? taggedCompanyRef,
  DateTime? timeToLive,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'notification_type': notificationType,
      'timestamp': timestamp,
      'is_read': isRead,
      'application_ref': applicationRef,
      'tagged_user_ref': taggedUserRef,
      'notification_sound': notificationSound,
      'target_audience': targetAudience,
      'related_job': relatedJob,
      'notification_title': notificationTitle,
      'notification_text': notificationText,
      'content': content,
      'parameter_data': parameterData,
      'user_refs': userRefs,
      'initial_page_name': initialPageName,
      'tagged_company_ref': taggedCompanyRef,
      'time_to_live': timeToLive,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotificationsRecordDocumentEquality
    implements Equality<NotificationsRecord> {
  const NotificationsRecordDocumentEquality();

  @override
  bool equals(NotificationsRecord? e1, NotificationsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.notificationType == e2?.notificationType &&
        e1?.timestamp == e2?.timestamp &&
        e1?.isRead == e2?.isRead &&
        e1?.applicationRef == e2?.applicationRef &&
        e1?.taggedUserRef == e2?.taggedUserRef &&
        e1?.notificationSound == e2?.notificationSound &&
        e1?.targetAudience == e2?.targetAudience &&
        e1?.relatedJob == e2?.relatedJob &&
        e1?.notificationTitle == e2?.notificationTitle &&
        e1?.notificationText == e2?.notificationText &&
        e1?.content == e2?.content &&
        e1?.parameterData == e2?.parameterData &&
        e1?.userRefs == e2?.userRefs &&
        e1?.initialPageName == e2?.initialPageName &&
        listEquality.equals(e1?.recipient, e2?.recipient) &&
        e1?.taggedCompanyRef == e2?.taggedCompanyRef &&
        e1?.timeToLive == e2?.timeToLive;
  }

  @override
  int hash(NotificationsRecord? e) => const ListEquality().hash([
        e?.notificationType,
        e?.timestamp,
        e?.isRead,
        e?.applicationRef,
        e?.taggedUserRef,
        e?.notificationSound,
        e?.targetAudience,
        e?.relatedJob,
        e?.notificationTitle,
        e?.notificationText,
        e?.content,
        e?.parameterData,
        e?.userRefs,
        e?.initialPageName,
        e?.recipient,
        e?.taggedCompanyRef,
        e?.timeToLive
      ]);

  @override
  bool isValidKey(Object? o) => o is NotificationsRecord;
}
