import 'dart:async';
import 'package:collection/collection.dart';
import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CredentialsRecord extends FirestoreRecord {
  CredentialsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "certifications" field.
  List<DocumentReference>? _certifications;
  List<DocumentReference> get certifications => _certifications ?? const [];
  bool hasCertifications() => _certifications != null;

  // "education" field.
  List<DocumentReference>? _education;
  List<DocumentReference> get education => _education ?? const [];
  bool hasEducation() => _education != null;

  // "work_experience" field.
  List<DocumentReference>? _workExperience;
  List<DocumentReference> get workExperience => _workExperience ?? const [];
  bool hasWorkExperience() => _workExperience != null;

  // "languages" field.
  List<String>? _languages;
  List<String> get languages => _languages ?? const [];
  bool hasLanguages() => _languages != null;

  // "specializations" field.
  List<String>? _specializations;
  List<String> get specializations => _specializations ?? const [];
  bool hasSpecializations() => _specializations != null;

  // "preferred_shifts" field.
  List<String>? _preferredShifts;
  List<String> get preferredShifts => _preferredShifts ?? const [];
  bool hasPreferredShifts() => _preferredShifts != null;

  // "preferred_departments" field.
  List<String>? _preferredDepartments;
  List<String> get preferredDepartments => _preferredDepartments ?? const [];
  bool hasPreferredDepartments() => _preferredDepartments != null;

  // "hkid" field.
  String? _hkid;
  String get hkid => _hkid ?? '';
  bool hasHkid() => _hkid != null;

  // "verification_status" field.
  String? _verificationStatus;
  String get verificationStatus => _verificationStatus ?? 'Pending';
  bool hasVerificationStatus() => _verificationStatus != null;

  void _initializeFields() {
    _userRef = snapshotData['user_ref'] as DocumentReference?;
    _certifications = getDataList(snapshotData['certifications']);
    _education = getDataList(snapshotData['education']);
    _workExperience = getDataList(snapshotData['work_experience']);
    _languages = getDataList(snapshotData['languages']);
    _specializations = getDataList(snapshotData['specializations']);
    _preferredShifts = getDataList(snapshotData['preferred_shifts']);
    _preferredDepartments = getDataList(snapshotData['preferred_departments']);
    _hkid = snapshotData['hkid'] as String?;
    _verificationStatus = snapshotData['verification_status'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('credentials');

  static Stream<CredentialsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CredentialsRecord.fromSnapshot(s));

  static Future<CredentialsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CredentialsRecord.fromSnapshot(s));

  static CredentialsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CredentialsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CredentialsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CredentialsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CredentialsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CredentialsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCredentialsRecordData({
  DocumentReference? userRef,
  List<DocumentReference>? certifications,
  List<DocumentReference>? education,
  List<DocumentReference>? workExperience,
  List<String>? languages,
  List<String>? specializations,
  List<String>? preferredShifts,
  List<String>? preferredDepartments,
  String? hkid,
  String? verificationStatus,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_ref': userRef,
      'certifications': certifications,
      'education': education,
      'work_experience': workExperience,
      'languages': languages,
      'specializations': specializations,
      'preferred_shifts': preferredShifts,
      'preferred_departments': preferredDepartments,
      'hkid': hkid,
      'verification_status': verificationStatus,
    }.withoutNulls,
  );

  return firestoreData;
}

class CredentialsRecordDocumentEquality implements Equality<CredentialsRecord> {
  const CredentialsRecordDocumentEquality();

  @override
  bool equals(CredentialsRecord? e1, CredentialsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userRef == e2?.userRef &&
        listEquality.equals(e1?.certifications, e2?.certifications) &&
        listEquality.equals(e1?.education, e2?.education) &&
        listEquality.equals(e1?.workExperience, e2?.workExperience) &&
        listEquality.equals(e1?.languages, e2?.languages) &&
        listEquality.equals(e1?.specializations, e2?.specializations) &&
        listEquality.equals(e1?.preferredShifts, e2?.preferredShifts) &&
        listEquality.equals(e1?.preferredDepartments, e2?.preferredDepartments) &&
        e1?.hkid == e2?.hkid &&
        e1?.verificationStatus == e2?.verificationStatus;
  }

  @override
  int hash(CredentialsRecord? e) => const ListEquality().hash([
        e?.userRef,
        e?.certifications,
        e?.education,
        e?.workExperience,
        e?.languages,
        e?.specializations,
        e?.preferredShifts,
        e?.preferredDepartments,
        e?.hkid,
        e?.verificationStatus
      ]);

  @override
  bool isValidKey(Object? o) => o is CredentialsRecord;
} 