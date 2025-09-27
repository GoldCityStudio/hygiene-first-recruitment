import '/flutter_flow/flutter_flow_util.dart';
import 'edit_phone_number_widget.dart' show EditPhoneNumberWidget;
import 'package:flutter/material.dart';

class EditPhoneNumberModel extends FlutterFlowModel<EditPhoneNumberWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for phone widget.
  FocusNode? phoneFocusNode;
  TextEditingController? phoneTextController;
  String? Function(BuildContext, String?)? phoneTextControllerValidator;
  String? _phoneTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length > 13) {
      return 'Maximum 13 characters allowed, currently ${val.length}.';
    }
    if (!RegExp('^\\+260(?:95|96|76|77|97)\\d{7}\$').hasMatch(val)) {
      return ' Please include +260 and 9 digits after';
    }
    return null;
  }

  @override
  void initState(BuildContext context) {
    phoneTextControllerValidator = _phoneTextControllerValidator;
  }

  @override
  void dispose() {
    phoneFocusNode?.dispose();
    phoneTextController?.dispose();
  }
}
