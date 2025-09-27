import 'dart:async';

import '/backend/algolia/serialization_util.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class JobsRecord extends FirestoreRecord {
  JobsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "closing_date" field.
  DateTime? _closingDate;
  DateTime? get closingDate => _closingDate;
  bool hasClosingDate() => _closingDate != null;

  // "position" field.
  String? _position;
  String get position => _position ?? '';
  bool hasPosition() => _position != null;

  // "company_name" field.
  String? _companyName;
  String get companyName => _companyName ?? '';
  bool hasCompanyName() => _companyName != null;

  // "requirements" field.
  String? _requirements;
  String get requirements => _requirements ?? '';
  bool hasRequirements() => _requirements != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "company_ref" field.
  DocumentReference? _companyRef;
  DocumentReference? get companyRef => _companyRef;
  bool hasCompanyRef() => _companyRef != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  bool hasLocation() => _location != null;

  // "modified_at" field.
  DateTime? _modifiedAt;
  DateTime? get modifiedAt => _modifiedAt;
  bool hasModifiedAt() => _modifiedAt != null;

  // "salary_minimum" field.
  double? _salaryMinimum;
  double get salaryMinimum => _salaryMinimum ?? 0.0;
  bool hasSalaryMinimum() => _salaryMinimum != null;

  // "salary_maximum" field.
  double? _salaryMaximum;
  double get salaryMaximum => _salaryMaximum ?? 0.0;
  bool hasSalaryMaximum() => _salaryMaximum != null;

  // "job_uid" field.
  DocumentReference? _jobUid;
  DocumentReference? get jobUid => _jobUid;
  bool hasJobUid() => _jobUid != null;

  // "application_link" field.
  String? _applicationLink;
  String get applicationLink => _applicationLink ?? '';
  bool hasApplicationLink() => _applicationLink != null;

  // "requires_cover_letter" field.
  bool? _requiresCoverLetter;
  bool get requiresCoverLetter => _requiresCoverLetter ?? false;
  bool hasRequiresCoverLetter() => _requiresCoverLetter != null;

  // "min_experience" field.
  int? _minExperience;
  int get minExperience => _minExperience ?? 0;
  bool hasMinExperience() => _minExperience != null;

  // "category_refs" field.
  List<String>? _categoryRefs;
  List<String> get categoryRefs => _categoryRefs ?? const [];
  bool hasCategoryRefs() => _categoryRefs != null;

  // "discoverable" field.
  bool? _discoverable;
  bool get discoverable => _discoverable ?? false;
  bool hasDiscoverable() => _discoverable != null;

  // "is_featured" field.
  bool? _isFeatured;
  bool get isFeatured => _isFeatured ?? false;
  bool hasIsFeatured() => _isFeatured != null;

  // "time_created" field.
  DateTime? _timeCreated;
  DateTime? get timeCreated => _timeCreated;
  bool hasTimeCreated() => _timeCreated != null;

  // "start_date" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  bool hasStartDate() => _startDate != null;

  // "end_date" field.
  DateTime? _endDate;
  DateTime? get endDate => _endDate;
  bool hasEndDate() => _endDate != null;

  // "working_hours" field.
  String? _workingHours;
  String get workingHours => _workingHours ?? '';
  bool hasWorkingHours() => _workingHours != null;

  // "salary_type" field.
  String? _salaryType;
  String get salaryType => _salaryType ?? '月薪';
  bool hasSalaryType() => _salaryType != null;

  void _initializeFields() {
    _description = snapshotData['description'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _closingDate = snapshotData['closing_date'] as DateTime?;
    _position = snapshotData['position'] as String?;
    _companyName = snapshotData['company_name'] as String?;
    _requirements = snapshotData['requirements'] as String?;
    _status = snapshotData['status'] as String?;
    _type = snapshotData['type'] as String?;
    _companyRef = snapshotData['company_ref'] as DocumentReference?;
    _location = snapshotData['location'] as String?;
    _modifiedAt = snapshotData['modified_at'] as DateTime?;
    _salaryMinimum = castToType<double>(snapshotData['salary_minimum']);
    _salaryMaximum = castToType<double>(snapshotData['salary_maximum']);
    _jobUid = snapshotData['job_uid'] as DocumentReference?;
    _applicationLink = snapshotData['application_link'] as String?;
    _requiresCoverLetter = snapshotData['requires_cover_letter'] as bool?;
    _minExperience = castToType<int>(snapshotData['min_experience']);
    _categoryRefs = getDataList(snapshotData['category_refs']);
    _discoverable = snapshotData['discoverable'] as bool?;
    _isFeatured = snapshotData['is_featured'] as bool?;
    _timeCreated = snapshotData['time_created'] as DateTime?;
    _startDate = snapshotData['start_date'] as DateTime?;
    _endDate = snapshotData['end_date'] as DateTime?;
    _workingHours = snapshotData['working_hours'] as String?;
    _salaryType = snapshotData['salary_type'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('jobs');

  static Stream<JobsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => JobsRecord.fromSnapshot(s));

  static Future<JobsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => JobsRecord.fromSnapshot(s));

  static JobsRecord fromSnapshot(DocumentSnapshot snapshot) => JobsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static JobsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      JobsRecord._(reference, mapFromFirestore(data));

  static JobsRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      JobsRecord.getDocumentFromData(
        {
          'description': snapshot.data['description'],
          'created_at': convertAlgoliaParam(
            snapshot.data['created_at'],
            ParamType.DateTime,
            false,
          ),
          'closing_date': convertAlgoliaParam(
            snapshot.data['closing_date'],
            ParamType.DateTime,
            false,
          ),
          'position': snapshot.data['position'],
          'company_name': snapshot.data['company_name'],
          'requirements': snapshot.data['requirements'],
          'status': snapshot.data['status'],
          'type': snapshot.data['type'],
          'company_ref': convertAlgoliaParam(
            snapshot.data['company_ref'],
            ParamType.DocumentReference,
            false,
          ),
          'location': snapshot.data['location'],
          'modified_at': convertAlgoliaParam(
            snapshot.data['modified_at'],
            ParamType.DateTime,
            false,
          ),
          'salary_minimum': convertAlgoliaParam(
            snapshot.data['salary_minimum'],
            ParamType.double,
            false,
          ),
          'salary_maximum': convertAlgoliaParam(
            snapshot.data['salary_maximum'],
            ParamType.double,
            false,
          ),
          'job_uid': convertAlgoliaParam(
            snapshot.data['job_uid'],
            ParamType.DocumentReference,
            false,
          ),
          'application_link': snapshot.data['application_link'],
          'requires_cover_letter': snapshot.data['requires_cover_letter'],
          'min_experience': convertAlgoliaParam(
            snapshot.data['min_experience'],
            ParamType.int,
            false,
          ),
          'category_refs': safeGet(
            () => snapshot.data['category_refs'].toList(),
          ),
          'discoverable': snapshot.data['discoverable'],
          'is_featured': snapshot.data['is_featured'],
          'time_created': convertAlgoliaParam(
            snapshot.data['time_created'],
            ParamType.DateTime,
            false,
          ),
          'start_date': convertAlgoliaParam(
            snapshot.data['start_date'],
            ParamType.DateTime,
            false,
          ),
          'end_date': convertAlgoliaParam(
            snapshot.data['end_date'],
            ParamType.DateTime,
            false,
          ),
          'working_hours': snapshot.data['working_hours'],
          'salary_type': snapshot.data['salary_type'],
        },
        JobsRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<JobsRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'jobs',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'JobsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is JobsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createJobsRecordData({
  String? description,
  DateTime? createdAt,
  DateTime? closingDate,
  String? position,
  String? companyName,
  String? requirements,
  String? status,
  String? type,
  DocumentReference? companyRef,
  String? location,
  DateTime? modifiedAt,
  double? salaryMinimum,
  double? salaryMaximum,
  DocumentReference? jobUid,
  String? applicationLink,
  bool? requiresCoverLetter,
  int? minExperience,
  List<String>? categoryRefs,
  bool? discoverable,
  bool? isFeatured,
  DateTime? timeCreated,
  DateTime? startDate,
  DateTime? endDate,
  String? workingHours,
  String? salaryType,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'description': description,
      'created_at': createdAt,
      'closing_date': closingDate,
      'position': position,
      'company_name': companyName,
      'requirements': requirements,
      'status': status,
      'type': type,
      'company_ref': companyRef,
      'location': location,
      'modified_at': modifiedAt,
      'salary_minimum': salaryMinimum,
      'salary_maximum': salaryMaximum,
      'job_uid': jobUid,
      'application_link': applicationLink,
      'requires_cover_letter': requiresCoverLetter,
      'min_experience': minExperience,
      'category_refs': categoryRefs,
      'discoverable': discoverable,
      'is_featured': isFeatured,
      'time_created': timeCreated,
      'start_date': startDate,
      'end_date': endDate,
      'working_hours': workingHours,
      'salary_type': salaryType,
    }.withoutNulls,
  );

  return firestoreData;
}

class JobsRecordDocumentEquality implements Equality<JobsRecord> {
  const JobsRecordDocumentEquality();

  @override
  bool equals(JobsRecord? e1, JobsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.description == e2?.description &&
        e1?.createdAt == e2?.createdAt &&
        e1?.closingDate == e2?.closingDate &&
        e1?.position == e2?.position &&
        e1?.companyName == e2?.companyName &&
        e1?.requirements == e2?.requirements &&
        e1?.status == e2?.status &&
        e1?.type == e2?.type &&
        e1?.companyRef == e2?.companyRef &&
        e1?.location == e2?.location &&
        e1?.modifiedAt == e2?.modifiedAt &&
        e1?.salaryMinimum == e2?.salaryMinimum &&
        e1?.salaryMaximum == e2?.salaryMaximum &&
        e1?.jobUid == e2?.jobUid &&
        e1?.applicationLink == e2?.applicationLink &&
        e1?.requiresCoverLetter == e2?.requiresCoverLetter &&
        e1?.minExperience == e2?.minExperience &&
        listEquality.equals(e1?.categoryRefs, e2?.categoryRefs) &&
        e1?.discoverable == e2?.discoverable &&
        e1?.isFeatured == e2?.isFeatured &&
        e1?.timeCreated == e2?.timeCreated &&
        e1?.startDate == e2?.startDate &&
        e1?.endDate == e2?.endDate &&
        e1?.workingHours == e2?.workingHours &&
        e1?.salaryType == e2?.salaryType;
  }

  @override
  int hash(JobsRecord? e) => const ListEquality().hash([
        e?.description,
        e?.createdAt,
        e?.closingDate,
        e?.position,
        e?.companyName,
        e?.requirements,
        e?.status,
        e?.type,
        e?.companyRef,
        e?.location,
        e?.modifiedAt,
        e?.salaryMinimum,
        e?.salaryMaximum,
        e?.jobUid,
        e?.applicationLink,
        e?.requiresCoverLetter,
        e?.minExperience,
        e?.categoryRefs,
        e?.discoverable,
        e?.isFeatured,
        e?.timeCreated,
        e?.startDate,
        e?.endDate,
        e?.workingHours,
        e?.salaryType
      ]);

  @override
  bool isValidKey(Object? o) => o is JobsRecord;
}
