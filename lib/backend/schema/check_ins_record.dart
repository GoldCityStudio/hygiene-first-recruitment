import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

extension MapWithoutNulls on Map<String, dynamic> {
  Map<String, dynamic> get withoutNulls => Map.fromEntries(
        entries.where((e) => e.value != null),
      );
}

class CheckInsRecord extends FirestoreRecord {
  CheckInsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "employee_ref" field
  DocumentReference? _employeeRef;
  DocumentReference? get employeeRef => _employeeRef;
  bool hasEmployeeRef() => _employeeRef != null;

  // "check_in_time" field
  DateTime? _checkInTime;
  DateTime? get checkInTime => _checkInTime;
  bool hasCheckInTime() => _checkInTime != null;

  // "check_out_time" field
  DateTime? _checkOutTime;
  DateTime? get checkOutTime => _checkOutTime;
  bool hasCheckOutTime() => _checkOutTime != null;

  // "location" field
  Map<String, dynamic>? _location;
  Map<String, dynamic>? get location => _location;
  bool hasLocation() => _location != null;

  // "status" field
  String? _status;
  String get status => _status ?? 'pending';
  bool hasStatus() => _status != null;

  // "notes" field
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "company_ref" field
  DocumentReference? _companyRef;
  DocumentReference? get companyRef => _companyRef;
  bool hasCompanyRef() => _companyRef != null;

  // "late_reason" field
  String? _lateReason;
  String? get lateReason => _lateReason;
  bool hasLateReason() => _lateReason != null;

  // "early_checkout_reason" field
  String? _earlyCheckoutReason;
  String? get earlyCheckoutReason => _earlyCheckoutReason;
  bool hasEarlyCheckoutReason() => _earlyCheckoutReason != null;

  void _initializeFields() {
    _employeeRef = snapshotData['employee_ref'] as DocumentReference?;
    _checkInTime = snapshotData['check_in_time'] as DateTime?;
    _checkOutTime = snapshotData['check_out_time'] as DateTime?;
    _location = snapshotData['location'] as Map<String, dynamic>?;
    _status = snapshotData['status'] as String?;
    _notes = snapshotData['notes'] as String?;
    _companyRef = snapshotData['company_ref'] as DocumentReference?;
    _lateReason = snapshotData['late_reason'] as String?;
    _earlyCheckoutReason = snapshotData['early_checkout_reason'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('check_ins');

  static Stream<CheckInsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CheckInsRecord.fromSnapshot(s));

  static Future<CheckInsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CheckInsRecord.fromSnapshot(s));

  static CheckInsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CheckInsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static Map<String, dynamic> createCheckInsRecordData({
    DocumentReference? employeeRef,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    Map<String, dynamic>? location,
    String? status,
    String? notes,
    DocumentReference? companyRef,
    String? lateReason,
    String? earlyCheckoutReason,
  }) {
    final firestoreData = mapToFirestore(
      <String, dynamic>{
        'employee_ref': employeeRef,
        'check_in_time': checkInTime,
        'check_out_time': checkOutTime,
        'location': location,
        'status': status,
        'notes': notes,
        'company_ref': companyRef,
        'late_reason': lateReason,
        'early_checkout_reason': earlyCheckoutReason,
      }.withoutNulls,
    );

    return firestoreData;
  }

  @override
  String toString() =>
      'CheckInsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CheckInsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
} 