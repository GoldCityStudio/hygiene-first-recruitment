import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_favs/empty_favs_widget.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/options/options_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:octo_image/octo_image.dart';
import 'saved_jobs_model.dart';
export 'saved_jobs_model.dart';

class SavedJobsWidget extends StatefulWidget {
  const SavedJobsWidget({
    super.key,
    int? page,
  }) : this.page = page ?? 0;

  final int page;

  static String routeName = 'savedJobs';
  static String routePath = 'savedJobs';

  @override
  State<SavedJobsWidget> createState() => _SavedJobsWidgetState();
}

class _SavedJobsWidgetState extends State<SavedJobsWidget>
    with TickerProviderStateMixin {
  late SavedJobsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SavedJobsModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'savedJobs'});
    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: min(
          valueOrDefault<int>(
            widget.page,
            0,
          ),
          1),
    )..addListener(() => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
            logFirebaseEvent('SAVED_JOBS_PAGE_Icon_nsasn9y5_ON_TAP');
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
                  '我的工作',
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).titleMedium.override(
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              children: [
                Align(
                  alignment: Alignment(0.0, 0),
                  child: TabBar(
                    labelColor: FlutterFlowTheme.of(context).primaryText,
                    unselectedLabelColor:
                        FlutterFlowTheme.of(context).secondaryText,
                    labelStyle:
                        FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0.0,
                            ),
                    unselectedLabelStyle: TextStyle(),
                    indicatorColor: FlutterFlowTheme.of(context).primaryText,
                    tabs: [
                      Tab(
                        text: '已儲存',
                      ),
                      Tab(
                        text: '已申請',
                      ),
                    ],
                    controller: _model.tabBarController,
                    onTap: (i) async {
                      [() async {}, () async {}][i]();
                    },
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _model.tabBarController,
                    children: [
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: FutureBuilder<List<UsersRecord>>(
                          future: queryUsersRecordOnce(
                            queryBuilder: (usersRecord) => usersRecord.where(
                              'uid',
                              isEqualTo: currentUserUid,
                            ),
                            singleRecord: true,
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
                            List<UsersRecord> listViewUsersRecordList =
                                snapshot.data!;
                            if (listViewUsersRecordList.isEmpty) {
                              return Center(
                                child: EmptyFavsWidget(
                                  type: 'jobs',
                                ),
                              );
                            }
                            final listViewUsersRecord =
                                listViewUsersRecordList.isNotEmpty
                                    ? listViewUsersRecordList.first
                                    : null;

                            return Builder(
                              builder: (context) {
                                final savedJobs = listViewUsersRecord?.savedJobs
                                        .map((e) => e)
                                        .toList()
                                        .toList() ??
                                    [];
                                if (savedJobs.isEmpty) {
                                  return Center(
                                    child: EmptyFavsWidget(
                                      type: 'jobs',
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  padding: EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    0,
                                    48.0,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  itemCount: savedJobs.length,
                                  itemBuilder: (context, savedJobsIndex) {
                                    final savedJobsItem =
                                        savedJobs[savedJobsIndex];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 12.0, 16.0, 0.0),
                                      child: Container(
                                        width: 100.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 3.0,
                                              color: Color(0x3E000000),
                                              offset: Offset(
                                                0.0,
                                                1.0,
                                              ),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: FutureBuilder<JobsRecord>(
                                          future: JobsRecord.getDocumentOnce(
                                              savedJobsItem),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Image.asset(
                                                '',
                                              );
                                            }

                                            final columnJobsRecord =
                                                snapshot.data!;

                                            return InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'SAVED_JOBS_PAGE_Column_0uphsp2w_ON_TAP');
                                                logFirebaseEvent(
                                                    'Column_navigate_to');

                                                context.pushNamed(
                                                  JobDetailsWidget.routeName,
                                                  queryParameters: {
                                                    'jobPostDetails':
                                                        serializeParam(
                                                      columnJobsRecord
                                                          .reference,
                                                      ParamType
                                                          .DocumentReference,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      8.0,
                                                                      0.0),
                                                          child: Card(
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            elevation: 2.0,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            child: FutureBuilder<
                                                                UsersRecord>(
                                                              future: UsersRecord
                                                                  .getDocumentOnce(
                                                                      columnJobsRecord
                                                                          .companyRef!),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          28.0,
                                                                      height:
                                                                          28.0,
                                                                      child:
                                                                          SpinKitFoldingCube(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        size:
                                                                            28.0,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }

                                                                final logoUsersRecord =
                                                                    snapshot
                                                                        .data!;

                                                                return ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4.0),
                                                                  child:
                                                                      OctoImage(
                                                                    placeholderBuilder: (_) =>
                                                                        SizedBox
                                                                            .expand(
                                                                      child:
                                                                          Image(
                                                                        image: BlurHashImage(
                                                                            logoUsersRecord.profilePhotoBlurhash),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    image:
                                                                        CachedNetworkImageProvider(
                                                                      logoUsersRecord
                                                                          .photoUrl,
                                                                    ),
                                                                    width: 50.0,
                                                                    height:
                                                                        50.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        4.0,
                                                                        8.0,
                                                                        0.0,
                                                                        8.0),
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
                                                                  columnJobsRecord
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
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          4.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        columnJobsRecord
                                                                            .companyName,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              fontFamily: 'Montserrat',
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          4.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        '最後期限：${dateTimeFormat("MMMMEEEEd", columnJobsRecord.closingDate)}',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              fontFamily: 'Montserrat',
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      8.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Icon(
                                                            Icons
                                                                .chevron_right_rounded,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 24.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: FutureBuilder<List<ApplicationsRecord>>(
                          future: queryApplicationsRecordOnce(
                            queryBuilder: (applicationsRecord) =>
                                applicationsRecord
                                    .where(
                                      'applicant_ref',
                                      isEqualTo: currentUserReference,
                                    )
                                    .orderBy('time_created', descending: true),
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
                            List<ApplicationsRecord>
                                listViewApplicationsRecordList = snapshot.data!;
                            if (listViewApplicationsRecordList.isEmpty) {
                              return Center(
                                child: EmptyListWidget(),
                              );
                            }

                            return ListView.builder(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                0,
                                0,
                                48.0,
                              ),
                              scrollDirection: Axis.vertical,
                              itemCount: listViewApplicationsRecordList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewApplicationsRecord =
                                    listViewApplicationsRecordList[
                                        listViewIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 12.0, 16.0, 0.0),
                                  child: Container(
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 3.0,
                                          color: Color(0x3E000000),
                                          offset: Offset(
                                            0.0,
                                            1.0,
                                          ),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: FutureBuilder<JobsRecord>(
                                      future: JobsRecord.getDocumentOnce(
                                          listViewApplicationsRecord.jobRef!),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Image.asset(
                                            '',
                                          );
                                        }

                                        final columnJobsRecord = snapshot.data!;

                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'SAVED_JOBS_PAGE_Column_z10qgzjd_ON_TAP');
                                            logFirebaseEvent(
                                                'Column_navigate_to');

                                            context.pushNamed(
                                              ViewApplicationWidget.routeName,
                                              queryParameters: {
                                                'candidateDetails':
                                                    serializeParam(
                                                  currentUserReference,
                                                  ParamType.DocumentReference,
                                                ),
                                                'applicationRef':
                                                    serializeParam(
                                                  listViewApplicationsRecord
                                                      .reference,
                                                  ParamType.DocumentReference,
                                                ),
                                                'jobRef': serializeParam(
                                                  columnJobsRecord.reference,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  8.0,
                                                                  0.0),
                                                      child: Card(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        elevation: 2.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        child: FutureBuilder<
                                                            UsersRecord>(
                                                          future: UsersRecord
                                                              .getDocumentOnce(
                                                                  columnJobsRecord
                                                                      .companyRef!),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 28.0,
                                                                  height: 28.0,
                                                                  child:
                                                                      SpinKitFoldingCube(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    size: 28.0,
                                                                  ),
                                                                ),
                                                              );
                                                            }

                                                            final logoUsersRecord =
                                                                snapshot.data!;

                                                            return ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4.0),
                                                              child: OctoImage(
                                                                placeholderBuilder:
                                                                    (_) => SizedBox
                                                                        .expand(
                                                                  child: Image(
                                                                    image: BlurHashImage(
                                                                        logoUsersRecord
                                                                            .profilePhotoBlurhash),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                image:
                                                                    CachedNetworkImageProvider(
                                                                  logoUsersRecord
                                                                      .photoUrl,
                                                                ),
                                                                width: 50.0,
                                                                height: 50.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    4.0,
                                                                    8.0,
                                                                    0.0,
                                                                    8.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            AutoSizeText(
                                                              columnJobsRecord
                                                                  .position,
                                                              maxLines: 2,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          4.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    columnJobsRecord
                                                                        .companyName,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
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
                                                            'SAVED_JOBS_Container_6b0j89on_ON_TAP');
                                                        logFirebaseEvent(
                                                            'Container_bottom_sheet');
                                                        await showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          barrierColor:
                                                              Color(0x6795A1AC),
                                                          enableDrag: false,
                                                          context: context,
                                                          builder: (context) {
                                                            return Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child: Container(
                                                                height: 200.0,
                                                                child:
                                                                    OptionsWidget(
                                                                  job: columnJobsRecord
                                                                      .reference,
                                                                  applicationRef:
                                                                      listViewApplicationsRecord
                                                                          .reference,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ).then((value) =>
                                                            safeSetState(
                                                                () {}));
                                                      },
                                                      child: Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      8.0,
                                                                      0.0),
                                                          child: Icon(
                                                            Icons
                                                                .keyboard_control,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 32.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
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
    );
  }
}
