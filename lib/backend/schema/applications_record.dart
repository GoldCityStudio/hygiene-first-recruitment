import 'dart:async';

import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ApplicationsRecord extends FirestoreRecord {
  ApplicationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "time_created" field.
  DateTime? _timeCreated;
  DateTime? get timeCreated => _timeCreated;
  bool hasTimeCreated() => _timeCreated != null;

  // "cover_letter" field.
  String? _coverLetter;
  String get coverLetter => _coverLetter ?? '';
  bool hasCoverLetter() => _coverLetter != null;

  // "job_ref" field.
  DocumentReference? _jobRef;
  DocumentReference? get jobRef => _jobRef;
  bool hasJobRef() => _jobRef != null;

  // "company_ref" field.
  DocumentReference? _companyRef;
  DocumentReference? get companyRef => _companyRef;
  bool hasCompanyRef() => _companyRef != null;

  // "attachment_url" field.
  String? _attachmentUrl;
  String get attachmentUrl => _attachmentUrl ?? '';
  bool hasAttachmentUrl() => _attachmentUrl != null;

  // "applicant_ref" field.
  DocumentReference? _applicantRef;
  DocumentReference? get applicantRef => _applicantRef;
  bool hasApplicantRef() => _applicantRef != null;

  // "application_uid" field.
  DocumentReference? _applicationUid;
  DocumentReference? get applicationUid => _applicationUid;
  bool hasApplicationUid() => _applicationUid != null;

  // "status" field.
  String? _status;
  String get status => _status ?? 'Pending';
  bool hasStatus() => _status != null;

  // "position" field.
  String? _position;
  String get position => _position ?? '';
  bool hasPosition() => _position != null;

  // "company_name" field.
  String? _companyName;
  String get companyName => _companyName ?? '';
  bool hasCompanyName() => _companyName != null;

  void _initializeFields() {
    final timeCreated = snapshotData['time_created'];
    _timeCreated = timeCreated is Timestamp ? timeCreated.toDate() : timeCreated is DateTime ? timeCreated : null;
    _coverLetter = snapshotData['cover_letter'] as String?;
    _jobRef = snapshotData['job_ref'] as DocumentReference?;
    _companyRef = snapshotData['company_ref'] as DocumentReference?;
    _attachmentUrl = snapshotData['attachment_url'] as String?;
    _applicantRef = snapshotData['applicant_ref'] as DocumentReference?;
    _applicationUid = snapshotData['application_uid'] as DocumentReference?;
    _status = snapshotData['status'] as String?;
    _position = snapshotData['position'] as String?;
    _companyName = snapshotData['company_name'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('applications');

  static Stream<ApplicationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ApplicationsRecord.fromSnapshot(s));

  static Future<ApplicationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ApplicationsRecord.fromSnapshot(s));

  static ApplicationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ApplicationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ApplicationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ApplicationsRecord._(reference, mapFromFirestore(data));

  static Map<String, dynamic> mapFromFirestore(Map<String, dynamic> data) {
    final timeCreated = data['time_created'];
    return {
      'applicant_ref': data['applicant_ref'] as DocumentReference?,
      'job_ref': data['job_ref'] as DocumentReference?,
      'status': data['status'] as String?,
      'time_created': timeCreated is Timestamp ? timeCreated.toDate() : timeCreated,
      'position': data['position'] as String?,
      'company_name': data['company_name'] as String?,
      'cover_letter': data['cover_letter'] as String?,
      'company_ref': data['company_ref'] as DocumentReference?,
      'attachment_url': data['attachment_url'] as String?,
      'application_uid': data['application_uid'] as DocumentReference?,
    };
  }

  static Map<String, dynamic> mapToFirestore(Map<String, dynamic> data) {
    final timeCreated = data['time_created'];
    return {
      'applicant_ref': data['applicant_ref'],
      'job_ref': data['job_ref'],
      'status': data['status'],
      'time_created': timeCreated is DateTime ? Timestamp.fromDate(timeCreated) : timeCreated,
      'position': data['position'],
      'company_name': data['company_name'],
      'cover_letter': data['cover_letter'],
      'company_ref': data['company_ref'],
      'attachment_url': data['attachment_url'],
      'application_uid': data['application_uid'],
    };
  }

  @override
  String toString() =>
      'ApplicationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ApplicationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createApplicationsRecordData({
  DateTime? timeCreated,
  String? coverLetter,
  DocumentReference? jobRef,
  DocumentReference? companyRef,
  String? attachmentUrl,
  DocumentReference? applicantRef,
  DocumentReference? applicationUid,
  String? status,
  String? position,
  String? companyName,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'time_created': timeCreated,
      'cover_letter': coverLetter,
      'job_ref': jobRef,
      'company_ref': companyRef,
      'attachment_url': attachmentUrl,
      'applicant_ref': applicantRef,
      'application_uid': applicationUid,
      'status': status,
      'position': position,
      'company_name': companyName,
    }.withoutNulls,
  );

  return firestoreData;
}

class ApplicationsRecordDocumentEquality
    implements Equality<ApplicationsRecord> {
  const ApplicationsRecordDocumentEquality();

  @override
  bool equals(ApplicationsRecord? e1, ApplicationsRecord? e2) {
    return e1?.timeCreated == e2?.timeCreated &&
        e1?.coverLetter == e2?.coverLetter &&
        e1?.jobRef == e2?.jobRef &&
        e1?.companyRef == e2?.companyRef &&
        e1?.attachmentUrl == e2?.attachmentUrl &&
        e1?.applicantRef == e2?.applicantRef &&
        e1?.applicationUid == e2?.applicationUid &&
        e1?.status == e2?.status &&
        e1?.position == e2?.position &&
        e1?.companyName == e2?.companyName;
  }

  @override
  int hash(ApplicationsRecord? e) => const ListEquality().hash([
        e?.timeCreated,
        e?.coverLetter,
        e?.jobRef,
        e?.companyRef,
        e?.attachmentUrl,
        e?.applicantRef,
        e?.applicationUid,
        e?.status,
        e?.position,
        e?.companyName
      ]);

  @override
  bool isValidKey(Object? o) => o is ApplicationsRecord;
}
