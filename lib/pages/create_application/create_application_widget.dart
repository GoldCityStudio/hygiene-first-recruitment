import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/edit_phone_number/edit_phone_number_widget.dart';
import '/components/file_picker/file_picker_widget.dart';
import '/components/modal_applied/modal_applied_widget.dart';
import '/flutter_flow/flutter_flow_pdf_viewer.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:octo_image/octo_image.dart';
import 'create_application_model.dart';
export 'create_application_model.dart';

class CreateApplicationWidget extends StatefulWidget {
  const CreateApplicationWidget({
    super.key,
    required this.jobPostDetails,
    required this.position,
    required this.compName,
    required this.compRefDoc,
    bool? requiresCoverLetter,
  }) : this.requiresCoverLetter = requiresCoverLetter ?? true;

  final DocumentReference? jobPostDetails;
  final String? position;
  final String? compName;
  final DocumentReference? compRefDoc;
  final bool requiresCoverLetter;

  static String routeName = 'createApplication';
  static String routePath = 'createApplication';

  @override
  State<CreateApplicationWidget> createState() =>
      _CreateApplicationWidgetState();
}

class _CreateApplicationWidgetState extends State<CreateApplicationWidget> {
  late CreateApplicationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateApplicationModel());

    print('CreateApplicationWidget initialized with:');
    print('Job Post Details: ${widget.jobPostDetails?.path}');
    print('Position: ${widget.position}');
    print('Company Name: ${widget.compName}');
    print('Company Ref: ${widget.compRefDoc?.path}');
    print('Requires Cover Letter: ${widget.requiresCoverLetter}');
    
    if (widget.jobPostDetails == null) {
      print('Error: Job post details is null');
      return;
    }
    if (widget.position == null) {
      print('Error: Position is null');
      return;
    }
    if (widget.compName == null) {
      print('Error: Company name is null');
      return;
    }
    if (widget.compRefDoc == null) {
      print('Error: Company reference is null');
      return;
    }
    
    _model.initState(context);

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'createApplication'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CREATE_APPLICATION_createApplication_ON_');
      logFirebaseEvent('createApplication_firestore_query');
      _model.applicationQuery = await queryApplicationsRecordOnce(
        queryBuilder: (applicationsRecord) => applicationsRecord
            .where(
              'applicant_ref',
              isEqualTo: currentUserReference,
            )
            .where(
              'job_ref',
              isEqualTo: widget.jobPostDetails,
            ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      if (_model.applicationQuery?.applicantRef == currentUserReference) {
        logFirebaseEvent('createApplication_bottom_sheet');
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          barrierColor: Color(0x6795A1AC),
          isDismissible: false,
          enableDrag: false,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: ModalAppliedWidget(),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));
      }
    });

    _model.coverLetterTextFieldTextController ??= TextEditingController();
    _model.coverLetterTextFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            SliverAppBar(
              pinned: false,
              floating: true,
              snap: false,
              backgroundColor: FlutterFlowTheme.of(context).primary,
              iconTheme: IconThemeData(color: Colors.black),
              automaticallyImplyLeading: false,
              leading: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('CREATE_APPLICATION_Icon_lsg9e3vm_ON_TAP');
                  logFirebaseEvent('Icon_navigate_back');
                  context.safePop();
                },
                child: Icon(
                  Icons.chevron_left_rounded,
                  color: Color(0xFFF8FCFF),
                  size: 30.0,
                ),
              ),
              title: Text(
                '申請職位',
                textAlign: TextAlign.start,
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      letterSpacing: 0.0,
                    ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 2.0,
            )
          ],
          body: Builder(
            builder: (context) {
              return Form(
                key: _model.formKey,
                autovalidateMode: AutovalidateMode.always,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 8.0, 16.0, 4.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-0.8, 1.0),
                              child: FutureBuilder<UsersRecord>(
                                future: UsersRecord.getDocumentOnce(
                                    widget.compRefDoc!),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 28.0,
                                        height: 28.0,
                                        child: SpinKitFoldingCube(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 28.0,
                                        ),
                                      ),
                                    );
                                  }

                                  final companyLogoUsersRecord = snapshot.data!;

                                  return Material(
                                    color: Colors.transparent,
                                    elevation: 3.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Container(
                                      width: 60.0,
                                      height: 60.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: Image.asset(
                                            'assets/images/logoverticawhite.png',
                                          ).image,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(-0.84, 0.88),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: OctoImage(
                                            placeholderBuilder: (_) =>
                                                SizedBox.expand(
                                              child: Image(
                                                image: BlurHashImage(
                                                    companyLogoUsersRecord
                                                        .profilePhotoBlurhash),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            image: CachedNetworkImageProvider(
                                              companyLogoUsersRecord.photoUrl,
                                            ),
                                            width: 60.0,
                                            height: 60.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.position!,
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    Text(
                                      widget.compName!,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 8.0,
                        thickness: 2.0,
                        indent: 16.0,
                        endIndent: 16.0,
                        color: FlutterFlowTheme.of(context).lineColor,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 4.0, 16.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 8.0),
                                child: AutoSizeText(
                                  '候選人應根據要求提交詳細的簡歷和相關證明文件。',
                                  textAlign: TextAlign.start,
                                  maxLines: 3,
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (widget.requiresCoverLetter ==
                          valueOrDefault<bool>(
                            false,
                            true,
                          ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 2.0, 0.0),
                                    child: Icon(
                                      Icons.offline_bolt_outlined,
                                      color:
                                          FlutterFlowTheme.of(context).warning,
                                      size: 22.0,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      'QuickApply - 讓您在幾秒鐘內提交申請，無需求職信。您的履歷/履歷會說話，可以充分利用您的時間並增加您獲得夢想工作的機會。',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      if (widget.requiresCoverLetter ==
                          valueOrDefault<bool>(
                            true,
                            true,
                          ))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 16.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '撰寫求職信',
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  FFButtonWidget(
                                    onPressed: () {
                                      print('Button pressed ...');
                                    },
                                    text: '獲取協助',
                                    icon: Icon(
                                      Icons.generating_tokens,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                      size: 18.0,
                                    ),
                                    options: FFButtonOptions(
                                      height: 30.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 0.0, 8.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 16.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 8.0, 0.0, 0.0),
                                      child: TextFormField(
                                        controller: _model
                                            .coverLetterTextFieldTextController,
                                        focusNode: _model
                                            .coverLetterTextFieldFocusNode,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: '從這裡開始輸入....',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          contentPadding: EdgeInsets.all(8.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              letterSpacing: 0.0,
                                            ),
                                        textAlign: TextAlign.start,
                                        maxLines: 10,
                                        keyboardType: TextInputType.multiline,
                                        cursorColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        validator: _model
                                            .coverLetterTextFieldTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 12.0, 16.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              '新增附件',
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      if (_model.selectedFileLink != null &&
                          _model.selectedFileLink != '')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 0.0, 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (_model.selectedFileLink != null &&
                                  _model.selectedFileLink != '')
                                Flexible(
                                  child: SelectionArea(
                                      child: Text(
                                    '滑動即可捲動瀏覽頁面',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                        ),
                                  )),
                                ),
                            ],
                          ),
                        ),

                      // Conditional value is put tto prevent blandisplay before SelectedLink is filled
                      if (_model.selectedFileLink != null &&
                          _model.selectedFileLink != '')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 8.0),
                          child: FlutterFlowPdfViewer(
                            networkPath: _model.selectedFileLink != null &&
                                    _model.selectedFileLink != ''
                                ? _model.selectedFileLink!
                                : ' ',
                            height: 350.0,
                            horizontalScroll: true,
                          ),
                        ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 8.0, 16.0, 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'CREATE_APPLICATION_BUTTON_BTN_ON_TAP');
                                logFirebaseEvent('Button_bottom_sheet');
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  useSafeArea: true,
                                  context: context,
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      child: Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: FilePickerWidget(),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(
                                    () => _model.selectedFileLink = value));

                                safeSetState(() {});
                              },
                              text: _model.selectedFileLink != null &&
                                      _model.selectedFileLink != ''
                                  ? '檔案已成功上傳'
                                  : '上傳履歷/履歷（僅限PDF）',
                              icon: FaIcon(
                                FontAwesomeIcons.filePdf,
                                color: Colors.white,
                                size: 15.0,
                              ),
                              options: FFButtonOptions(
                                width: 300.0,
                                height: 50.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 3.0,
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            32.0, 8.0, 32.0, 16.0),
                        child: Text(
                          '請謹慎對待在申請過程中要求提供付款或個人財務資訊的任何招聘資訊或雇主。如果您遇到此類情況，請立即向我們的支援團隊報告。',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodySmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).warning,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 48.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              logFirebaseEvent(
                                  'CREATE_APPLICATION_PAGE__BTN_ON_TAP');
                              var _shouldSetState = false;
                              final firestoreBatch =
                                  FirebaseFirestore.instance.batch();
                              try {
                                  if (_model.formKey.currentState == null ||
                                    !_model.formKey.currentState!.validate()) {
                                    return;
                                  }

                                if (_model.selectedFileLink == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('請上傳您的履歷/履歷'),
                                      backgroundColor: FlutterFlowTheme.of(context).error,
                                    ),
                                  );
                                  return;
                                }

                                if (_model.applicationQuery?.applicantRef == currentUserReference) {
                                    logFirebaseEvent('Button_bottom_sheet');
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      barrierColor: Color(0x6795A1AC),
                                      isDismissible: false,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: ModalAppliedWidget(),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));

                                    if (_shouldSetState) safeSetState(() {});
                                    return;
                                  } else {
                                    logFirebaseEvent('Button_backend_call');

                                  if (currentUserReference == null) {
                                    print('ERROR: Current user reference is null');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('用戶未認證。請登入後重試。'),
                                        backgroundColor: FlutterFlowTheme.of(context).error,
                                      ),
                                    );
                                    return;
                                  }

                                    var applicationsRecordReference =
                                        ApplicationsRecord.collection.doc();
                                  try {
                                    // Validate required fields
                                    if (widget.jobPostDetails == null) {
                                      throw Exception('Job post details is missing');
                                    }
                                    if (widget.compRefDoc == null) {
                                      throw Exception('Company reference is missing');
                                    }
                                    if (currentUserReference == null) {
                                      throw Exception('User is not authenticated');
                                    }
                                    if (_model.selectedFileLink == null || _model.selectedFileLink!.isEmpty) {
                                      throw Exception('CV/Resume is required');
                                    }

                                    // Create the initial application data
                                    final applicationData = createApplicationsRecordData(
                                      coverLetter: _model.coverLetterTextFieldTextController.text,
                                        jobRef: widget.jobPostDetails,
                                        companyRef: widget.compRefDoc,
                                        attachmentUrl: _model.selectedFileLink,
                                        applicantRef: currentUserReference,
                                      status: 'Pending',
                                      position: widget.position,
                                      companyName: widget.compName,
                                    );

                                    print('Creating application with data: ${applicationData.toString()}');

                                    // Set the initial application document with server timestamp
                                    firestoreBatch.set(applicationsRecordReference, {
                                      ...applicationData,
                                      'time_created': FieldValue.serverTimestamp(),
                                    });

                                    // Create the application record
                                    _model.submitApplication = ApplicationsRecord.getDocumentFromData(
                                      applicationData,
                                      applicationsRecordReference,
                                    );

                                    if (_model.submitApplication == null) {
                                      throw Exception('Failed to create application document');
                                    }

                                    // Update the application with its reference
                                    firestoreBatch.update(
                                      applicationsRecordReference,
                                        createApplicationsRecordData(
                                        applicationUid: applicationsRecordReference,
                                      ),
                                    );

                                    // Create notification record
                                    if (widget.compRefDoc != null && widget.jobPostDetails != null) {
                                    firestoreBatch.set(
                                        NotificationsRecord.collection.doc(),
                                        {
                                      ...createNotificationsRecordData(
                                        notificationType: '申請通知',
                                            applicationRef: applicationsRecordReference,
                                        taggedCompanyRef: widget.compRefDoc,
                                        relatedJob: widget.jobPostDetails,
                                        notificationTitle: '新申請',
                                        content: '${currentUserDisplayName} 已提交 ${widget.position} 職位的新申請。',
                                        isRead: false,
                                        taggedUserRef: widget.compRefDoc,
                                            timeToLive: dateTimeFromSecondsSinceEpoch(functions.maximumDate()),
                                      ),
                                          'timestamp': FieldValue.serverTimestamp(),
                                        },
                                      );
                                    }

                                    print('Committing batch operation...');
                                    // Commit all changes
                                      await firestoreBatch.commit();
                                    print('Batch operation committed successfully');

                                    // Send notification after successful commit
                                    if (widget.compRefDoc != null) {
                                      triggerPushNotification(
                                        notificationTitle: '收到新申請',
                                        notificationText: '您收到一份${widget.position}職位的新申請。',
                                        userRefs: [widget.compRefDoc!],
                                        initialPageName: 'applicantsList',
                                        parameterData: {
                                          'jobPostDetails': widget.jobPostDetails,
                                        },
                                      );
                                    }

                                      // Navigate to view application page
                                    if (mounted && context != null) {
                                      context.pushNamed(
                                        ViewApplicationWidget.routeName,
                                        queryParameters: {
                                          'candidateDetails': serializeParam(
                                            currentUserReference,
                                            ParamType.DocumentReference,
                                          ),
                                          'applicationRef': serializeParam(
                                            applicationsRecordReference,
                                            ParamType.DocumentReference,
                                          ),
                                          'jobRef': serializeParam(
                                            widget.jobPostDetails!,
                                            ParamType.DocumentReference,
                                          ),
                                        }.withoutNulls,
                                      );

                                      // Show success message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '您已成功提交申請。祝您好運！',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Montserrat',
                                                color: Colors.white,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        duration: Duration(milliseconds: 6949),
                                          backgroundColor: FlutterFlowTheme.of(context).success,
                                      ),
                                    );
                                    }
                                  } catch (e, stackTrace) {
                                    print('ERROR: Failed to create application:');
                                    print('Error: $e');
                                    print('Stack trace: $stackTrace');
                                    if (mounted && context != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                          content: Text('提交申請失敗：${e.toString()}'),
                                          backgroundColor: FlutterFlowTheme.of(context).error,
                                          duration: Duration(seconds: 5),
                                        ),
                                      );
                                    }
                                  }

                                  logFirebaseEvent('Button_custom_action');
                                  await actions.requestReview();
                                }
                              } finally {
                                // Remove the extra batch commit
                              }

                              if (_shouldSetState) safeSetState(() {});
                            },
                            text: '提交申請',
                            icon: Icon(
                              Icons.task,
                              color:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                              size: 22.0,
                            ),
                            options: FFButtonOptions(
                              width: 250.0,
                              height: 50.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFFEFF7F5),
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                              ),
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
