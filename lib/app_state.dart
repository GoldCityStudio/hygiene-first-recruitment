import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  final _categoriesManager = FutureRequestManager<List<CategoriesRecord>>();
  Future<List<CategoriesRecord>> categories({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<CategoriesRecord>> Function() requestFn,
  }) =>
      _categoriesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCategoriesCache() => _categoriesManager.clear();
  void clearCategoriesCacheKey(String? uniqueKey) =>
      _categoriesManager.clearRequest(uniqueKey);

  final _heartManager = StreamRequestManager<UsersRecord>();
  Stream<UsersRecord> heart({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<UsersRecord> Function() requestFn,
  }) =>
      _heartManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearHeartCache() => _heartManager.clear();
  void clearHeartCacheKey(String? uniqueKey) =>
      _heartManager.clearRequest(uniqueKey);

  final _jobsManager = FutureRequestManager<List<JobsRecord>>();
  Future<List<JobsRecord>> jobs({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<JobsRecord>> Function() requestFn,
  }) =>
      _jobsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearJobsCache() => _jobsManager.clear();
  void clearJobsCacheKey(String? uniqueKey) =>
      _jobsManager.clearRequest(uniqueKey);
}
