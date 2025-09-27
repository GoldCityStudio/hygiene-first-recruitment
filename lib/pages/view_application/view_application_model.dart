import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'view_application_widget.dart' show ViewApplicationWidget;
import 'package:flutter/material.dart';
import '/backend/backend.dart';

class ViewApplicationModel extends FlutterFlowModel<ViewApplicationWidget> {
  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    user = null;
    application = null;
    job = null;
  }

  /// Additional helper methods are added here.

  /// Data fields
  UsersRecord? user;
  ApplicationsRecord? application;
  JobsRecord? job;

  /// State fields
  bool isLoading = true;
  bool hasError = false;
  String? errorMessage;
}
