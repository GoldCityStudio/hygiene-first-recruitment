import 'dart:async';
import 'package:collection/collection.dart';
import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EducationRecord extends FirestoreRecord {
  EducationRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "institution" field.
  String? _institution;
  String get institution => _institution ?? '';
  bool hasInstitution() => _institution != null;

  // "degree" field.
  String? _degree;
  String get degree => _degree ?? '';
  bool hasDegree() => _degree != null;

  // "field_of_study" field.
  String? _fieldOfStudy;
  String get fieldOfStudy => _fieldOfStudy ?? '';
  bool hasFieldOfStudy() => _fieldOfStudy != null;

  // "start_date" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  bool hasStartDate() => _startDate != null;

  // "end_date" field.
  DateTime? _endDate;
  DateTime? get endDate => _endDate;
  bool hasEndDate() => _endDate != null;

  // "grade" field.
  String? _grade;
  String get grade => _grade ?? '';
  bool hasGrade() => _grade != null;

  // "document_url" field.
  String? _documentUrl;
  String get documentUrl => _documentUrl ?? '';
  bool hasDocumentUrl() => _documentUrl != null;

  // "verification_status" field.
  String? _verificationStatus;
  String get verificationStatus => _verificationStatus ?? 'Pending';
  bool hasVerificationStatus() => _verificationStatus != null;

  void _initializeFields() {
    _institution = snapshotData['institution'] as String?;
    _degree = snapshotData['degree'] as String?;
    _fieldOfStudy = snapshotData['field_of_study'] as String?;
    _startDate = snapshotData['start_date'] as DateTime?;
    _endDate = snapshotData['end_date'] as DateTime?;
    _grade = snapshotData['grade'] as String?;
    _documentUrl = snapshotData['document_url'] as String?;
    _verificationStatus = snapshotData['verification_status'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('education');

  static Stream<EducationRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EducationRecord.fromSnapshot(s));

  static Future<EducationRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EducationRecord.fromSnapshot(s));

  static EducationRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EducationRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EducationRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EducationRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EducationRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EducationRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEducationRecordData({
  String? institution,
  String? degree,
  String? fieldOfStudy,
  DateTime? startDate,
  DateTime? endDate,
  String? grade,
  String? documentUrl,
  String? verificationStatus,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'institution': institution,
      'degree': degree,
      'field_of_study': fieldOfStudy,
      'start_date': startDate,
      'end_date': endDate,
      'grade': grade,
      'document_url': documentUrl,
      'verification_status': verificationStatus,
    }.withoutNulls,
  );

  return firestoreData;
}

class EducationRecordDocumentEquality implements Equality<EducationRecord> {
  const EducationRecordDocumentEquality();

  @override
  bool equals(EducationRecord? e1, EducationRecord? e2) {
    return e1?.institution == e2?.institution &&
        e1?.degree == e2?.degree &&
        e1?.fieldOfStudy == e2?.fieldOfStudy &&
        e1?.startDate == e2?.startDate &&
        e1?.endDate == e2?.endDate &&
        e1?.grade == e2?.grade &&
        e1?.documentUrl == e2?.documentUrl &&
        e1?.verificationStatus == e2?.verificationStatus;
  }

  @override
  int hash(EducationRecord? e) => const ListEquality().hash([
        e?.institution,
        e?.degree,
        e?.fieldOfStudy,
        e?.startDate,
        e?.endDate,
        e?.grade,
        e?.documentUrl,
        e?.verificationStatus
      ]);

  @override
  bool isValidKey(Object? o) => o is EducationRecord;
} 