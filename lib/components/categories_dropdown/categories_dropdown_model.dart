import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'categories_dropdown_widget.dart' show CategoriesDropdownWidget;
import 'package:flutter/material.dart';

class CategoriesDropdownModel
    extends FlutterFlowModel<CategoriesDropdownWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  List<String> dropDownValue = [];
  FormFieldController<List<String>>? dropDownValueController;

  @override
  void initState(BuildContext context) {
    dropDownValueController = FormFieldController<List<String>>(dropDownValue);
  }

  @override
  void dispose() {
    dropDownValueController?.dispose();
  }
}
