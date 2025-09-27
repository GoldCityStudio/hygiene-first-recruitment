import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:octo_image/octo_image.dart';
import 'shortlist_model.dart';
export 'shortlist_model.dart';

class ShortlistWidget extends StatefulWidget {
  const ShortlistWidget({super.key});

  static String routeName = 'shortlist';
  static String routePath = 'shortlist';

  @override
  State<ShortlistWidget> createState() => _ShortlistWidgetState();
}

class _ShortlistWidgetState extends State<ShortlistWidget> {
  late ShortlistModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShortlistModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'shortlist'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UsersRecord>(
      future: UsersRecord.getDocumentOnce(currentUserReference!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 28.0,
                height: 28.0,
                child: SpinKitFoldingCube(
                  color: FlutterFlowTheme.of(context).primary,
                  size: 28.0,
                ),
              ),
            ),
          );
        }

        final shortlistUsersRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              iconTheme: IconThemeData(color: Colors.black),
              automaticallyImplyLeading: false,
              leading: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('SHORTLIST_PAGE_Icon_sabewmq0_ON_TAP');
                  logFirebaseEvent('Icon_navigate_back');
                  context.safePop();
                },
                child: Icon(
                  Icons.chevron_left_rounded,
                  color: Color(0xFFF8FCFF),
                  size: 30.0,
                ),
              ),
              title: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        '入圍名單',
                        textAlign: TextAlign.start,
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [],
              centerTitle: false,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 4.0),
                      child: Text(
                        '選擇職位清單以查看入圍候選人',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                    Expanded(
                      child: AuthUserStreamWidget(
                        builder: (context) =>
                            FutureBuilder<List<ApplicationsRecord>>(
                          future: (_model.firestoreRequestCompleter ??=
                                  Completer<List<ApplicationsRecord>>()
                                    ..complete(queryApplicationsRecordOnce(
                                      queryBuilder: (applicationsRecord) =>
                                          applicationsRecord
                                              .where(
                                                'company_ref',
                                                isEqualTo: currentUserReference,
                                              )
                                              .whereIn(
                                                  'application_uid',
                                                  (currentUserDocument
                                                          ?.shortlistedCandidates
                                                          .toList() ??
                                                      []))
                                              .orderBy('time_created',
                                                  descending: true),
                                    )))
                              .future,
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 200.0),
                                  child: SizedBox(
                                    width: 28.0,
                                    height: 28.0,
                                    child: SpinKitFoldingCube(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 28.0,
                                    ),
                                  ),
                                ),
                              );
                            }
                            List<ApplicationsRecord>
                                containerApplicationsRecordList =
                                snapshot.data!;

                            return Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(),
                              child: Builder(
                                builder: (context) {
                                  final uniqueValueFunction = functions
                                          .uniqueValueShortlist(
                                              containerApplicationsRecordList
                                                  .map((e) => e.jobRef)
                                                  .withoutNulls
                                                  .toList())
                                          ?.toList() ??
                                      [];
                                  if (uniqueValueFunction.isEmpty) {
                                    return Center(
                                      child: EmptyListWidget(),
                                    );
                                  }

                                  return RefreshIndicator(
                                    color: FlutterFlowTheme.of(context).success,
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).background,
                                    onRefresh: () async {
                                      logFirebaseEvent(
                                          'SHORTLIST_ListView_733b06bq_ON_PULL_TO_R');
                                      logFirebaseEvent(
                                          'ListView_refresh_database_request');
                                      safeSetState(() => _model
                                          .firestoreRequestCompleter = null);
                                      await _model
                                          .waitForFirestoreRequestCompleted();
                                    },
                                    child: ListView.builder(
                                      padding: EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        48.0,
                                      ),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: uniqueValueFunction.length,
                                      itemBuilder:
                                          (context, uniqueValueFunctionIndex) {
                                        final uniqueValueFunctionItem =
                                            uniqueValueFunction[
                                                uniqueValueFunctionIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 6.0, 0.0, 6.0),
                                          child: FutureBuilder<JobsRecord>(
                                            future: JobsRecord.getDocumentOnce(
                                                uniqueValueFunctionItem),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Image.asset(
                                                  '',
                                                );
                                              }

                                              final containerJobsRecord =
                                                  snapshot.data!;

                                              return Material(
                                                color: Colors.transparent,
                                                elevation: 8.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: Container(
                                                  width: 100.0,
                                                  height: 75.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4.0,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        offset: Offset(
                                                          0.0,
                                                          2.0,
                                                        ),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 2.0,
                                                                0.0, 0.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        logFirebaseEvent(
                                                            'SHORTLIST_PAGE_Row_ywry223f_ON_TAP');
                                                        logFirebaseEvent(
                                                            'Row_navigate_to');

                                                        context.pushNamed(
                                                          ShortlistMembersWidget
                                                              .routeName,
                                                          queryParameters: {
                                                            'jobRef':
                                                                serializeParam(
                                                              containerJobsRecord
                                                                  .reference,
                                                              ParamType
                                                                  .DocumentReference,
                                                            ),
                                                            'position':
                                                                serializeParam(
                                                              containerJobsRecord
                                                                  .position,
                                                              ParamType.String,
                                                            ),
                                                          }.withoutNulls,
                                                        );
                                                      },
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        8.0,
                                                                        0.0,
                                                                        8.0,
                                                                        4.0),
                                                            child: Container(
                                                              width: 50.0,
                                                              height: 50.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  image: Image
                                                                      .asset(
                                                                    'assets/images/logoverticawhite.png',
                                                                  ).image,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                border:
                                                                    Border.all(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  width: 2.0,
                                                                ),
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                child:
                                                                    OctoImage(
                                                                  placeholderBuilder:
                                                                      (_) => SizedBox
                                                                          .expand(
                                                                    child:
                                                                        Image(
                                                                      image: BlurHashImage(valueOrDefault(
                                                                          currentUserDocument
                                                                              ?.profilePhotoBlurhash,
                                                                          '')),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  image:
                                                                      CachedNetworkImageProvider(
                                                                    currentUserPhoto,
                                                                  ),
                                                                  width: double
                                                                      .infinity,
                                                                  height: double
                                                                      .infinity,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                AutoSizeText(
                                                                  containerJobsRecord
                                                                      .position,
                                                                  maxLines: 2,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          4.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Text(
                                                                        '發布日期：',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              fontFamily: 'Montserrat',
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                      Text(
                                                                        dateTimeFormat(
                                                                            "MMMMEEEEd",
                                                                            containerJobsRecord.createdAt!),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              fontFamily: 'Montserrat',
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            8.0,
                                                                            0.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .chevron_right_rounded,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  size: 24.0,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
