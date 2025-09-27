import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'company_job_listings_widget.dart' show CompanyJobListingsWidget;
import 'package:flutter/material.dart';

class CompanyJobListingsModel
    extends FlutterFlowModel<CompanyJobListingsWidget> {
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
