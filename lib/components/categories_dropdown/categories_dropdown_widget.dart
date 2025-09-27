import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'categories_dropdown_model.dart';
export 'categories_dropdown_model.dart';

class CategoriesDropdownWidget extends StatefulWidget {
  const CategoriesDropdownWidget({
    super.key,
    this.initalSelection,
  });

  final List<String>? initalSelection;

  @override
  State<CategoriesDropdownWidget> createState() =>
      _CategoriesDropdownWidgetState();
}

class _CategoriesDropdownWidgetState extends State<CategoriesDropdownWidget> {
  late CategoriesDropdownModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CategoriesDropdownModel());
    _model.dropDownValue = widget.initalSelection ?? [];
    _model.dropDownValueController = FormFieldController<List<String>>(_model.dropDownValue);
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: FutureBuilder<List<CategoriesRecord>>(
            future: FFAppState().categories(
              requestFn: () => queryCategoriesRecordOnce(
                queryBuilder: (categoriesRecord) =>
                    categoriesRecord.orderBy('name'),
              ),
            ),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 28.0,
                    height: 28.0,
                    child: SpinKitFoldingCube(
                      color: FlutterFlowTheme.of(context).primary,
                      size: 28.0,
                    ),
                  ),
                );
              }
              List<CategoriesRecord> dropDownCategoriesRecordList =
                  snapshot.data!;

              return FlutterFlowDropDown<String>(
                multiSelectController: _model.dropDownValueController ??=
                    FormFieldController<List<String>>(_model.dropDownValue),
                options: List<String>.from(dropDownCategoriesRecordList
                    .map((e) => e.reference.id)
                    .toList()),
                optionLabels:
                    dropDownCategoriesRecordList.map((e) => e.name).toList(),
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 40.0,
                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      letterSpacing: 0.0,
                    ),
                hintText: '請選擇相關類別...',
                icon: FaIcon(
                  FontAwesomeIcons.chevronDown,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 18.0,
                ),
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
                elevation: 2.0,
                borderColor: FlutterFlowTheme.of(context).primary,
                borderWidth: 2.0,
                borderRadius: 4.0,
                margin: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 8.0, 4.0),
                hidesUnderline: true,
                isOverButton: false,
                isSearchable: false,
                isMultiSelect: true,
                onMultiSelectChanged: (val) {
                  if (val != null) {
                    setState(() => _model.dropDownValue = val);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
