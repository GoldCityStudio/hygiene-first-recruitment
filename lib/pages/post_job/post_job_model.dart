import '/backend/backend.dart';
import '/components/categories_dropdown/categories_dropdown_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'post_job_widget.dart' show PostJobWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PostJobModel extends FlutterFlowModel<PostJobWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for jobPosTextField widget.
  FocusNode? jobPosTextFieldFocusNode;
  TextEditingController? jobPosTextFieldTextController;
  String? Function(BuildContext, String?)? jobPosTextFieldTextControllerValidator;
  String? trimOutput;
  // State field(s) for jobDescription widget.
  FocusNode? jobDescriptionFocusNode;
  TextEditingController? jobDescriptionTextController;
  String? Function(BuildContext, String?)? jobDescriptionTextControllerValidator;
  // State field(s) for requirements widget.
  FocusNode? requirementsFocusNode;
  TextEditingController? requirementsTextController;
  String? Function(BuildContext, String?)? requirementsTextControllerValidator;
  // State field(s) for appLinkTextField widget.
  FocusNode? appLinkTextFieldFocusNode;
  TextEditingController? appLinkTextFieldTextController;
  String? Function(BuildContext, String?)? appLinkTextFieldTextControllerValidator;
  // State field(s) for workingHoursStart widget.
  String? workingHoursStart;
  FormFieldController<String>? workingHoursStartController;
  // State field(s) for workingHoursEnd widget.
  String? workingHoursEnd;
  FormFieldController<String>? workingHoursEndController;
  // State field(s) for jobType widget.
  String? jobTypeValue;
  FormFieldController<String>? jobTypeValueController;
  // State field(s) for minExperience widget.
  String? minExperienceValue;
  FormFieldController<String>? minExperienceValueController;
  // State field(s) for location widget.
  String? locationValue;
  FormFieldController<String>? locationValueController;
  // State field(s) for salaryType widget.
  String? salaryType;
  FormFieldController<String>? salaryTypeController;
  // State field(s) for minSalary widget.
  String? minSalaryValue;
  FormFieldController<String>? minSalaryValueController;
  // State field(s) for maxSalary widget.
  String? maxSalaryValue;
  FormFieldController<String>? maxSalaryValueController;
  // State field(s) for hourlyRate widget.
  String? hourlyRate;
  FocusNode? hourlyRateFocusNode;
  TextEditingController? hourlyRateController;
  // State field(s) for undisclosedSalary widget.
  bool undisclosedSalary = false;
  // State field(s) for coverLetter widget.
  bool? coverLetterSwitchValue;
  // State field(s) for deadline widget.
  DateTime? deadlineDate;
  FocusNode? deadlineFocusNode;
  TextEditingController? deadlineTextController;
  String? Function(BuildContext, String?)? deadlineTextControllerValidator;
  // State field(s) for startDate widget.
  DateTime? startDate;
  // State field(s) for endDate widget.
  DateTime? endDate;
  // State field(s) for build widget.
  int? build;
  // Model for categoriesDropdown component.
  late CategoriesDropdownModel categoriesDropdownModel;
  // State field(s) for workingHours widget.
  FormFieldController<String>? workingHoursController;
  // State field(s) for salaryRange widget.
  FormFieldController<String>? salaryRangeController;
  FormFieldController<String>? jobPosValueController;
  String? jobPosValue;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    jobPosTextFieldTextControllerValidator = _jobPosTextFieldTextControllerValidator;
    jobDescriptionTextControllerValidator = _jobDescriptionTextControllerValidator;
    requirementsTextControllerValidator = _requirementsTextControllerValidator;
    appLinkTextFieldTextControllerValidator = _appLinkTextFieldTextControllerValidator;
    workingHoursStartController = FormFieldController<String>(null);
    workingHoursEndController = FormFieldController<String>(null);
    jobTypeValueController = FormFieldController<String>(null);
    minExperienceValueController = FormFieldController<String>(null);
    locationValueController = FormFieldController<String>(null);
    salaryTypeController = FormFieldController<String>(null);
    minSalaryValueController = FormFieldController<String>(null);
    maxSalaryValueController = FormFieldController<String>(null);
    hourlyRateFocusNode = FocusNode();
    hourlyRateController = TextEditingController();
    deadlineTextControllerValidator = _deadlineTextControllerValidator;
    categoriesDropdownModel = createModel(context, () => CategoriesDropdownModel());
    workingHoursController = FormFieldController<String>(null);
    salaryRangeController = FormFieldController<String>(null);
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    jobPosTextFieldFocusNode?.dispose();
    jobPosTextFieldTextController?.dispose();

    jobDescriptionFocusNode?.dispose();
    jobDescriptionTextController?.dispose();

    requirementsFocusNode?.dispose();
    requirementsTextController?.dispose();

    appLinkTextFieldFocusNode?.dispose();
    appLinkTextFieldTextController?.dispose();

    workingHoursStartController?.dispose();
    workingHoursEndController?.dispose();
    jobTypeValueController?.dispose();
    minExperienceValueController?.dispose();
    locationValueController?.dispose();
    salaryTypeController?.dispose();
    minSalaryValueController?.dispose();
    maxSalaryValueController?.dispose();
    hourlyRateFocusNode?.dispose();
    hourlyRateController?.dispose();

    deadlineFocusNode?.dispose();
    deadlineTextController?.dispose();

    categoriesDropdownModel.dispose();
    workingHoursController?.dispose();
    salaryRangeController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

  String? _jobPosTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入服務崗位';
    }

    return null;
  }

  String? _jobDescriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入職位描述';
    }

    return null;
  }

  String? _requirementsTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入職位要求';
    }

    return null;
  }

  String? _appLinkTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val != null && val.isNotEmpty) {
      final uri = Uri.tryParse(val);
      if (uri == null || !uri.hasAbsolutePath) {
        return '請輸入有效的URL';
      }
    }
    return null;
  }

  String? _deadlineTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入截止日期';
    }

    return null;
  }
}
