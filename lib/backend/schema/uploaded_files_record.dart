import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UploadedFilesRecord extends FirestoreRecord {
  UploadedFilesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "filename" field.
  String? _filename;
  String get filename => _filename ?? '';
  bool hasFilename() => _filename != null;

  // "date_created" field.
  DateTime? _dateCreated;
  DateTime? get dateCreated => _dateCreated;
  bool hasDateCreated() => _dateCreated != null;

  // "file_url" field.
  String? _fileUrl;
  String get fileUrl => _fileUrl ?? '';
  bool hasFileUrl() => _fileUrl != null;

  // "file_owner_ref" field.
  DocumentReference? _fileOwnerRef;
  DocumentReference? get fileOwnerRef => _fileOwnerRef;
  bool hasFileOwnerRef() => _fileOwnerRef != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _filename = snapshotData['filename'] as String?;
    _dateCreated = snapshotData['date_created'] as DateTime?;
    _fileUrl = snapshotData['file_url'] as String?;
    _fileOwnerRef = snapshotData['file_owner_ref'] as DocumentReference?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('uploaded_files')
          : FirebaseFirestore.instance.collectionGroup('uploaded_files');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('uploaded_files').doc(id);

  static Stream<UploadedFilesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UploadedFilesRecord.fromSnapshot(s));

  static Future<UploadedFilesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UploadedFilesRecord.fromSnapshot(s));

  static UploadedFilesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UploadedFilesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UploadedFilesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UploadedFilesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UploadedFilesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UploadedFilesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUploadedFilesRecordData({
  String? filename,
  DateTime? dateCreated,
  String? fileUrl,
  DocumentReference? fileOwnerRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'filename': filename,
      'date_created': dateCreated,
      'file_url': fileUrl,
      'file_owner_ref': fileOwnerRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class UploadedFilesRecordDocumentEquality
    implements Equality<UploadedFilesRecord> {
  const UploadedFilesRecordDocumentEquality();

  @override
  bool equals(UploadedFilesRecord? e1, UploadedFilesRecord? e2) {
    return e1?.filename == e2?.filename &&
        e1?.dateCreated == e2?.dateCreated &&
        e1?.fileUrl == e2?.fileUrl &&
        e1?.fileOwnerRef == e2?.fileOwnerRef;
  }

  @override
  int hash(UploadedFilesRecord? e) => const ListEquality()
      .hash([e?.filename, e?.dateCreated, e?.fileUrl, e?.fileOwnerRef]);

  @override
  bool isValidKey(Object? o) => o is UploadedFilesRecord;
}
