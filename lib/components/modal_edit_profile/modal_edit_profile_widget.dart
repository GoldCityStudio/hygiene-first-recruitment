import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'modal_edit_profile_model.dart';
export 'modal_edit_profile_model.dart';

class ModalEditProfileWidget extends StatefulWidget {
  final UsersRecord userDoc;

  const ModalEditProfileWidget({
    Key? key,
    required this.userDoc,
  }) : super(key: key);

  @override
  _ModalEditProfileWidgetState createState() => _ModalEditProfileWidgetState();
}

class _ModalEditProfileWidgetState extends State<ModalEditProfileWidget>
    with TickerProviderStateMixin {
  late ModalEditProfileModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = ModalEditProfileModel();
    _model.initState(context);

    // Parse address into components
    final address = widget.userDoc.address;
    if (address != null && address.isNotEmpty) {
      final parts = address.split(', ');
      if (parts.length >= 4) {
        _model.streetTextController ??= TextEditingController(text: parts[0]);
        _model.buildingTextController ??= TextEditingController(text: parts[1]);
        _model.floorTextController ??= TextEditingController(text: parts[2].replaceAll('樓', ''));
        _model.roomNumberTextController ??= TextEditingController(text: parts[3].replaceAll('室', ''));
      }
    } else {
      _model.streetTextController ??= TextEditingController();
      _model.buildingTextController ??= TextEditingController();
      _model.floorTextController ??= TextEditingController();
      _model.roomNumberTextController ??= TextEditingController();
    }

    // Initialize other text controllers with user data
    _model.fullNameTextController ??= TextEditingController(text: widget.userDoc.displayName ?? '');
    _model.chineseNameTextController ??= TextEditingController(text: widget.userDoc.chineseName);
    _model.dateOfBirthTextController ??= TextEditingController(
      text: widget.userDoc.dateOfBirth?.toString() ?? '',
    );
    _model.addressTextController ??= TextEditingController(text: widget.userDoc.address);
    _model.phoneNumberTextController ??= TextEditingController(text: widget.userDoc.phoneNumber);
    _model.whatsappNumberTextController ??= TextEditingController(text: widget.userDoc.whatsappNumber);
    _model.currentPositionTextController ??= TextEditingController(text: widget.userDoc.currentPosition);
    _model.currentCompanyTextController ??= TextEditingController(text: widget.userDoc.currentCompany);
    _model.preferredLocationsTextController ??= TextEditingController(
      text: widget.userDoc.preferredLocations?.join(', ') ?? '',
    );
    _model.preferredIndustriesTextController ??= TextEditingController(
      text: widget.userDoc.preferredIndustries?.join(', ') ?? '',
    );
    _model.preferredJobTypesTextController ??= TextEditingController(
      text: widget.userDoc.preferredJobTypes?.join(', ') ?? '',
    );
    _model.workScheduleTextController ??= TextEditingController(text: widget.userDoc.workSchedule);
    _model.streetTextController ??= TextEditingController(text: widget.userDoc.street);
    _model.buildingTextController ??= TextEditingController(text: widget.userDoc.building);
    _model.floorTextController ??= TextEditingController(text: widget.userDoc.floor);
    _model.roomNumberTextController ??= TextEditingController(text: widget.userDoc.roomNumber);
    _model.credentialsTextController ??= TextEditingController(text: widget.userDoc.credentials);
    _model.websiteEditTextController ??= TextEditingController(text: widget.userDoc.website);
    _model.educationTextController ??= TextEditingController(text: widget.userDoc.education);
    _model.certificationsTextController ??= TextEditingController(
      text: widget.userDoc.certifications?.join(', ') ?? '',
    );

    // Initialize dropdown values
    _model.genderDropDownValue = widget.userDoc.gender;
    _model.districtDropDownValue = widget.userDoc.district;
    _model.expertiseDropDownValue = widget.userDoc.expertise;
    _model.howKnowDropDownValue = widget.userDoc.howKnow;
    _model.expDropDownValue = widget.userDoc.experience?.toString();
    _model.locationDropDownValue = widget.userDoc.location;
    _model.languageDropDownValue = widget.userDoc.languages?.firstOrNull;

    // Initialize selected languages
    _model.selectedLanguages = widget.userDoc.languages ?? [];

    // Initialize selected skills
    _model.selectedSkills = widget.userDoc.skills ?? [];

    // Initialize date of birth
    _model.dateOfBirth = widget.userDoc.dateOfBirth;

    // Initialize uploaded file URLs
    _model.uploadedFileUrl1 = widget.userDoc.photoUrl;
    _model.uploadedFileUrl2 = widget.userDoc.idCardUrl;
    _model.uploadedFileUrls3 = widget.userDoc.otherDocuments ?? [];
    _model.uploadedFileUrlIdCard = widget.userDoc.idCardUrl;
    _model.uploadedFileUrlOtherDocs = widget.userDoc.otherDocuments?.firstOrNull;

    // Initialize dropdown controllers with values
    _model.genderDropDownController = FormFieldController<String>(_model.genderDropDownValue);
    _model.districtDropDownController = FormFieldController<String>(_model.districtDropDownValue);
    _model.expertiseDropDownController = FormFieldController<String>(_model.expertiseDropDownValue);
    _model.howKnowDropDownController = FormFieldController<String>(_model.howKnowDropDownValue);
    _model.expDropDownValueController = FormFieldController<String>(_model.expDropDownValue);
    _model.locationDropDownValueController = FormFieldController<String>(_model.locationDropDownValue);
    _model.languageDropDownValueController = FormFieldController<String>(_model.languageDropDownValue);

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 300.ms),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.0, 100.0),
            end: Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _model.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Stack(
        children: [
          Container(
      width: double.infinity,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
              minHeight: 400,
            ),
      decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 15,
                  offset: Offset(0, 4),
                ),
              ],
            ),
        child: Column(
              mainAxisSize: MainAxisSize.min,
          children: [
                // Close Button
            Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                // Progress Bar
                Container(
                  height: 8,
                  margin: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
                  child: Row(
                    children: [
                      Expanded(
              child: Container(
                          decoration: BoxDecoration(
                            color: _model.currentSection >= 1
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          height: 8,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Container(
                decoration: BoxDecoration(
                            color: _model.currentSection >= 2
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          height: 8,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: _model.currentSection >= 3
                                ? FlutterFlowTheme.of(context).primary
                                : FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          height: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                child: SingleChildScrollView(
                    controller: ScrollController(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                        // Section 1: Basic Information
                        if (_model.currentSection == 1) ...[
                      Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
                            child: Column(
                              children: [
                                // Profile Picture Section
                                Container(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                  child: Column(
                                    children: [
                                      Text(
                                        '個人照片',
                                        style: FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Stack(
                                      children: [
                                        Container(
                                            width: 120,
                                            height: 120,
                                          decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: FlutterFlowTheme.of(context).primary,
                                                width: 2,
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(60),
                                            child: Image.network(
                                                widget.userDoc.photoUrl,
                                                width: 120,
                                                height: 120,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                              child: Container(
                                              width: 40,
                                              height: 40,
                                                decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(context).primary,
                                                shape: BoxShape.circle,
                                              ),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.camera_alt,
                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                  size: 20,
                                                ),
                                                onPressed: _uploadFile1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Personal Information Section
                                Container(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                      Text(
                                        '個人資料',
                                        style: FlutterFlowTheme.of(context).titleMedium.override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      // Name
                                      TextFormField(
                                        controller: _model.fullNameTextController,
                                        focusNode: _model.fullNameFocusNode,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: '姓名',
                                          labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                          hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).alternate,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).primary,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyMedium,
                                        validator: _model.fullNameTextControllerValidator,
                                      ),
                                      SizedBox(height: 16),
                                      // Email (Read-only)
                                      TextFormField(
                                        initialValue: widget.userDoc.email,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          labelText: '電郵',
                                          labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                          hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).alternate,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).primary,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyMedium,
                                      ),
                                      SizedBox(height: 16),
                                      // Gender and Date of Birth Row
                                      Row(
                                        children: [
                                          Expanded(
                                            child: FlutterFlowDropDown<String>(
                                              controller: _model.genderDropDownController,
                                              options: ['男', '女', '其他'],
                                              onChanged: (val) =>
                                                  setState(() => _model.genderDropDownValue = val),
                                              height: 56,
                                              textStyle: FlutterFlowTheme.of(context).bodyMedium,
                                              hintText: '請選擇性別',
                                              icon: Icon(
                                                Icons.keyboard_arrow_down_rounded,
                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                size: 24,
                                              ),
                                              fillColor: Colors.white,
                                              elevation: 2,
                                              borderColor: FlutterFlowTheme.of(context).alternate,
                                              borderWidth: 2,
                                              borderRadius: 12,
                                              margin: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                                              hidesUnderline: true,
                                              isSearchable: false,
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Expanded(
                                                      child: InkWell(
                                                        onTap: () async {
                                                final date = await showDatePicker(
                                                            context: context,
                                                  initialDate: _model.dateOfBirth ?? DateTime.now(),
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime.now(),
                                                );
                                                if (date != null) {
                                                  setState(() {
                                                    _model.dateOfBirth = date;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                width: 56.0,
                                                height: 56.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        _model.dateOfBirth != null
                                                            ? DateFormat('yyyy-MM-dd')
                                                                .format(_model.dateOfBirth!)
                                                            : '請選擇出生日期',
                                                        style: FlutterFlowTheme.of(context).bodyMedium,
                                                      ),
                                                      Icon(
                                                        Icons.calendar_today,
                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                        size: 24,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                      SizedBox(height: 16),
                                      // Address
                                      TextFormField(
                                        controller: _model.streetTextController,
                                        focusNode: _model.streetFocusNode,
                                        decoration: InputDecoration(
                                          labelText: '街道',
                                          labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                          hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).alternate,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).primary,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyMedium,
                                        validator: _model.streetTextControllerValidator,
                                      ),
                                      SizedBox(height: 16),
                                      TextFormField(
                                        controller: _model.buildingTextController,
                                        focusNode: _model.buildingFocusNode,
                                        decoration: InputDecoration(
                                          labelText: '大廈',
                                          labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                          hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).alternate,
                                            width: 2.0,
                                          ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).primary,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyMedium,
                                        validator: _model.buildingTextControllerValidator,
                                      ),
                                      SizedBox(height: 16),
                                      TextFormField(
                                        controller: _model.floorTextController,
                                        focusNode: _model.floorFocusNode,
                                        decoration: InputDecoration(
                                          labelText: '樓層',
                                          labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                          hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                          enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).alternate,
                                            width: 2.0,
                                          ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).primary,
                                            width: 2.0,
                                          ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyMedium,
                                        validator: _model.floorTextControllerValidator,
                                      ),
                                      SizedBox(height: 16),
                                      TextFormField(
                                        controller: _model.roomNumberTextController,
                                        focusNode: _model.roomNumberFocusNode,
                                        decoration: InputDecoration(
                                          labelText: '房號',
                                          labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                          hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).alternate,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).primary,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyMedium,
                                        validator: _model.roomNumberTextControllerValidator,
                                      ),
                                      SizedBox(height: 16),
                                      FlutterFlowDropDown<String>(
                                        controller: _model.districtDropDownController,
                                        options: [
                                          '中西區',
                                          '灣仔區',
                                          '東區',
                                          '南區',
                                          '油尖旺區',
                                          '深水埗區',
                                          '九龍城區',
                                          '黃大仙區',
                                          '觀塘區',
                                          '葵青區',
                                          '荃灣區',
                                          '屯門區',
                                          '元朗區',
                                          '北區',
                                          '大埔區',
                                          '沙田區',
                                          '西貢區',
                                          '離島區'
                                        ],
                                        onChanged: (val) =>
                                            setState(() => _model.districtDropDownValue = val),
                                        width: double.infinity,
                                        height: 50.0,
                                        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        letterSpacing: 0.0,
                                      ),
                                        hintText: '請選擇地區',
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                          size: 24.0,
                                        ),
                                        fillColor: Colors.white,
                                        elevation: 2.0,
                                        borderColor: FlutterFlowTheme.of(context).alternate,
                                        borderWidth: 2.0,
                                        borderRadius: 8.0,
                                        margin: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                                        hidesUnderline: true,
                                        isSearchable: false,
                                        isMultiSelect: false,
                                      ),
                                    ],
                                  ),
                                ),
                                // Contact Information Section
                                Container(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '聯絡資料',
                                        style: FlutterFlowTheme.of(context).titleMedium.override(
                                            fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      // Phone Number
                                      TextFormField(
                                        controller: _model.phoneNumberTextController,
                                        focusNode: _model.phoneNumberFocusNode,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: '電話號碼',
                                          labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                          hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).alternate,
                                          width: 2.0,
                                        ),
                                            borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).primary,
                                          width: 2.0,
                                        ),
                                            borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                          width: 2.0,
                                        ),
                                            borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                          width: 2.0,
                                        ),
                                            borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyMedium,
                                        validator: _model.phoneNumberTextControllerValidator,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        // Section 2: Professional Details
                        if (_model.currentSection == 2) ...[
                            Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
                            child: Column(
                              children: [
                                // Current Position
                                TextFormField(
                                  controller: _model.currentPositionTextController,
                                  focusNode: _model.currentPositionFocusNode,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: '現職',
                                    labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                    hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primary,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium,
                                  validator: _model.currentPositionTextControllerValidator,
                                ),
                                SizedBox(height: 16),
                                // Current Company
                                TextFormField(
                                  controller: _model.currentCompanyTextController,
                                  focusNode: _model.currentCompanyFocusNode,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: '現職公司',
                                    labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                    hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primary,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium,
                                  validator: _model.currentCompanyTextControllerValidator,
                                ),
                                SizedBox(height: 16),
                                // Credentials
                                Container(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '專業資格',
                                        style: FlutterFlowTheme.of(context).titleMedium.override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      InkWell(
                                        onTap: _uploadCredentials,
                                        child: Container(
                                          width: double.infinity,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: FlutterFlowTheme.of(context).alternate,
                                              width: 2,
                                            ),
                                          ),
                                          child: _model.uploadedFileUrlCredentials != null
                                              ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: Image.network(
                                                    _model.uploadedFileUrlCredentials!,
                                                    width: double.infinity,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.upload_file,
                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                      size: 48,
                                                    ),
                                                    SizedBox(height: 16),
                                                    Text(
                                                      '上傳專業資格',
                                                      style: FlutterFlowTheme.of(context).bodyMedium,
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Expertise (Single choice)
                                FlutterFlowDropDown<String>(
                                  controller: _model.expertiseDropDownController,
                                  options: [
                                    '註冊護士 (RN)',
                                    '登記護士 (EN)',
                                    '物理治療師 (PT)',
                                    '職業治療師 (OT)',
                                    '言語治療師 (ST)',
                                    '營養師 (Dietitian)',
                                    '物理治療師助理 (PTA)',
                                    '職業治療師助理 (OTA)',
                                    '註冊醫生 (VMO Doctor)',
                                    '註冊社工 (SWA/ASWO)',
                                    '陪診員 (Escort Service)',
                                    '診所助護 (Clinic Nurse)',
                                    '抽血員 (Phlebotomist)',
                                    '活動助理 (Programme Worker)',
                                    '保健員 (HCA/HW)',
                                    '護理員 (PCW/PCA)',
                                    '司機 (Driver)',
                                    '廚師 (Chef)',
                                    '廚房幫工/工友/庶務員(WM)',
                                    '看守員',
                                  ],
                                  onChanged: (val) =>
                                      setState(() => _model.expertiseDropDownValue = val),
                                  width: double.infinity,
                                  height: 56,
                                  textStyle: FlutterFlowTheme.of(context).bodyMedium,
                                  hintText: '請選擇專業',
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    size: 24,
                                  ),
                                  fillColor: Colors.white,
                                  elevation: 2,
                                  borderColor: FlutterFlowTheme.of(context).alternate,
                                  borderWidth: 2,
                                  borderRadius: 12,
                                  margin: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                                  hidesUnderline: true,
                                  isSearchable: false,
                                ),
                              ],
                            ),
                          ),
                        ],
                        // Section 3: Necessary Documents
                        if (_model.currentSection == 3) ...[
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
                            child: Column(
                              children: [
                                // Personal ID Upload
                                Container(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '身份證',
                                        style: FlutterFlowTheme.of(context).titleMedium.override(
                                                  fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                      SizedBox(height: 16),
                                      InkWell(
                                        onTap: _uploadFile1,
                                        child: Container(
                                          width: double.infinity,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: FlutterFlowTheme.of(context).alternate,
                                              width: 2,
                                            ),
                                          ),
                                          child: _model.uploadedFileUrl1 != null
                                              ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: Image.network(
                                                    _model.uploadedFileUrl1!,
                                                    width: double.infinity,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.upload_file,
                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                      size: 48,
                                                    ),
                                                    SizedBox(height: 16),
                                                    Text(
                                                      '上傳身份證',
                                                      style: FlutterFlowTheme.of(context).bodyMedium,
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Other Documents Upload
                                Container(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '其他文件',
                                        style: FlutterFlowTheme.of(context).titleMedium.override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      // 相關證書
                                      Container(
                                        margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '相關證書',
                                              style: FlutterFlowTheme.of(context).bodyMedium,
                                            ),
                                            SizedBox(height: 8),
                                      InkWell(
                                        onTap: () async {
                                          final selectedMedia = await selectMedia(
                                            mediaSource: MediaSource.photoGallery,
                                                  multiImage: false,
                                          );
                                          if (selectedMedia != null &&
                                              selectedMedia.every((m) => validateFileFormat(
                                                  m.storagePath, context))) {
                                            setState(() => _model.isDataUploading = true);
                                            var selectedUploadedFiles = <FFUploadedFile>[];

                                            try {
                                              selectedUploadedFiles = selectedMedia
                                                  .map((m) => FFUploadedFile(
                                                        name: m.storagePath.split('/').last,
                                                        bytes: m.bytes,
                                                        height: m.dimensions?.height,
                                                        width: m.dimensions?.width,
                                                        blurHash: m.blurHash,
                                                      ))
                                                  .toList();
                                            } finally {
                                              _model.isDataUploading = false;
                                            }

                                                  if (selectedUploadedFiles.length == selectedMedia.length) {
                                              setState(() {
                                                _model.uploadedLocalFiles3 = selectedUploadedFiles;
                                              });
                                                final storageRef = firebase_storage.FirebaseStorage.instance
                                                    .ref()
                                                    .child('users')
                                                    .child(currentUserUid)
                                                    .child('other_documents')
                                                        .child('certificate.jpg');

                                                    final uploadTask = storageRef.putData(selectedUploadedFiles[0].bytes!);
                                                    await uploadTask;
                                                    final url = await storageRef.getDownloadURL();
                                                    setState(() {
                                                      _model.uploadedFileUrls3.add(url);
                                                    });
                                                  }
                                                }
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(context).alternate,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: _model.uploadedFileUrls3.isNotEmpty
                                                    ? ClipRRect(
                                                        borderRadius: BorderRadius.circular(12),
                                                        child: Image.network(
                                                          _model.uploadedFileUrls3[0],
                                                          width: double.infinity,
                                                          height: 120,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    : Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Icon(
                                                            Icons.upload_file,
                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                            size: 32,
                                                          ),
                                                          SizedBox(height: 8),
                                                          Text(
                                                            '上傳相關證書',
                                                            style: FlutterFlowTheme.of(context).bodyMedium,
                                                          ),
                                                        ],
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // 體檢證明
                                      Container(
                                        margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '體檢證明',
                                              style: FlutterFlowTheme.of(context).bodyMedium,
                                            ),
                                            SizedBox(height: 8),
                                            InkWell(
                                              onTap: () async {
                                                final selectedMedia = await selectMedia(
                                                  mediaSource: MediaSource.photoGallery,
                                                  multiImage: false,
                                                );
                                                if (selectedMedia != null &&
                                                    selectedMedia.every((m) => validateFileFormat(
                                                        m.storagePath, context))) {
                                                  setState(() => _model.isDataUploading = true);
                                                  var selectedUploadedFiles = <FFUploadedFile>[];

                                                  try {
                                                    selectedUploadedFiles = selectedMedia
                                                        .map((m) => FFUploadedFile(
                                                              name: m.storagePath.split('/').last,
                                                              bytes: m.bytes,
                                                              height: m.dimensions?.height,
                                                              width: m.dimensions?.width,
                                                              blurHash: m.blurHash,
                                                            ))
                                                        .toList();
                                                  } finally {
                                                    _model.isDataUploading = false;
                                                  }

                                                  if (selectedUploadedFiles.length == selectedMedia.length) {
                                                    setState(() {
                                                      _model.uploadedLocalFiles3 = selectedUploadedFiles;
                                                    });
                                                    final storageRef = firebase_storage.FirebaseStorage.instance
                                                        .ref()
                                                        .child('users')
                                                        .child(currentUserUid)
                                                        .child('other_documents')
                                                        .child('health_check.jpg');

                                                    final uploadTask = storageRef.putData(selectedUploadedFiles[0].bytes!);
                                                await uploadTask;
                                                final url = await storageRef.getDownloadURL();
                                                    setState(() {
                                                _model.uploadedFileUrls3.add(url);
                                                    });
                                                  }
                                                }
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(context).alternate,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: _model.uploadedFileUrls3.length > 1
                                                    ? ClipRRect(
                                                        borderRadius: BorderRadius.circular(12),
                                                        child: Image.network(
                                                          _model.uploadedFileUrls3[1],
                                                          width: double.infinity,
                                                          height: 120,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    : Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Icon(
                                                            Icons.upload_file,
                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                            size: 32,
                                                          ),
                                                          SizedBox(height: 8),
                                                          Text(
                                                            '上傳體檢證明',
                                                            style: FlutterFlowTheme.of(context).bodyMedium,
                                                          ),
                                                        ],
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // 性罪行查核結果
                                      Container(
                                        margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '性罪行查核結果',
                                              style: FlutterFlowTheme.of(context).bodyMedium,
                                            ),
                                            SizedBox(height: 8),
                                            InkWell(
                                              onTap: () async {
                                                final selectedMedia = await selectMedia(
                                                  mediaSource: MediaSource.photoGallery,
                                                  multiImage: false,
                                                );
                                                if (selectedMedia != null &&
                                                    selectedMedia.every((m) => validateFileFormat(
                                                        m.storagePath, context))) {
                                                  setState(() => _model.isDataUploading = true);
                                                  var selectedUploadedFiles = <FFUploadedFile>[];

                                                  try {
                                                    selectedUploadedFiles = selectedMedia
                                                        .map((m) => FFUploadedFile(
                                                              name: m.storagePath.split('/').last,
                                                              bytes: m.bytes,
                                                              height: m.dimensions?.height,
                                                              width: m.dimensions?.width,
                                                              blurHash: m.blurHash,
                                                            ))
                                                        .toList();
                                                  } finally {
                                                    _model.isDataUploading = false;
                                                  }

                                                  if (selectedUploadedFiles.length == selectedMedia.length) {
                                                    setState(() {
                                                      _model.uploadedLocalFiles3 = selectedUploadedFiles;
                                                    });
                                                    final storageRef = firebase_storage.FirebaseStorage.instance
                                                        .ref()
                                                        .child('users')
                                                        .child(currentUserUid)
                                                        .child('other_documents')
                                                        .child('sex_offender_check.jpg');

                                                    final uploadTask = storageRef.putData(selectedUploadedFiles[0].bytes!);
                                                    await uploadTask;
                                                    final url = await storageRef.getDownloadURL();
                                                    setState(() {
                                                      _model.uploadedFileUrls3.add(url);
                                                    });
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: double.infinity,
                                                height: 120,
                                          decoration: BoxDecoration(
                                                  color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: FlutterFlowTheme.of(context).alternate,
                                              width: 2,
                                            ),
                                          ),
                                                child: _model.uploadedFileUrls3.length > 2
                                                    ? ClipRRect(
                                                        borderRadius: BorderRadius.circular(12),
                                                    child: Image.network(
                                                          _model.uploadedFileUrls3[2],
                                                          width: double.infinity,
                                                          height: 120,
                                                      fit: BoxFit.cover,
                                                    ),
                                                      )
                                                    : Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Icon(
                                                            Icons.upload_file,
                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                            size: 32,
                                                          ),
                                                          SizedBox(height: 8),
                                                          Text(
                                                            '上傳性罪行查核結果',
                                                            style: FlutterFlowTheme.of(context).bodyMedium,
                                                          ),
                                                        ],
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // 新冠疫苗接種紀錄
                                      Container(
                                        margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '新冠疫苗接種紀錄',
                                              style: FlutterFlowTheme.of(context).bodyMedium,
                                            ),
                                            SizedBox(height: 8),
                                            InkWell(
                                              onTap: () async {
                                                final selectedMedia = await selectMedia(
                                                  mediaSource: MediaSource.photoGallery,
                                                  multiImage: false,
                                                );
                                                if (selectedMedia != null &&
                                                    selectedMedia.every((m) => validateFileFormat(
                                                        m.storagePath, context))) {
                                                  setState(() => _model.isDataUploading = true);
                                                  var selectedUploadedFiles = <FFUploadedFile>[];

                                                  try {
                                                    selectedUploadedFiles = selectedMedia
                                                        .map((m) => FFUploadedFile(
                                                              name: m.storagePath.split('/').last,
                                                              bytes: m.bytes,
                                                              height: m.dimensions?.height,
                                                              width: m.dimensions?.width,
                                                              blurHash: m.blurHash,
                                                            ))
                                                        .toList();
                                                  } finally {
                                                    _model.isDataUploading = false;
                                                  }

                                                  if (selectedUploadedFiles.length == selectedMedia.length) {
                                                    setState(() {
                                                      _model.uploadedLocalFiles3 = selectedUploadedFiles;
                                                    });
                                                    final storageRef = firebase_storage.FirebaseStorage.instance
                                                        .ref()
                                                        .child('users')
                                                        .child(currentUserUid)
                                                        .child('other_documents')
                                                        .child('vaccination_record.jpg');

                                                    final uploadTask = storageRef.putData(selectedUploadedFiles[0].bytes!);
                                                    await uploadTask;
                                                    final url = await storageRef.getDownloadURL();
                                                    setState(() {
                                                      _model.uploadedFileUrls3.add(url);
                                                    });
                                                  }
                                                }
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(context).alternate,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: _model.uploadedFileUrls3.length > 3
                                                    ? ClipRRect(
                                                        borderRadius: BorderRadius.circular(12),
                                                        child: Image.network(
                                                          _model.uploadedFileUrls3[3],
                                                          width: double.infinity,
                                                          height: 120,
                                                          fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.upload_file,
                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                            size: 32,
                                                    ),
                                                          SizedBox(height: 8),
                                                    Text(
                                                            '上傳新冠疫苗接種紀錄',
                                                      style: FlutterFlowTheme.of(context).bodyMedium,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        // Last Section: How they know Hygiene First
                        if (_model.currentSection == 4) ...[
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                            child: Column(
                              children: [
                                Text(
                                  '你是如何知道Hygiene First的？',
                                  style: FlutterFlowTheme.of(context).titleMedium.override(
                                                  fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                SizedBox(height: 16),
                                FlutterFlowDropDown<String>(
                                  controller: _model.howKnowDropDownController,
                                  options: [
                                    '社交媒體',
                                    '朋友或家人',
                                    '網上搜尋',
                                    '廣告',
                                    '活動或工作坊',
                                    '其他',
                                  ],
                                  onChanged: (val) => setState(() => _model.howKnowDropDownValue = val),
                                  height: 56,
                                  textStyle: FlutterFlowTheme.of(context).bodyMedium,
                                  hintText: '請選擇',
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    size: 24,
                                  ),
                                  fillColor: Colors.white,
                                  elevation: 2,
                                  borderColor: FlutterFlowTheme.of(context).alternate,
                                  borderWidth: 2,
                                  borderRadius: 12,
                                  margin: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                                  hidesUnderline: true,
                                  isSearchable: false,
                                ),
                              ],
                            ),
                          ),
                        ],
                        // Navigation Buttons
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (_model.currentSection > 1)
                                FFButtonWidget(
                                  onPressed: () {
                                    setState(() {
                                      _model.currentSection--;
                                    });
                                  },
                                  text: '上一步',
                                  options: FFButtonOptions(
                                    width: 130,
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).primaryText,
                                    ),
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).alternate,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              FFButtonWidget(
                                onPressed: () async {
                                  if (_model.currentSection < 4) {
                                    setState(() {
                                      _model.currentSection++;
                                    });
                                  } else {
                                    // Save changes
                                    if (_model.formKey.currentState?.validate() ?? false) {
                                      await currentUserReference!.update({
                                        'email': currentUserEmail,
                                        'displayName': _model.fullNameTextController.text,
                                        'photo_url': _model.uploadedFileUrlPhoto,
                                        'gender': _model.genderDropDownValue,
                                        'date_of_birth': _model.dateOfBirth,
                                        'address': '${_model.streetTextController.text}, ${_model.buildingTextController.text}, ${_model.floorTextController.text}樓, ${_model.roomNumberTextController.text}室',
                                        'phone_number': _model.phoneNumberTextController.text,
                                        'whatsapp_number': _model.whatsappNumberTextController.text,
                                        'current_position': _model.currentPositionTextController.text,
                                        'current_company': _model.currentCompanyTextController.text,
                                        'credentials': _model.credentialsTextController?.text,
                                        'expertise': _model.expertiseDropDownValue,
                                        'id_card_url': _model.uploadedFileUrlIdCard,
                                        'credentials_url': _model.uploadedFileUrlCredentials,
                                        'languages': _model.selectedLanguages,
                                        'skills': _model.selectedSkills,
                                        'education': _model.educationTextController.text,
                                        'certifications': _model.certificationsTextController.text.split(',').map((e) => e.trim()).toList(),
                                        'preferred_locations': _model.preferredLocationsTextController.text.split(',').map((e) => e.trim()).toList(),
                                        'preferred_industries': _model.preferredIndustriesTextController.text.split(',').map((e) => e.trim()).toList(),
                                        'preferred_job_types': _model.preferredJobTypesTextController.text.split(',').map((e) => e.trim()).toList(),
                                        'work_schedule': _model.workScheduleTextController.text,
                                        'how_know': _model.howKnowDropDownValue,
                                        'district': _model.districtDropDownValue,
                                        'location': _model.locationDropDownValue,
                                        'description': _model.bioTextController?.text,
                                        'profile_photo_blurhash': _model.uploadedLocalFilePhoto?.blurHash,
                                        'type': 'Individual',
                                      });
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                text: _model.currentSection < 4 ? '下一步' : '儲存變更',
                                options: FFButtonOptions(
                                  width: 130,
                                  height: 40,
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                        fontFamily: 'Montserrat',
                                    color: Colors.white,
                                      ),
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
                    ],
                  ),
                ),
          // Add a loading spinner to indicate when a file is being uploaded
          if (_model.isDataUploading)
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(FlutterFlowTheme.of(context).primary),
              ),
            ),
        ],
      ),
    );
  }

  String _getSectionTitle(int section) {
    switch (section) {
      case 1:
        return '基本資料';
      case 2:
        return '專業資料';
      case 3:
        return '必要文件';
      default:
        return '';
    }
  }

  Future<void> _uploadFile1() async {
    // Profile photo - only allow images
    final selectedMedia = await selectMediaWithSourceBottomSheet(
      context: context,
      allowPhoto: true,
      allowVideo: false,
      maxWidth: 1200.00,
      maxHeight: 1200.00,
      imageQuality: 85,
    );
    if (selectedMedia != null &&
        selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
      setState(() => _model.isDataUploading = true);
      var selectedUploadedFiles = <FFUploadedFile>[];

      try {
        selectedUploadedFiles = selectedMedia
            .map((m) => FFUploadedFile(
                  name: m.storagePath.split('/').last,
                  bytes: m.bytes,
                  height: m.dimensions?.height,
                  width: m.dimensions?.width,
                  blurHash: m.blurHash,
                ))
            .toList();
      } finally {
        _model.isDataUploading = false;
      }
      if (selectedUploadedFiles.length == selectedMedia.length) {
        setState(() {
          _model.uploadedLocalFilePhoto = selectedUploadedFiles.first;
        });
        showUploadMessage(context, 'Uploading profile picture...');
        try {
          final downloadUrl = await uploadData(
            'users/${currentUserUid}/profile_photo.jpg',
            selectedUploadedFiles.first.bytes!,
          );
          _model.uploadedFileUrlPhoto = downloadUrl;
          await currentUserReference!.update({
            'photo_url': downloadUrl,
          });
          showUploadMessage(context, 'Profile picture uploaded successfully!');
        } catch (e) {
          showUploadMessage(context, 'Failed to upload profile picture: $e');
        }
      } else {
        setState(() {});
        showUploadMessage(context, 'Failed to upload profile picture');
      }
    }
  }

  Future<void> _uploadFile2() async {
    // ID Card - allow images and PDFs
    final selectedMedia = await selectMediaWithSourceBottomSheet(
      context: context,
      allowPhoto: true,
      allowVideo: false,
      maxWidth: 1200.00,
      maxHeight: 1200.00,
      imageQuality: 85,
    );
    if (selectedMedia != null &&
        selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
      setState(() => _model.isDataUploading = true);
      var selectedUploadedFiles = <FFUploadedFile>[];

      try {
        selectedUploadedFiles = selectedMedia
            .map((m) => FFUploadedFile(
                  name: m.storagePath.split('/').last,
                  bytes: m.bytes,
                  height: m.dimensions?.height,
                  width: m.dimensions?.width,
                  blurHash: m.blurHash,
                ))
            .toList();
      } finally {
        _model.isDataUploading = false;
      }
      if (selectedUploadedFiles.length == selectedMedia.length) {
        setState(() {
          _model.uploadedLocalFileIdCard = selectedUploadedFiles.first;
        });
        showUploadMessage(context, 'Uploading ID card...');
        try {
          final fileName = selectedUploadedFiles.first.name ?? '';
          final fileExtension = fileName.isNotEmpty 
              ? fileName.split('.').last.toLowerCase()
              : 'jpg';
          final downloadUrl = await uploadData(
            'users/${currentUserUid}/id_card.$fileExtension',
            selectedUploadedFiles.first.bytes!,
          );
          _model.uploadedFileUrlIdCard = downloadUrl;
          await currentUserReference!.update({
            'id_card_url': downloadUrl,
          });
          showUploadMessage(context, 'ID card uploaded successfully!');
        } catch (e) {
          showUploadMessage(context, 'Failed to upload ID card: $e');
        }
      } else {
        setState(() {});
        showUploadMessage(context, 'Failed to upload ID card');
      }
    }
  }

  Future<void> _uploadCredentials() async {
    // Credentials - allow images and PDFs
    final selectedMedia = await selectMediaWithSourceBottomSheet(
      context: context,
      allowPhoto: true,
      allowVideo: false,
      maxWidth: 1200.00,
      maxHeight: 1200.00,
      imageQuality: 85,
    );
    if (selectedMedia != null &&
        selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
      setState(() => _model.isDataUploading = true);
      var selectedUploadedFiles = <FFUploadedFile>[];

      try {
        selectedUploadedFiles = selectedMedia
            .map((m) => FFUploadedFile(
                  name: m.storagePath.split('/').last,
                  bytes: m.bytes,
                  height: m.dimensions?.height,
                  width: m.dimensions?.width,
                  blurHash: m.blurHash,
                ))
            .toList();
      } finally {
        _model.isDataUploading = false;
      }
      if (selectedUploadedFiles.length == selectedMedia.length) {
        setState(() {
          _model.uploadedLocalFileCredentials = selectedUploadedFiles.first;
        });
        showUploadMessage(context, 'Uploading credentials...');
        try {
          final fileName = selectedUploadedFiles.first.name ?? '';
          final fileExtension = fileName.isNotEmpty 
              ? fileName.split('.').last.toLowerCase()
              : 'jpg';
          final downloadUrl = await uploadData(
            'users/${currentUserUid}/credentials.$fileExtension',
            selectedUploadedFiles.first.bytes!,
          );
          _model.uploadedFileUrlCredentials = downloadUrl;
          await currentUserReference!.update({
            'credentials_url': downloadUrl,
          });
          showUploadMessage(context, 'Credentials uploaded successfully!');
        } catch (e) {
          showUploadMessage(context, 'Failed to upload credentials: $e');
        }
      } else {
        setState(() {});
        showUploadMessage(context, 'Failed to upload credentials');
      }
    }
  }
}
