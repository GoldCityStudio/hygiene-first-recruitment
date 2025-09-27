import 'dart:async';

import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "displayName" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  Timestamp? _createdTime;
  DateTime? get createdTime => _createdTime?.toDate();
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  bool hasLocation() => _location != null;

  // "website" field.
  String? _website;
  String get website => _website ?? '';
  bool hasWebsite() => _website != null;

  // "photo_cover_url" field.
  String? _photoCoverUrl;
  String get photoCoverUrl => _photoCoverUrl ?? '';
  bool hasPhotoCoverUrl() => _photoCoverUrl != null;

  // "saved_jobs" field.
  List<DocumentReference>? _savedJobs;
  List<DocumentReference> get savedJobs => _savedJobs ?? const [];
  bool hasSavedJobs() => _savedJobs != null;

  // "shortlisted_candidates" field.
  List<DocumentReference>? _shortlistedCandidates;
  List<DocumentReference> get shortlistedCandidates => _shortlistedCandidates ?? const [];
  bool hasShortlistedCandidates() => _shortlistedCandidates != null;

  // "profile_photo_blurhash" field.
  String? _profilePhotoBlurhash;
  String get profilePhotoBlurhash => _profilePhotoBlurhash ?? '';
  bool hasProfilePhotoBlurhash() => _profilePhotoBlurhash != null;

  // "cover_photo_blurhash" field.
  String? _coverPhotoBlurhash;
  String get coverPhotoBlurhash => _coverPhotoBlurhash ?? '';
  bool hasCoverPhotoBlurhash() => _coverPhotoBlurhash != null;

  // "email_notifications" field.
  bool? _emailNotifications;
  bool get emailNotifications => _emailNotifications ?? false;
  bool hasEmailNotifications() => _emailNotifications != null;

  // "push_notifications" field.
  bool? _pushNotifications;
  bool get pushNotifications => _pushNotifications ?? false;
  bool hasPushNotifications() => _pushNotifications != null;

  // "notification_frequency" field.
  String? _notificationFrequency;
  String get notificationFrequency => _notificationFrequency ?? '';
  bool hasNotificationFrequency() => _notificationFrequency != null;

  // "notifications_last_seen_time" field.
  DateTime? _notificationsLastSeenTime;
  DateTime? get notificationsLastSeenTime => _notificationsLastSeenTime;
  bool hasNotificationsLastSeenTime() => _notificationsLastSeenTime != null;

  // "experience" field.
  int? _experience;
  int get experience => _experience ?? 0;
  bool hasExperience() => _experience != null;

  // "category_interests" field.
  List<String>? _categoryInterests;
  List<String> get categoryInterests => _categoryInterests ?? const [];
  bool hasCategoryInterests() => _categoryInterests != null;

  // "verified_account" field.
  bool? _verifiedAccount;
  bool get verifiedAccount => _verifiedAccount ?? false;
  bool hasVerifiedAccount() => _verifiedAccount != null;

  // "whatsapp_number" field.
  String? _whatsappNumber;
  String get whatsappNumber => _whatsappNumber ?? '';
  bool hasWhatsappNumber() => _whatsappNumber != null;

  // "current_position" field.
  String? _currentPosition;
  String get currentPosition => _currentPosition ?? '';
  bool hasCurrentPosition() => _currentPosition != null;

  // "current_company" field.
  String? _currentCompany;
  String get currentCompany => _currentCompany ?? '';
  bool hasCurrentCompany() => _currentCompany != null;

  // "expected_salary" field.
  String? _expectedSalary;
  String get expectedSalary => _expectedSalary ?? '';
  bool hasExpectedSalary() => _expectedSalary != null;

  // "notice_period" field.
  String? _noticePeriod;
  String get noticePeriod => _noticePeriod ?? '';
  bool hasNoticePeriod() => _noticePeriod != null;

  // "skills" field.
  List<String>? _skills;
  List<String> get skills => _skills ?? const [];
  bool hasSkills() => _skills != null;

  // "languages" field.
  List<String>? _languages;
  List<String> get languages => _languages ?? const [];
  bool hasLanguages() => _languages != null;

  // "certifications" field.
  List<String>? _certifications;
  List<String> get certifications => _certifications ?? const [];
  bool hasCertifications() => _certifications != null;

  // "education" field.
  String? _education;
  String get education => _education ?? '';
  bool hasEducation() => _education != null;

  // "preferred_locations" field.
  List<String>? _preferredLocations;
  List<String> get preferredLocations => _preferredLocations ?? const [];
  bool hasPreferredLocations() => _preferredLocations != null;

  // "preferred_industries" field.
  List<String>? _preferredIndustries;
  List<String> get preferredIndustries => _preferredIndustries ?? const [];
  bool hasPreferredIndustries() => _preferredIndustries != null;

  // "preferred_job_types" field.
  List<String>? _preferredJobTypes;
  List<String> get preferredJobTypes => _preferredJobTypes ?? const [];
  bool hasPreferredJobTypes() => _preferredJobTypes != null;

  // "work_schedule" field.
  String? _workSchedule;
  String get workSchedule => _workSchedule ?? '';
  bool hasWorkSchedule() => _workSchedule != null;

  // "chinese_name" field.
  String? _chineseName;
  String get chineseName => _chineseName ?? '';
  bool hasChineseName() => _chineseName != null;

  // "gender" field.
  String? _gender;
  String get gender => _gender ?? '';
  bool hasGender() => _gender != null;

  // "date_of_birth" field.
  DateTime? _dateOfBirth;
  DateTime? get dateOfBirth => _dateOfBirth;
  bool hasDateOfBirth() => _dateOfBirth != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  bool hasAddress() => _address != null;

  // "credentials" field.
  String? _credentials;
  String get credentials => _credentials ?? '';
  bool hasCredentials() => _credentials != null;

  // "expertise" field.
  String? _expertise;
  String get expertise => _expertise ?? '';
  bool hasExpertise() => _expertise != null;

  // "id_card_url" field.
  String? _idCardUrl;
  String get idCardUrl => _idCardUrl ?? '';
  bool hasIdCardUrl() => _idCardUrl != null;

  // "other_documents" field.
  List<String>? _otherDocuments;
  List<String> get otherDocuments => _otherDocuments ?? const [];
  bool hasOtherDocuments() => _otherDocuments != null;

  // Additional fields
  String? _fullName;
  String get fullName => _fullName ?? '';
  bool hasFullName() => _fullName != null;

  String? _street;
  String get street => _street ?? '';
  bool hasStreet() => _street != null;

  String? _building;
  String get building => _building ?? '';
  bool hasBuilding() => _building != null;

  String? _floor;
  String get floor => _floor ?? '';
  bool hasFloor() => _floor != null;

  String? _roomNumber;
  String get roomNumber => _roomNumber ?? '';
  bool hasRoomNumber() => _roomNumber != null;

  String? _district;
  String get district => _district ?? '';
  bool hasDistrict() => _district != null;

  String? _howKnow;
  String get howKnow => _howKnow ?? '';
  bool hasHowKnow() => _howKnow != null;

  // "users" collection reference
  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Document data was null');
    }

    return UsersRecord._(
      snapshot.reference,
      mapFromFirestore(data),
    );
  }

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  static Map<String, dynamic> mapFromFirestore(Map<String, dynamic> data) {
    final timestamp = data['notifications_last_seen_time'] as Timestamp?;
    return {
      'email': data['email'] as String?,
      'displayName': data['displayName'] as String?,
      'photo_url': data['photo_url'] as String?,
      'uid': data['uid'] as String?,
      'created_time': data['created_time'] as Timestamp?,
      'phone_number': data['phone_number'] as String?,
      'whatsapp_number': data['whatsapp_number'] as String?,
      'gender': data['gender'] as String?,
      'date_of_birth': data['date_of_birth'] as Timestamp?,
      'street': data['street'] as String?,
      'building': data['building'] as String?,
      'floor': data['floor'] as String?,
      'room_number': data['room_number'] as String?,
      'district': data['district'] as String?,
      'languages': getDataList(data['languages']),
      'credentials': data['credentials'] as String?,
      'expertise': data['expertise'] as String?,
      'expected_salary': data['expected_salary'] as String?,
      'notice_period': data['notice_period'] as String?,
      'preferred_locations': getDataList(data['preferred_locations']),
      'preferred_industries': getDataList(data['preferred_industries']),
      'preferred_job_types': getDataList(data['preferred_job_types']),
      'work_schedule': data['work_schedule'] as String?,
      'skills': getDataList(data['skills']),
      'id_card_url': data['id_card_url'] as String?,
      'other_documents': getDataList(data['other_documents']),
      'how_know': data['how_know'] as String?,
      'type': data['type'] as String?,
      'description': data['description'] as String?,
      'website': data['website'] as String?,
      'education': data['education'] as String?,
      'certifications': getDataList(data['certifications']),
      'location': data['location'] as String?,
      'photo_cover_url': data['photo_cover_url'] as String?,
      'profile_photo_blurhash': data['profile_photo_blurhash'] as String?,
      'cover_photo_blurhash': data['cover_photo_blurhash'] as String?,
      'email_notifications': data['email_notifications'] as bool?,
      'push_notifications': data['push_notifications'] as bool?,
      'notification_frequency': data['notification_frequency'] as String?,
      'notifications_last_seen_time': timestamp?.millisecondsSinceEpoch,
      'experience': data['experience'] as int?,
      'category_interests': getDataList(data['category_interests']),
      'verified_account': data['verified_account'] as bool?,
      'current_position': data['current_position'] as String?,
      'current_company': data['current_company'] as String?,
      'chinese_name': data['chinese_name'] as String?,
    };
  }

  static Map<String, dynamic> mapToFirestore(Map<String, dynamic> data) {
    return {
      'email': data['email'],
      'displayName': data['displayName'],
      'photo_url': data['photo_url'],
      'uid': data['uid'],
      'created_time': data['created_time'],
      'phone_number': data['phone_number'],
      'whatsapp_number': data['whatsapp_number'],
      'gender': data['gender'],
      'date_of_birth': data['date_of_birth'],
      'street': data['street'],
      'building': data['building'],
      'floor': data['floor'],
      'room_number': data['room_number'],
      'district': data['district'],
      'languages': data['languages'],
      'credentials': data['credentials'],
      'expertise': data['expertise'],
      'expected_salary': data['expected_salary'],
      'notice_period': data['notice_period'],
      'preferred_locations': data['preferred_locations'],
      'preferred_industries': data['preferred_industries'],
      'preferred_job_types': data['preferred_job_types'],
      'work_schedule': data['work_schedule'],
      'skills': data['skills'],
      'id_card_url': data['id_card_url'],
      'other_documents': data['other_documents'],
      'type': data['type'],
      'description': data['description'],
      'location': data['location'],
      'website': data['website'],
      'photo_cover_url': data['photo_cover_url'],
      'profile_photo_blurhash': data['profile_photo_blurhash'],
      'cover_photo_blurhash': data['cover_photo_blurhash'],
      'email_notifications': data['email_notifications'],
      'push_notifications': data['push_notifications'],
      'notification_frequency': data['notification_frequency'],
      'notifications_last_seen_time': data['notifications_last_seen_time'],
      'experience': data['experience'],
      'category_interests': data['category_interests'],
      'verified_account': data['verified_account'],
      'current_position': data['current_position'],
      'current_company': data['current_company'],
      'certifications': data['certifications'],
      'education': data['education'],
      'chinese_name': data['chinese_name'],
    };
  }

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['displayName'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as Timestamp?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _whatsappNumber = snapshotData['whatsapp_number'] as String?;
    _gender = snapshotData['gender'] as String?;
    _dateOfBirth = (snapshotData['date_of_birth'] as Timestamp?)?.toDate();
    _street = snapshotData['street'] as String?;
    _building = snapshotData['building'] as String?;
    _floor = snapshotData['floor'] as String?;
    _roomNumber = snapshotData['room_number'] as String?;
    _district = snapshotData['district'] as String?;
    _languages = getDataList(snapshotData['languages']);
    _credentials = snapshotData['credentials'] as String?;
    _expertise = snapshotData['expertise'] as String?;
    _expectedSalary = snapshotData['expected_salary'] as String?;
    _noticePeriod = snapshotData['notice_period'] as String?;
    _preferredLocations = getDataList(snapshotData['preferred_locations']);
    _preferredIndustries = getDataList(snapshotData['preferred_industries']);
    _preferredJobTypes = getDataList(snapshotData['preferred_job_types']);
    _workSchedule = snapshotData['work_schedule'] as String?;
    _skills = getDataList(snapshotData['skills']);
    _idCardUrl = snapshotData['id_card_url'] as String?;
    _otherDocuments = getDataList(snapshotData['other_documents']);
    _howKnow = snapshotData['how_know'] as String?;
    _type = snapshotData['type'] as String?;
    _description = snapshotData['description'] as String?;
    _website = snapshotData['website'] as String?;
    _education = snapshotData['education'] as String?;
    _certifications = getDataList(snapshotData['certifications']);
    _location = snapshotData['location'] as String?;
    _photoCoverUrl = snapshotData['photo_cover_url'] as String?;
    _profilePhotoBlurhash = snapshotData['profile_photo_blurhash'] as String?;
    _coverPhotoBlurhash = snapshotData['cover_photo_blurhash'] as String?;
    _emailNotifications = snapshotData['email_notifications'] as bool?;
    _pushNotifications = snapshotData['push_notifications'] as bool?;
    _notificationFrequency = snapshotData['notification_frequency'] as String?;
    _notificationsLastSeenTime = snapshotData['notifications_last_seen_time'] != null
        ? DateTime.fromMillisecondsSinceEpoch(snapshotData['notifications_last_seen_time'] as int)
        : null;
    _experience = snapshotData['experience'] as int?;
    _categoryInterests = getDataList(snapshotData['category_interests']);
    _verifiedAccount = snapshotData['verified_account'] as bool?;
    _currentPosition = snapshotData['current_position'] as String?;
    _currentCompany = snapshotData['current_company'] as String?;
    _chineseName = snapshotData['chinese_name'] as String?;
  }

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  Timestamp? createdTime,
  String? phoneNumber,
  String? whatsappNumber,
  String? gender,
  DateTime? dateOfBirth,
  String? street,
  String? building,
  String? floor,
  String? roomNumber,
  String? district,
  List<String>? language,
  String? credentials,
  String? expertise,
  String? expectedSalary,
  String? noticePeriod,
  List<String>? preferredLocations,
  List<String>? preferredIndustries,
  List<String>? preferredJobTypes,
  String? workSchedule,
  List<String>? skills,
  String? idCardUrl,
  List<String>? otherDocuments,
  String? type,
  String? description,
  String? location,
  String? website,
  String? photoCoverUrl,
  bool? emailNotifications,
  bool? pushNotifications,
  String? notificationFrequency,
  DateTime? notificationsLastSeenTime,
  int? experience,
  List<String>? categoryInterests,
  bool? verifiedAccount,
  String? currentPosition,
  String? currentCompany,
  List<String>? languages,
  List<String>? certifications,
  String? education,
  String? chineseName,
  String? profilePhotoBlurhash,
  String? coverPhotoBlurhash,
}) {
  final firestoreData = mapToFirestore({
      'email': email,
    'displayName': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'whatsapp_number': whatsappNumber,
      'gender': gender,
    'date_of_birth': dateOfBirth != null ? Timestamp.fromDate(dateOfBirth) : null,
    'street': street,
    'building': building,
    'floor': floor,
    'room_number': roomNumber,
    'district': district,
    'languages': languages ?? language,
      'credentials': credentials,
      'expertise': expertise,
      'expected_salary': expectedSalary,
      'notice_period': noticePeriod,
      'preferred_locations': preferredLocations,
      'preferred_industries': preferredIndustries,
      'preferred_job_types': preferredJobTypes,
      'work_schedule': workSchedule,
      'skills': skills,
      'id_card_url': idCardUrl,
      'other_documents': otherDocuments,
      'type': type,
      'description': description,
      'location': location,
      'website': website,
      'photo_cover_url': photoCoverUrl,
    'profile_photo_blurhash': profilePhotoBlurhash,
    'cover_photo_blurhash': coverPhotoBlurhash,
      'email_notifications': emailNotifications,
      'push_notifications': pushNotifications,
      'notification_frequency': notificationFrequency,
    'notifications_last_seen_time': notificationsLastSeenTime?.millisecondsSinceEpoch,
      'experience': experience,
      'category_interests': categoryInterests,
      'verified_account': verifiedAccount,
      'current_position': currentPosition,
      'current_company': currentCompany,
      'certifications': certifications,
      'education': education,
      'chinese_name': chineseName,
  });

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.type == e2?.type &&
        e1?.description == e2?.description &&
        e1?.location == e2?.location &&
        e1?.website == e2?.website &&
        e1?.photoCoverUrl == e2?.photoCoverUrl &&
        listEquality.equals(e1?.savedJobs, e2?.savedJobs) &&
        listEquality.equals(e1?.shortlistedCandidates, e2?.shortlistedCandidates) &&
        e1?.profilePhotoBlurhash == e2?.profilePhotoBlurhash &&
        e1?.coverPhotoBlurhash == e2?.coverPhotoBlurhash &&
        e1?.emailNotifications == e2?.emailNotifications &&
        e1?.pushNotifications == e2?.pushNotifications &&
        e1?.notificationFrequency == e2?.notificationFrequency &&
        e1?.notificationsLastSeenTime == e2?.notificationsLastSeenTime &&
        e1?.experience == e2?.experience &&
        listEquality.equals(e1?.categoryInterests, e2?.categoryInterests) &&
        e1?.verifiedAccount == e2?.verifiedAccount &&
        e1?.whatsappNumber == e2?.whatsappNumber &&
        e1?.currentPosition == e2?.currentPosition &&
        e1?.currentCompany == e2?.currentCompany &&
        e1?.expectedSalary == e2?.expectedSalary &&
        e1?.noticePeriod == e2?.noticePeriod &&
        listEquality.equals(e1?.skills, e2?.skills) &&
        listEquality.equals(e1?.languages, e2?.languages) &&
        listEquality.equals(e1?.certifications, e2?.certifications) &&
        e1?.education == e2?.education &&
        listEquality.equals(e1?.preferredLocations, e2?.preferredLocations) &&
        listEquality.equals(e1?.preferredIndustries, e2?.preferredIndustries) &&
        listEquality.equals(e1?.preferredJobTypes, e2?.preferredJobTypes) &&
        e1?.workSchedule == e2?.workSchedule &&
        e1?.chineseName == e2?.chineseName &&
        e1?.gender == e2?.gender &&
        e1?.dateOfBirth == e2?.dateOfBirth &&
        e1?.address == e2?.address &&
        e1?.credentials == e2?.credentials &&
        e1?.expertise == e2?.expertise &&
        e1?.idCardUrl == e2?.idCardUrl &&
        listEquality.equals(e1?.otherDocuments, e2?.otherDocuments);
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.type,
        e?.description,
        e?.location,
        e?.website,
        e?.photoCoverUrl,
        e?.savedJobs,
        e?.shortlistedCandidates,
        e?.profilePhotoBlurhash,
        e?.coverPhotoBlurhash,
        e?.emailNotifications,
        e?.pushNotifications,
        e?.notificationFrequency,
        e?.notificationsLastSeenTime,
        e?.experience,
        e?.categoryInterests,
        e?.verifiedAccount,
        e?.whatsappNumber,
        e?.currentPosition,
        e?.currentCompany,
        e?.expectedSalary,
        e?.noticePeriod,
        e?.skills,
        e?.languages,
        e?.certifications,
        e?.education,
        e?.preferredLocations,
        e?.preferredIndustries,
        e?.preferredJobTypes,
        e?.workSchedule,
        e?.chineseName,
        e?.gender,
        e?.dateOfBirth,
        e?.address,
        e?.credentials,
        e?.expertise,
        e?.idCardUrl,
        e?.otherDocuments
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
