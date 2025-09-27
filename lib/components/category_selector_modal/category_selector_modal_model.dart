import '/components/category_choice_chips/category_choice_chips_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'category_selector_modal_widget.dart' show CategorySelectorModalWidget;
import 'package:flutter/material.dart';

class CategorySelectorModalModel
    extends FlutterFlowModel<CategorySelectorModalWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for categoryChoiceChips component.
  late CategoryChoiceChipsModel categoryChoiceChipsModel;

  @override
  void initState(BuildContext context) {
    categoryChoiceChipsModel =
        createModel(context, () => CategoryChoiceChipsModel());
  }

  @override
  void dispose() {
    categoryChoiceChipsModel.dispose();
  }
}
