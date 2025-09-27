import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'saved_jobs_widget.dart' show SavedJobsWidget;
import 'package:flutter/material.dart';

class SavedJobsModel extends FlutterFlowModel<SavedJobsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
