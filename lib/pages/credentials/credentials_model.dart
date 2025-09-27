import '/flutter_flow/flutter_flow_util.dart';
import 'credentials_widget.dart' show CredentialsWidget;
import 'package:flutter/material.dart';

class CredentialsModel extends FlutterFlowModel<CredentialsWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
} 