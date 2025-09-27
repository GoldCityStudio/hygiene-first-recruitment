import 'dart:async';
import 'package:collection/collection.dart';
import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CertificationRecord extends FirestoreRecord {
  CertificationRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "issuing_organization" field.
  String? _issuingOrganization;
  String get issuingOrganization => _issuingOrganization ?? '';
  bool hasIssuingOrganization() => _issuingOrganization != null;

  // "issue_date" field.
  DateTime? _issueDate;
  DateTime? get issueDate => _issueDate;
  bool hasIssueDate() => _issueDate != null;

  // "expiry_date" field.
  DateTime? _expiryDate;
  DateTime? get expiryDate => _expiryDate;
  bool hasExpiryDate() => _expiryDate != null;

  // "certificate_number" field.
  String? _certificateNumber;
  String get certificateNumber => _certificateNumber ?? '';
  bool hasCertificateNumber() => _certificateNumber != null;

  // "document_url" field.
  String? _documentUrl;
  String get documentUrl => _documentUrl ?? '';
  bool hasDocumentUrl() => _documentUrl != null;

  // "verification_status" field.
  String? _verificationStatus;
  String get verificationStatus => _verificationStatus ?? 'Pending';
  bool hasVerificationStatus() => _verificationStatus != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _issuingOrganization = snapshotData['issuing_organization'] as String?;
    _issueDate = snapshotData['issue_date'] as DateTime?;
    _expiryDate = snapshotData['expiry_date'] as DateTime?;
    _certificateNumber = snapshotData['certificate_number'] as String?;
    _documentUrl = snapshotData['document_url'] as String?;
    _verificationStatus = snapshotData['verification_status'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('certifications');

  static Stream<CertificationRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CertificationRecord.fromSnapshot(s));

  static Future<CertificationRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CertificationRecord.fromSnapshot(s));

  static CertificationRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CertificationRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CertificationRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CertificationRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CertificationRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CertificationRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCertificationRecordData({
  String? name,
  String? issuingOrganization,
  DateTime? issueDate,
  DateTime? expiryDate,
  String? certificateNumber,
  String? documentUrl,
  String? verificationStatus,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'issuing_organization': issuingOrganization,
      'issue_date': issueDate,
      'expiry_date': expiryDate,
      'certificate_number': certificateNumber,
      'document_url': documentUrl,
      'verification_status': verificationStatus,
    }.withoutNulls,
  );

  return firestoreData;
}

class CertificationRecordDocumentEquality implements Equality<CertificationRecord> {
  const CertificationRecordDocumentEquality();

  @override
  bool equals(CertificationRecord? e1, CertificationRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.issuingOrganization == e2?.issuingOrganization &&
        e1?.issueDate == e2?.issueDate &&
        e1?.expiryDate == e2?.expiryDate &&
        e1?.certificateNumber == e2?.certificateNumber &&
        e1?.documentUrl == e2?.documentUrl &&
        e1?.verificationStatus == e2?.verificationStatus;
  }

  @override
  int hash(CertificationRecord? e) => const ListEquality().hash([
        e?.name,
        e?.issuingOrganization,
        e?.issueDate,
        e?.expiryDate,
        e?.certificateNumber,
        e?.documentUrl,
        e?.verificationStatus
      ]);

  @override
  bool isValidKey(Object? o) => o is CertificationRecord;
} 