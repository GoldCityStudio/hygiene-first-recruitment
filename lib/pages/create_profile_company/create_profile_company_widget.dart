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
import 'create_profile_company_model.dart';
export 'create_profile_company_model.dart';

class CreateProfileCompanyWidget extends StatefulWidget {
  const CreateProfileCompanyWidget({
    super.key,
    this.existingProfile,
  });

  final UsersRecord? existingProfile;
  static String routeName = 'createProfileCompany';
  static String routePath = 'createProfileCompany';

  @override
  State<CreateProfileCompanyWidget> createState() => _CreateProfileCompanyWidgetState();
}

class _CreateProfileCompanyWidgetState extends State<CreateProfileCompanyWidget> {
  late CreateProfileCompanyModel _model;
  bool isSmallScreen = false;
  bool isLoading = true;
  bool isEditing = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateProfileCompanyModel());

    // Check if we're editing an existing profile
    isEditing = currentUserDocument?.type == 'company' && 
                currentUserDocument?.displayName != null;

    // Initialize text controllers with existing data if available
    _model.companyNameTextController ??= TextEditingController(
      text: widget.existingProfile?.displayName ?? ''
    );
    _model.descriptionTextController ??= TextEditingController(
      text: widget.existingProfile?.description ?? ''
    );
    _model.websiteTextController ??= TextEditingController(
      text: widget.existingProfile?.website?.replaceFirst('https://', '') ?? ''
    );

    // Initialize focus nodes
    _model.companyNameFocusNode ??= FocusNode();
    _model.descriptionFocusNode ??= FocusNode();
    _model.websiteFocusNode ??= FocusNode();

    // Set initial values from existing profile
    if (widget.existingProfile != null) {
      _model.locationDropDownValue = widget.existingProfile?.location;
      _model.uploadedFileUrl1 = widget.existingProfile?.photoCoverUrl ?? '';
      _model.uploadedFileUrl2 = widget.existingProfile?.photoUrl ?? '';
    }

    _model.companyNameFocusNode!.addListener(
      () async {
        logFirebaseEvent('CREATE_PROFILE_COMPANY_companyName_ON_FO');
        logFirebaseEvent('companyName_custom_action');
        _model.trimOutput = await actions.trimTextAction(
          _model.companyNameTextController.text,
        );
        logFirebaseEvent('companyName_set_form_field');
        setState(() {
          _model.companyNameTextController?.text = _model.trimOutput!;
        });
      },
    );

    setState(() {
      isLoading = false;
    });

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'createProfileCompany'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> saveProfile() async {
    if (_model.formKey.currentState == null ||
        !_model.formKey.currentState!.validate()) {
      print('Form validation failed');
      return;
    }

    try {
      // Debug prints for company name
      print('Company Name Controller Text: ${_model.companyNameTextController?.text}');
      print('Company Name Controller: ${_model.companyNameTextController}');
      
      // Validate required files for new profiles
      if (!isEditing) {
        if ((_model.uploadedLocalFile1.bytes ?? []).isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('請選擇公司封面照片'),
              backgroundColor: FlutterFlowTheme.of(context).error,
            ),
          );
          return;
        }
        if ((_model.uploadedLocalFile2.bytes ?? []).isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('請選擇公司標誌'),
              backgroundColor: FlutterFlowTheme.of(context).error,
            ),
          );
          return;
        }
      }

      if (_model.locationDropDownValue == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('請選擇公司地點'),
            backgroundColor: FlutterFlowTheme.of(context).error,
          ),
        );
        return;
      }

      // Create the user data
      final userData = createUsersRecordData(
        type: 'Company',
        photoUrl: _model.uploadedFileUrl2,
        photoCoverUrl: _model.uploadedFileUrl1,
        displayName: _model.companyNameTextController.text,
        description: _model.descriptionTextController.text,
        website: _model.websiteTextController.text != ''
            ? 'https://${_model.websiteTextController.text}'
            : null,
        location: _model.locationDropDownValue,
        profilePhotoBlurhash: _model.uploadedLocalFile2.blurHash,
        coverPhotoBlurhash: _model.uploadedLocalFile1.blurHash,
        phoneNumber: null,
        emailNotifications: true,
        notificationFrequency: 'Daily Summary Updates',
        pushNotifications: true,
      );

      // Debug print for user data
      print('User data to save: $userData');
      print('Display Name in userData: ${userData['displayName']}');

      // Update user document
      await currentUserReference!.update(userData);

      // Verify the update
      final updatedUser = await UsersRecord.getDocumentOnce(currentUserReference!);
      print('Updated user display name: ${updatedUser.displayName}');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isEditing ? '公司資料已更新' : '公司資料已建立'),
          backgroundColor: FlutterFlowTheme.of(context).success,
        ),
      );

      context.goNamed('company_dashboard');
    } catch (e, stackTrace) {
      print('Error saving profile: $e');
      print('Stack trace: $stackTrace');
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('保存失敗：$e'),
          backgroundColor: FlutterFlowTheme.of(context).error,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF5F7FA),
        appBar: AppBar(
          backgroundColor: Color(0xFF2B4C7E),
          iconTheme: IconThemeData(color: Colors.white),
          automaticallyImplyLeading: false,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              logFirebaseEvent('CREATE_PROFILE_COMPANY_Icon_7pq7oeva_ON_');
              logFirebaseEvent('Icon_navigate_back');
              context.safePop();
            },
            child: Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          title: Text(
            '公司簡介',
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).titleMedium.override(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(),
            child: Form(
              key: _model.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200.0,
                          decoration: BoxDecoration(
                            color: Color(0xFF2B4C7E).withOpacity(0.1),
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: Image.asset(
                                'assets/images/Img_placeholder.webp',
                              ).image,
                            ),
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'CREATE_PROFILE_COMPANY_coverImage_ON_TAP');
                              logFirebaseEvent(
                                  'coverImage_upload_media_to_firebase');
                              final selectedMedia =
                                  await selectMediaWithSourceBottomSheet(
                                context: context,
                                maxHeight: 800.00,
                                imageQuality: 50,
                                allowPhoto: true,
                                includeBlurHash: true,
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                textColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                pickerFontFamily: 'Lexend Deca',
                              );
                              if (selectedMedia != null &&
                                  selectedMedia.every((m) => validateFileFormat(
                                      m.storagePath, context))) {
                                safeSetState(
                                    () => _model.isDataUploading1 = true);
                                var selectedUploadedFiles = <FFUploadedFile>[];

                                var downloadUrls = <String>[];
                                try {
                                  showUploadMessage(
                                    context,
                                    'Uploading file...',
                                    showLoading: true,
                                  );
                                  selectedUploadedFiles = selectedMedia
                                      .map((m) => FFUploadedFile(
                                            name: m.storagePath.split('/').last,
                                            bytes: m.bytes,
                                            height: m.dimensions?.height,
                                            width: m.dimensions?.width,
                                            blurHash: m.blurHash,
                                          ))
                                      .toList();

                                  downloadUrls = (await Future.wait(
                                    selectedMedia.map(
                                      (m) async => await uploadData(
                                          m.storagePath, m.bytes),
                                    ),
                                  ))
                                      .where((u) => u != null)
                                      .map((u) => u!)
                                      .toList();
                                } finally {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  _model.isDataUploading1 = false;
                                }
                                if (selectedUploadedFiles.length ==
                                        selectedMedia.length &&
                                    downloadUrls.length ==
                                        selectedMedia.length) {
                                  safeSetState(() {
                                    _model.uploadedLocalFile1 =
                                        selectedUploadedFiles.first;
                                    _model.uploadedFileUrl1 =
                                        downloadUrls.first;
                                  });
                                  showUploadMessage(context, 'Success!');
                                } else {
                                  safeSetState(() {});
                                  showUploadMessage(
                                      context, 'Failed to upload data');
                                  return;
                                }
                              }
                            },
                            child: Image.network(
                              _model.uploadedFileUrl1,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 5.0, 0.0, 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.asset(
                                        'assets/images/35850819.jpg',
                                      ).image,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: Color(0xFF2B4C7E),
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'CREATE_PROFILE_COMPANY_companyLogo_ON_TA');
                                          logFirebaseEvent(
                                              'companyLogo_upload_media_to_firebase');
                                          final selectedMedia =
                                              await selectMediaWithSourceBottomSheet(
                                            context: context,
                                            maxHeight: 800.00,
                                            imageQuality: 50,
                                            allowPhoto: true,
                                            includeBlurHash: true,
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            textColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            pickerFontFamily: 'Lexend Deca',
                                          );
                                          if (selectedMedia != null &&
                                              selectedMedia.every((m) =>
                                                  validateFileFormat(
                                                      m.storagePath,
                                                      context))) {
                                            safeSetState(() =>
                                                _model.isDataUploading2 = true);
                                            var selectedUploadedFiles =
                                                <FFUploadedFile>[];

                                            var downloadUrls = <String>[];
                                            try {
                                              showUploadMessage(
                                                context,
                                                'Uploading file...',
                                                showLoading: true,
                                              );
                                              selectedUploadedFiles =
                                                  selectedMedia
                                                      .map(
                                                          (m) => FFUploadedFile(
                                                                name: m
                                                                    .storagePath
                                                                    .split('/')
                                                                    .last,
                                                                bytes: m.bytes,
                                                                height: m
                                                                    .dimensions
                                                                    ?.height,
                                                                width: m
                                                                    .dimensions
                                                                    ?.width,
                                                                blurHash:
                                                                    m.blurHash,
                                                              ))
                                                      .toList();

                                              downloadUrls = (await Future.wait(
                                                selectedMedia.map(
                                                  (m) async => await uploadData(
                                                      m.storagePath, m.bytes),
                                                ),
                                              ))
                                                  .where((u) => u != null)
                                                  .map((u) => u!)
                                                  .toList();
                                            } finally {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                              _model.isDataUploading2 = false;
                                            }
                                            if (selectedUploadedFiles.length ==
                                                    selectedMedia.length &&
                                                downloadUrls.length ==
                                                    selectedMedia.length) {
                                              safeSetState(() {
                                                _model.uploadedLocalFile2 =
                                                    selectedUploadedFiles.first;
                                                _model.uploadedFileUrl2 =
                                                    downloadUrls.first;
                                              });
                                              showUploadMessage(
                                                  context, 'Success!');
                                            } else {
                                              safeSetState(() {});
                                              showUploadMessage(context,
                                                  'Failed to upload data');
                                              return;
                                            }
                                          }
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            _model.uploadedFileUrl2,
                                            width: 100.0,
                                            height: 100.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.19, 1.23),
                                        child: Icon(
                                          Icons.add_circle,
                                          color: FlutterFlowTheme.of(context)
                                              .lineColor,
                                          size: 24.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 0.0, 0.0),
                                    child: TextFormField(
                                      controller:
                                          _model.companyNameTextController,
                                      focusNode: _model.companyNameFocusNode,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      textInputAction: TextInputAction.next,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: '公司名稱',
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF2B4C7E).withOpacity(0.2),
                                            width: 2.0,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF2B4C7E),
                                            width: 2.0,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFE60000),
                                            width: 2.0,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFE60000),
                                            width: 2.0,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      cursorColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      validator: _model
                                          .companyNameTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1.0,
                            color: Color(0xFF2B4C7E).withOpacity(0.1),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _model.descriptionTextController,
                                  focusNode: _model.descriptionFocusNode,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  textInputAction: TextInputAction.done,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: '描述',
                                    hintText: '提供貴公司的描述、其價值觀和使命。',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0.0,
                                        ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF2B4C7E).withOpacity(0.2),
                                        width: 2.0,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF2B4C7E),
                                        width: 2.0,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFE60000),
                                        width: 2.0,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFE60000),
                                        width: 2.0,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                  maxLines: 7,
                                  minLines: 3,
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: _model
                                      .descriptionTextControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.0,
                            color: Color(0xFF2B4C7E).withOpacity(0.1),
                          ),
                          FlutterFlowDropDown<String>(
                            controller:
                                _model.locationDropDownValueController ??=
                                    FormFieldController<String>(null),
                            options: [
                              '全港島',
                              '中西區 ',
                              '東區 ',
                              '南區 ',
                              '灣仔',
                              '全九龍',
                              '九龍城',
                              '觀塘',
                              '深水埗',
                              '黃大仙',
                              '油尖旺',
                              '全新界',
                              '離島',
                              '葵青',
                              '北區',
                              '西貢',
                              '沙田',
                              '大埔',
                              '荃灣',
                              '屯門',
                              '元朗'
                            ],
                            onChanged: (val) => safeSetState(
                                () => _model.locationDropDownValue = val),
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 40.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Montserrat',
                                  letterSpacing: 0.0,
                                ),
                            hintText: '地點...',
                            icon: FaIcon(
                              FontAwesomeIcons.chevronDown,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 18.0,
                            ),
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            elevation: 8.0,
                            borderColor: FlutterFlowTheme.of(context).primary,
                            borderWidth: 2.0,
                            borderRadius: 4.0,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                8.0, 4.0, 8.0, 4.0),
                            hidesUnderline: true,
                            isSearchable: false,
                            isMultiSelect: false,
                          ),
                          Divider(
                            thickness: 1.0,
                            color: Color(0xFF2B4C7E).withOpacity(0.1),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _model.websiteTextController,
                                  focusNode: _model.websiteFocusNode,
                                  textInputAction: TextInputAction.done,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: '網站（可選）',
                                    hintText: 'www.mycompany.com',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0.0,
                                        ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF2B4C7E).withOpacity(0.2),
                                        width: 2.0,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF2B4C7E),
                                        width: 2.0,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFE60000),
                                        width: 2.0,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFE60000),
                                        width: 2.0,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: _model
                                      .websiteTextControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.0,
                            color: Color(0xFF2B4C7E).withOpacity(0.1),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 12.0, 0.0, 32.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FFButtonWidget(
                                  onPressed: saveProfile,
                                  text: isEditing ? '更新公司資料' : '建立公司資料',
                                  options: FFButtonOptions(
                                    width: 200.0,
                                    height: 50.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Color(0xFF2B4C7E),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
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
            ),
          ),
        ),
      ),
    );
  }
}
