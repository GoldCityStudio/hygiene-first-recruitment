import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_application_widget.dart' show CreateApplicationWidget;
import 'package:flutter/material.dart';

class CreateApplicationModel extends FlutterFlowModel<CreateApplicationWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Firestore Query - Query a collection] action in createApplication widget.
  ApplicationsRecord? applicationQuery;
  // State field(s) for coverLetterTextField widget.
  FocusNode? coverLetterTextFieldFocusNode;
  TextEditingController? coverLetterTextFieldTextController;
  String? Function(BuildContext, String?)?
      coverLetterTextFieldTextControllerValidator;
  String? _coverLetterTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please provide a cover letter that is at least 100 characters long.';
    }

    if (val.length < 100) {
      return 'Requires at least 100 characters.';
    }

    return null;
  }

  // Stores action output result for [Bottom Sheet - filePicker] action in Button widget.
  String? selectedFileLink;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ApplicationsRecord? submitApplication;

  @override
  void initState(BuildContext context) {
    coverLetterTextFieldTextControllerValidator =
        _coverLetterTextFieldTextControllerValidator;
  }

  @override
  void dispose() {
    coverLetterTextFieldFocusNode?.dispose();
    coverLetterTextFieldTextController?.dispose();
  }
}
