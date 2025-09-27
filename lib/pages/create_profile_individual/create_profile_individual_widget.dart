import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'create_profile_individual_model.dart';
export 'create_profile_individual_model.dart';

class CreateProfileIndividualWidget extends StatefulWidget {
  const CreateProfileIndividualWidget({
    Key? key,
    this.googleOAuth,
  }) : super(key: key);

  final bool? googleOAuth;

  static String get routeName => 'CreateProfileIndividual';
  static String get routePath => 'create-profile-individual';

  @override
  _CreateProfileIndividualWidgetState createState() =>
      _CreateProfileIndividualWidgetState();
}

class _CreateProfileIndividualWidgetState
    extends State<CreateProfileIndividualWidget> {
  late CreateProfileIndividualModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = CreateProfileIndividualModel();

    _model.nameTextFieldTextController ??= TextEditingController();
    _model.nameTextFieldFocusNode ??= FocusNode();

    _model.bioTextFieldTextController ??= TextEditingController();
    _model.bioTextFieldFocusNode ??= FocusNode();

    _model.streetTextController ??= TextEditingController();
    _model.streetFocusNode ??= FocusNode();

    _model.buildingTextController ??= TextEditingController();
    _model.buildingFocusNode ??= FocusNode();

    _model.floorTextController ??= TextEditingController();
    _model.floorFocusNode ??= FocusNode();

    _model.roomNumberTextController ??= TextEditingController();
    _model.roomNumberFocusNode ??= FocusNode();

    _model.phoneNumberTextController ??= TextEditingController();
    _model.phoneNumberFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  double calculateProgress() {
    int totalFields = 10; // Total number of required fields
    int filledFields = 0;

    if (_model.nameTextFieldTextController?.text.isNotEmpty ?? false) filledFields++;
    if (_model.sexDropDownValue != null) filledFields++;
    if (_model.bioTextFieldTextController?.text.isNotEmpty ?? false) filledFields++;
    if (_model.streetTextController?.text.isNotEmpty ?? false) filledFields++;
    if (_model.buildingTextController?.text.isNotEmpty ?? false) filledFields++;
    if (_model.floorTextController?.text.isNotEmpty ?? false) filledFields++;
    if (_model.roomNumberTextController?.text.isNotEmpty ?? false) filledFields++;
    if (_model.districtDropDownValue != null) filledFields++;
    if (_model.expertiseDropDownValue != null) filledFields++;
    if (_model.expDropDownValue != null) filledFields++;

    return filledFields / totalFields;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            '建立個人檔案',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Form(
            key: _model.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                    child: LinearPercentIndicator(
                          percent: calculateProgress(),
                      lineHeight: 12,
                            animation: true,
                            animateFromLastPercent: true,
                            progressColor: FlutterFlowTheme.of(context).primary,
                      backgroundColor: FlutterFlowTheme.of(context).accent4,
                            padding: EdgeInsets.zero,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          '基本資料',
                          style: FlutterFlowTheme.of(context).headlineSmall,
                        ),
                        SizedBox(height: 16),
                                    TextFormField(
                                      controller: _model.nameTextFieldTextController,
                                      focusNode: _model.nameTextFieldFocusNode,
                                          decoration: InputDecoration(
                                            labelText: '姓名',
                            hintText: '請輸入姓名',
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return '請輸入姓名';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        FlutterFlowDropDown<String>(
                          controller: _model.sexDropDownValueController ??=
                              FormFieldController<String>(null),
                          options: ['男', '女'],
                          onChanged: (val) =>
                              setState(() => _model.sexDropDownValue = val),
                                        width: double.infinity,
                          height: 50,
                          textStyle: FlutterFlowTheme.of(context).bodyMedium,
                          hintText: '  性別',
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24,
                                        ),
                          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 2,
                          borderColor: FlutterFlowTheme.of(context).alternate,
                          borderWidth: 2,
                          borderRadius: 8,
                          margin: EdgeInsetsDirectional.fromSTEB(24, 4, 16, 4),
                                        hidesUnderline: true,
                        ),
                        SizedBox(height: 24),
                        Text(
                          '個人簡介',
                          style: FlutterFlowTheme.of(context).headlineSmall,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                            controller: _model.bioTextFieldTextController,
                            focusNode: _model.bioTextFieldFocusNode,
                          maxLines: 3,
                            decoration: InputDecoration(
                            labelText: '簡介',
                            hintText: '請輸入個人簡介',
                            border: OutlineInputBorder(),
                                              ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          '聯絡資料',
                          style: FlutterFlowTheme.of(context).headlineSmall,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                                        controller: _model.streetTextController,
                                        focusNode: _model.streetFocusNode,
                                      decoration: InputDecoration(
                                          labelText: '街道',
                            hintText: '請輸入街道名稱',
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return '請輸入街道名稱';
                            }
                            return null;
                          },
                                    ),
                        SizedBox(height: 16),
                        TextFormField(
                                        controller: _model.buildingTextController,
                                        focusNode: _model.buildingFocusNode,
                                        decoration: InputDecoration(
                                          labelText: '大廈',
                            hintText: '請輸入大廈名稱',
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return '請輸入大廈名稱';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(
                                children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _model.floorTextController,
                                        focusNode: _model.floorFocusNode,
                                        decoration: InputDecoration(
                                          labelText: '樓層',
                                  hintText: '請輸入樓層',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return '請輸入樓層';
                                  }
                                  return null;
                                },
                                      ),
                                    ),
                            SizedBox(width: 16),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _model.roomNumberTextController,
                                        focusNode: _model.roomNumberFocusNode,
                                        decoration: InputDecoration(
                                          labelText: '房號',
                                  hintText: '請輸入房號',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return '請輸入房號';
                                  }
                                  return null;
                                },
                                      ),
                                    ),
                                  ],
                                ),
                        SizedBox(height: 16),
                        FlutterFlowDropDown<String>(
                          controller: _model.districtDropDownValueController ??=
                              FormFieldController<String>(null),
                          options: ['中西區', '灣仔', '東區', '南區', '油尖旺', '深水埗', '九龍城', '黃大仙', '觀塘', '葵青', '荃灣', '屯門', '元朗', '北區', '大埔', '沙田', '西貢', '離島'],
                          onChanged: (val) =>
                              setState(() => _model.districtDropDownValue = val),
                                  width: double.infinity,
                          height: 50,
                          textStyle: FlutterFlowTheme.of(context).bodyMedium,
                          hintText: '  地區',
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24,
                                  ),
                          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 2,
                          borderColor: FlutterFlowTheme.of(context).alternate,
                          borderWidth: 2,
                          borderRadius: 8,
                          margin: EdgeInsetsDirectional.fromSTEB(24, 4, 16, 4),
                                      hidesUnderline: true,
                        ),
                        SizedBox(height: 24),
                        Text(
                          '專業資料',
                          style: FlutterFlowTheme.of(context).headlineSmall,
                              ),
                        SizedBox(height: 16),
                              FlutterFlowDropDown<String>(
                          controller: _model.expertiseDropDownValueController ??=
                              FormFieldController<String>(null),
                          options: ['護士', '護理員', '保健員', '物理治療師', '職業治療師', '言語治療師'],
                          onChanged: (val) =>
                              setState(() => _model.expertiseDropDownValue = val),
                                width: double.infinity,
                          height: 50,
                                textStyle: FlutterFlowTheme.of(context).bodyMedium,
                          hintText: '  專業資格',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24,
                                ),
                          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 2,
                          borderColor: FlutterFlowTheme.of(context).alternate,
                          borderWidth: 2,
                          borderRadius: 8,
                          margin: EdgeInsetsDirectional.fromSTEB(24, 4, 16, 4),
                                      hidesUnderline: true,
                              ),
                        SizedBox(height: 16),
                        FlutterFlowDropDown<String>(
                          controller: _model.expDropDownValueController ??=
                              FormFieldController<String>(null),
                          options: ['1年以下', '1-3年', '3-5年', '5-10年', '10年以上'],
                          onChanged: (val) =>
                              setState(() => _model.expDropDownValue = val),
                                  width: double.infinity,
                          height: 50,
                                  textStyle: FlutterFlowTheme.of(context).bodyMedium,
                          hintText: '  工作經驗',
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24,
                                  ),
                          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 2,
                          borderColor: FlutterFlowTheme.of(context).alternate,
                          borderWidth: 2,
                          borderRadius: 8,
                          margin: EdgeInsetsDirectional.fromSTEB(24, 4, 16, 4),
                          hidesUnderline: true,
                        ),
                        SizedBox(height: 32),
                        FFButtonWidget(
                                onPressed: () async {
                            if (_model.formKey.currentState?.validate() ?? false) {
                              try {
                                // Convert experience string to number
                                int experienceValue;
                                switch (_model.expDropDownValue) {
                                  case '1年以下':
                                    experienceValue = 0;
                                    break;
                                  case '1-3年':
                                    experienceValue = 2;
                                    break;
                                  case '3-5年':
                                    experienceValue = 4;
                                    break;
                                  case '5-10年':
                                    experienceValue = 7;
                                    break;
                                  case '10年以上':
                                    experienceValue = 10;
                                    break;
                                  default:
                                    experienceValue = 0;
                                }

                                // Update user profile in Firebase
                                  await currentUserReference!.update({
                                  'displayName': _model.nameTextFieldTextController.text,
                                  'description': _model.bioTextFieldTextController.text,
                                  'gender': _model.sexDropDownValue,
                                  'address': '${_model.streetTextController.text}, ${_model.buildingTextController.text}, ${_model.floorTextController.text}樓, ${_model.roomNumberTextController.text}室',
                                  'district': _model.districtDropDownValue,
                                  'expertise': _model.expertiseDropDownValue,
                                  'experience': experienceValue,
                                  'type': 'Individual',
                                  'verified_account': false,
                                  'email_notifications': true,
                                  'push_notifications': true,
                                });

                                // Show success message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '個人資料已成功建立！',
                                        style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                      backgroundColor: FlutterFlowTheme.of(context).success,
                                    ),
                                  );

                                // Navigate to home page after short delay
                                  await Future.delayed(const Duration(milliseconds: 500));
                                context.goNamed('HomePage');

                                // Send email verification
                                  await authManager.sendEmailVerification();
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '更新個人資料時發生錯誤：$e',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: FlutterFlowTheme.of(context).error,
                                  ),
                                );
                              }
                            }
                          },
                          text: '提交',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 50,
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                ),
                            elevation: 3,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                              width: 1,
                                  ),
                            borderRadius: BorderRadius.circular(8),
                                ),
                        ),
                      ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}

