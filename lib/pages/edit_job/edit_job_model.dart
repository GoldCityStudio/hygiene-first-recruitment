import '/components/categories_dropdown/categories_dropdown_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'edit_job_widget.dart' show EditJobWidget;
import 'package:flutter/material.dart';

class EditJobModel extends FlutterFlowModel<EditJobWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  String? _textController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 5) {
      return 'Requires at least 5 characters.';
    }

    return null;
  }

  // Stores action output result for [Custom Action - trimTextAction] action in TextField widget.
  String? trimOutput;
  // State field(s) for jobDescription widget.
  FocusNode? jobDescriptionFocusNode;
  TextEditingController? jobDescriptionTextController;
  String? Function(BuildContext, String?)?
      jobDescriptionTextControllerValidator;
  String? _jobDescriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Minimum of 100 characters long. Please provide a detailed and comprehensive description.';
    }

    if (val.length < 100) {
      return 'Requires at least 100 characters.';
    }

    return null;
  }

  // State field(s) for requirements widget.
  FocusNode? requirementsFocusNode;
  TextEditingController? requirementsTextController;
  String? Function(BuildContext, String?)? requirementsTextControllerValidator;
  String? _requirementsTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Minimum of 30 characters long. Please provide a list of requirements.';
    }

    if (val.length < 30) {
      return 'Requires at least 30 characters.';
    }

    return null;
  }

  // State field(s) for appLinkTextField widget.
  FocusNode? appLinkTextFieldFocusNode;
  TextEditingController? appLinkTextFieldTextController;
  String? Function(BuildContext, String?)?
      appLinkTextFieldTextControllerValidator;
  // State field(s) for expDropDown widget.
  int? expDropDownValue;
  FormFieldController<int>? expDropDownValueController;
  // State field(s) for typeDropDown widget.
  String? typeDropDownValue;
  FormFieldController<String>? typeDropDownValueController;
  // State field(s) for locationDropDown widget.
  String? locationDropDownValue;
  FormFieldController<String>? locationDropDownValueController;
  // Model for categoriesDropdown component.
  late CategoriesDropdownModel categoriesDropdownModel;
  // State field(s) for salaryRangeMin widget.
  double? salaryRangeMinValue;
  // State field(s) for salaryRangeMax widget.
  double? salaryRangeMaxValue;
  // State field(s) for Switch widget.
  bool? switchValue;
  DateTime? datePicked;

  @override
  void initState(BuildContext context) {
    textController1Validator = _textController1Validator;
    jobDescriptionTextControllerValidator =
        _jobDescriptionTextControllerValidator;
    requirementsTextControllerValidator = _requirementsTextControllerValidator;
    categoriesDropdownModel =
        createModel(context, () => CategoriesDropdownModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController1?.dispose();

    jobDescriptionFocusNode?.dispose();
    jobDescriptionTextController?.dispose();

    requirementsFocusNode?.dispose();
    requirementsTextController?.dispose();

    appLinkTextFieldFocusNode?.dispose();
    appLinkTextFieldTextController?.dispose();

    categoriesDropdownModel.dispose();
  }
}
