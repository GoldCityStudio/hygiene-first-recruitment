import 'dart:async';
import 'package:collection/collection.dart';
import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WorkExperienceRecord extends FirestoreRecord {
  WorkExperienceRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "company_name" field.
  String? _companyName;
  String get companyName => _companyName ?? '';
  bool hasCompanyName() => _companyName != null;

  // "position" field.
  String? _position;
  String get position => _position ?? '';
  bool hasPosition() => _position != null;

  // "department" field.
  String? _department;
  String get department => _department ?? '';
  bool hasDepartment() => _department != null;

  // "start_date" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  bool hasStartDate() => _startDate != null;

  // "end_date" field.
  DateTime? _endDate;
  DateTime? get endDate => _endDate;
  bool hasEndDate() => _endDate != null;

  // "currently_working" field.
  bool? _currentlyWorking;
  bool get currentlyWorking => _currentlyWorking ?? false;
  bool hasCurrentlyWorking() => _currentlyWorking != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "document_url" field.
  String? _documentUrl;
  String get documentUrl => _documentUrl ?? '';
  bool hasDocumentUrl() => _documentUrl != null;

  // "verification_status" field.
  String? _verificationStatus;
  String get verificationStatus => _verificationStatus ?? 'Pending';
  bool hasVerificationStatus() => _verificationStatus != null;

  void _initializeFields() {
    _companyName = snapshotData['company_name'] as String?;
    _position = snapshotData['position'] as String?;
    _department = snapshotData['department'] as String?;
    _startDate = snapshotData['start_date'] as DateTime?;
    _endDate = snapshotData['end_date'] as DateTime?;
    _currentlyWorking = snapshotData['currently_working'] as bool?;
    _description = snapshotData['description'] as String?;
    _documentUrl = snapshotData['document_url'] as String?;
    _verificationStatus = snapshotData['verification_status'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('work_experience');

  static Stream<WorkExperienceRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => WorkExperienceRecord.fromSnapshot(s));

  static Future<WorkExperienceRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => WorkExperienceRecord.fromSnapshot(s));

  static WorkExperienceRecord fromSnapshot(DocumentSnapshot snapshot) =>
      WorkExperienceRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static WorkExperienceRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      WorkExperienceRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'WorkExperienceRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is WorkExperienceRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createWorkExperienceRecordData({
  String? companyName,
  String? position,
  String? department,
  DateTime? startDate,
  DateTime? endDate,
  bool? currentlyWorking,
  String? description,
  String? documentUrl,
  String? verificationStatus,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'company_name': companyName,
      'position': position,
      'department': department,
      'start_date': startDate,
      'end_date': endDate,
      'currently_working': currentlyWorking,
      'description': description,
      'document_url': documentUrl,
      'verification_status': verificationStatus,
    }.withoutNulls,
  );

  return firestoreData;
}

class WorkExperienceRecordDocumentEquality
    implements Equality<WorkExperienceRecord> {
  const WorkExperienceRecordDocumentEquality();

  @override
  bool equals(WorkExperienceRecord? e1, WorkExperienceRecord? e2) {
    return e1?.companyName == e2?.companyName &&
        e1?.position == e2?.position &&
        e1?.department == e2?.department &&
        e1?.startDate == e2?.startDate &&
        e1?.endDate == e2?.endDate &&
        e1?.currentlyWorking == e2?.currentlyWorking &&
        e1?.description == e2?.description &&
        e1?.documentUrl == e2?.documentUrl &&
        e1?.verificationStatus == e2?.verificationStatus;
  }

  @override
  int hash(WorkExperienceRecord? e) => const ListEquality().hash([
        e?.companyName,
        e?.position,
        e?.department,
        e?.startDate,
        e?.endDate,
        e?.currentlyWorking,
        e?.description,
        e?.documentUrl,
        e?.verificationStatus
      ]);

  @override
  bool isValidKey(Object? o) => o is WorkExperienceRecord;
} 