import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'category_choice_chips_model.dart';
export 'category_choice_chips_model.dart';

class CategoryChoiceChipsWidget extends StatefulWidget {
  const CategoryChoiceChipsWidget({
    super.key,
    this.setChoiceChips,
    this.catListParamData,
  });

  final String? setChoiceChips;
  final List<String>? catListParamData;

  @override
  State<CategoryChoiceChipsWidget> createState() =>
      _CategoryChoiceChipsWidgetState();
}

class _CategoryChoiceChipsWidgetState extends State<CategoryChoiceChipsWidget> {
  late CategoryChoiceChipsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CategoryChoiceChipsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoriesRecord>>(
      future: FFAppState().categories(
        requestFn: () => queryCategoriesRecordOnce(
          queryBuilder: (categoriesRecord) => categoriesRecord.orderBy('name'),
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
        List<CategoriesRecord> choiceChipsCategoriesRecordList = snapshot.data!;

        return FlutterFlowChoiceChips(
          options: choiceChipsCategoriesRecordList
              .map((e) => e.name)
              .toList()
              .map((label) => ChipData(label))
              .toList(),
          onChanged: (val) =>
              safeSetState(() => _model.choiceChipsValues = val),
          selectedChipStyle: ChipStyle(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Montserrat',
                  color: FlutterFlowTheme.of(context).primaryBtnText,
                  letterSpacing: 0.0,
                ),
            iconColor: FlutterFlowTheme.of(context).primaryBtnText,
            iconSize: 18.0,
            elevation: 4.0,
            borderColor: FlutterFlowTheme.of(context).secondary,
            borderWidth: 1.0,
            borderRadius: BorderRadius.circular(16.0),
          ),
          unselectedChipStyle: ChipStyle(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Montserrat',
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                ),
            iconColor: FlutterFlowTheme.of(context).primaryText,
            iconSize: 18.0,
            elevation: 4.0,
            borderColor: FlutterFlowTheme.of(context).alternate,
            borderWidth: 1.0,
            borderRadius: BorderRadius.circular(16.0),
          ),
          chipSpacing: 4.0,
          rowSpacing: 12.0,
          multiselect: true,
          initialized: _model.choiceChipsValues != null,
          alignment: WrapAlignment.start,
          controller: _model.choiceChipsValueController ??=
              FormFieldController<List<String>>(
            widget.catListParamData,
          ),
          wrapped: true,
        );
      },
    );
  }
}
