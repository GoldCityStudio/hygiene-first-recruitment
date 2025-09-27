import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'create_profile_individual_widget.dart'
    show CreateProfileIndividualWidget;
import 'package:flutter/material.dart';

class CreateProfileIndividualModel
    extends FlutterFlowModel<CreateProfileIndividualWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for nameTextField widget.
  FocusNode? nameTextFieldFocusNode;
  TextEditingController? nameTextFieldTextController;
  String? Function(BuildContext, String?)? nameTextFieldTextControllerValidator;
  String? _nameTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 3) {
      return 'Requires at least 3 characters.';
    }

    return null;
  }

  // Stores action output result for [Custom Action - trimTextAction] action in nameTextField widget.
  String? trimOutput;
  // State field(s) for bioTextField widget.
  FocusNode? bioTextFieldFocusNode;
  TextEditingController? bioTextFieldTextController;
  String? Function(BuildContext, String?)? bioTextFieldTextControllerValidator;
  // State field(s) for locationDropDown widget.
  String? locationDropDownValue;
  FormFieldController<String>? locationDropDownValueController;
  // State field(s) for expDropDown widget.
  String? expDropDownValue;
  FormFieldController<String>? expDropDownValueController;

  // State field(s) for sex dropdown.
  String? sexDropDownValue;
  FormFieldController<String>? sexDropDownValueController;

  // State field(s) for street widget.
  TextEditingController? streetTextController;
  FocusNode? streetFocusNode;
  String? Function(BuildContext, String?)? streetTextControllerValidator;

  // State field(s) for building widget.
  TextEditingController? buildingTextController;
  FocusNode? buildingFocusNode;
  String? Function(BuildContext, String?)? buildingTextControllerValidator;

  // State field(s) for floor widget.
  TextEditingController? floorTextController;
  FocusNode? floorFocusNode;
  String? Function(BuildContext, String?)? floorTextControllerValidator;

  // State field(s) for room number widget.
  TextEditingController? roomNumberTextController;
  FocusNode? roomNumberFocusNode;
  String? Function(BuildContext, String?)? roomNumberTextControllerValidator;

  // State field(s) for phone number widget.
  TextEditingController? phoneNumberTextController;
  FocusNode? phoneNumberFocusNode;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;

  // State field(s) for expertise dropdown
  String? expertiseDropDownValue;
  FormFieldController<String>? expertiseDropDownValueController;

  // State field(s) for how know dropdown
  String? howKnowDropDownValue;
  FormFieldController<String>? howKnowDropDownValueController;

  // State field(s) for district dropdown
  String? districtDropDownValue;
  FormFieldController<String>? districtDropDownValueController;

  @override
  void initState(BuildContext context) {
    nameTextFieldTextControllerValidator = _nameTextFieldTextControllerValidator;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    nameTextFieldFocusNode?.dispose();
    nameTextFieldTextController?.dispose();
    bioTextFieldFocusNode?.dispose();
    bioTextFieldTextController?.dispose();
    streetFocusNode?.dispose();
    streetTextController?.dispose();
    buildingFocusNode?.dispose();
    buildingTextController?.dispose();
    floorFocusNode?.dispose();
    floorTextController?.dispose();
    roomNumberFocusNode?.dispose();
    roomNumberTextController?.dispose();
    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();
  }
}
