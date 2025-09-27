import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CalendarEventsRecord extends FirestoreRecord {
  CalendarEventsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "startTime" field.
  DateTime? _startTime;
  DateTime? get startTime => _startTime;
  bool hasStartTime() => _startTime != null;

  // "endTime" field.
  DateTime? _endTime;
  DateTime? get endTime => _endTime;
  bool hasEndTime() => _endTime != null;

  // "isAllDay" field.
  bool? _isAllDay;
  bool get isAllDay => _isAllDay ?? false;
  bool hasIsAllDay() => _isAllDay != null;

  // "recurring" field.
  bool? _recurring;
  bool get recurring => _recurring ?? false;
  bool hasRecurring() => _recurring != null;

  // "color" field.
  int? _color;
  int get color => _color ?? 0;
  bool hasColor() => _color != null;

  // "createdBy" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  bool hasCreatedBy() => _createdBy != null;

  // "companyRef" field.
  DocumentReference? _companyRef;
  DocumentReference? get companyRef => _companyRef;
  bool hasCompanyRef() => _companyRef != null;

  // "applicationRef" field.
  DocumentReference? _applicationRef;
  DocumentReference? get applicationRef => _applicationRef;
  bool hasApplicationRef() => _applicationRef != null;

  // "jobRef" field.
  DocumentReference? _jobRef;
  DocumentReference? get jobRef => _jobRef;
  bool hasJobRef() => _jobRef != null;

  // "applicantRef" field.
  DocumentReference? _applicantRef;
  DocumentReference? get applicantRef => _applicantRef;
  bool hasApplicantRef() => _applicantRef != null;

  // "timeCreated" field.
  DateTime? _timeCreated;
  DateTime? get timeCreated => _timeCreated;
  bool hasTimeCreated() => _timeCreated != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _startTime = snapshotData['startTime'] as DateTime?;
    _endTime = snapshotData['endTime'] as DateTime?;
    _isAllDay = snapshotData['isAllDay'] as bool?;
    _recurring = snapshotData['recurring'] as bool?;
    _color = castToType<int>(snapshotData['color']);
    _createdBy = snapshotData['createdBy'] as DocumentReference?;
    _companyRef = snapshotData['companyRef'] as DocumentReference?;
    _applicationRef = snapshotData['applicationRef'] as DocumentReference?;
    _jobRef = snapshotData['jobRef'] as DocumentReference?;
    _applicantRef = snapshotData['applicantRef'] as DocumentReference?;
    _timeCreated = snapshotData['timeCreated'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('calendar_events');

  static Stream<CalendarEventsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CalendarEventsRecord.fromSnapshot(s));

  static Future<CalendarEventsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CalendarEventsRecord.fromSnapshot(s));

  static CalendarEventsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CalendarEventsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CalendarEventsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CalendarEventsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CalendarEventsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CalendarEventsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCalendarEventsRecordData({
  String? title,
  String? description,
  DateTime? startTime,
  DateTime? endTime,
  bool? isAllDay,
  bool? recurring,
  int? color,
  DocumentReference? createdBy,
  DocumentReference? companyRef,
  DocumentReference? applicationRef,
  DocumentReference? jobRef,
  DocumentReference? applicantRef,
  DateTime? timeCreated,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
      'isAllDay': isAllDay,
      'recurring': recurring,
      'color': color,
      'createdBy': createdBy,
      'companyRef': companyRef,
      'applicationRef': applicationRef,
      'jobRef': jobRef,
      'applicantRef': applicantRef,
      'timeCreated': timeCreated,
    }.withoutNulls,
  );

  return firestoreData;
} 