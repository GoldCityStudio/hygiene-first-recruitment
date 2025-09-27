import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/options/options_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:octo_image/octo_image.dart';
import 'company_job_listings_model.dart';
export 'company_job_listings_model.dart';

class CompanyJobListingsWidget extends StatefulWidget {
  const CompanyJobListingsWidget({super.key});

  static String routeName = 'companyJobListings';
  static String routePath = 'companyJobListings';

  @override
  State<CompanyJobListingsWidget> createState() =>
      _CompanyJobListingsWidgetState();
}

class _CompanyJobListingsWidgetState extends State<CompanyJobListingsWidget>
    with TickerProviderStateMixin {
  late CompanyJobListingsModel _model;
  bool _isGridView = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CompanyJobListingsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'companyJobListings'});
    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    // Check and update expired jobs
    _checkExpiredJobs();
  }

  Future<void> _checkExpiredJobs() async {
    final now = getCurrentTimestamp;
    final expiredJobs = await queryJobsRecordOnce(
      queryBuilder: (jobsRecord) => jobsRecord
          .where('status', isEqualTo: 'Active')
          .where('company_ref', isEqualTo: currentUserReference)
          .where('closing_date', isLessThan: now),
    );

    for (final job in expiredJobs) {
      await job.reference.update({
        'status': 'Closed',
      });
    }
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
      backgroundColor: Color(0xFFF5F7FA),
      floatingActionButton: Visibility(
        visible: valueOrDefault(currentUserDocument?.type, '') == 'Company',
        child: AuthUserStreamWidget(
          builder: (context) => FloatingActionButton(
            onPressed: () async {
              logFirebaseEvent('COMPANY_JOB_LISTINGS_FloatingActionButto');
              logFirebaseEvent('FloatingActionButton_navigate_to');

              context.pushNamed(
                PostJobWidget.routeName,
                extra: <String, dynamic>{
                  kTransitionInfoKey: TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.bottomToTop,
                    duration: Duration(milliseconds: 250),
                  ),
                },
              );
            },
            backgroundColor: Color(0xFF1A365D),
            elevation: 8,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF2B4C7E),
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            logFirebaseEvent('COMPANY_JOB_LISTINGS_Icon_3fhhfwv2_ON_TA');
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
          '職位管理',
          textAlign: TextAlign.start,
          style: FlutterFlowTheme.of(context).titleMedium.override(
                fontFamily: 'Montserrat',
                color: Colors.white,
                letterSpacing: 0.0,
              ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isGridView ? Icons.view_list : Icons.grid_view,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
            tooltip: _isGridView ? '列表視圖' : '網格視圖',
          ),
        ],
        centerTitle: false,
        elevation: 0,
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
                    labelColor: Color(0xFF2B4C7E),
                    unselectedLabelColor: Color(0xFF2B4C7E).withOpacity(0.7),
                    labelStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                    unselectedLabelStyle: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0.0,
                            ),
                    indicatorColor: Color(0xFF2B4C7E),
                    indicatorWeight: 3,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                    tabs: [
                      Tab(
                        text: '進行中',
                      ),
                      Tab(
                        text: '已結束',
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
                        child: FutureBuilder<List<JobsRecord>>(
                          future: queryJobsRecordOnce(
                            queryBuilder: (jobsRecord) => jobsRecord
                                .where(
                                  'status',
                                  isEqualTo: 'Active',
                                )
                                .where(
                                  'company_ref',
                                  isEqualTo: currentUserReference,
                                )
                                .where(
                                  'closing_date',
                                  isGreaterThan: getCurrentTimestamp,
                                )
                                .orderBy('created_at', descending: true),
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
                            List<JobsRecord> listViewJobsRecordList =
                                snapshot.data!;
                            if (listViewJobsRecordList.isEmpty) {
                              return Center(
                                child: EmptyListWidget(),
                              );
                            }

                            return _isGridView
                                ? GridView.builder(
                                    padding: EdgeInsets.all(16),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 3 : 
                                                    MediaQuery.of(context).size.width > 600 ? 2 : 1,
                                      childAspectRatio: 1.5,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                    ),
                                    itemCount: listViewJobsRecordList.length,
                                    itemBuilder: (context, index) {
                                      final job = listViewJobsRecordList[index];
                                      return _buildJobCard(job);
                                    },
                                  )
                                : ListView.builder(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 80.0),
                              scrollDirection: Axis.vertical,
                              itemCount: listViewJobsRecordList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewJobsRecord =
                                    listViewJobsRecordList[listViewIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 12.0, 16.0, 0.0),
                                        child: _buildJobCard(listViewJobsRecord),
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
                        child: FutureBuilder<List<JobsRecord>>(
                          future: queryJobsRecordOnce(
                            queryBuilder: (jobsRecord) => jobsRecord
                                .where(
                                  'company_ref',
                                  isEqualTo: currentUserReference,
                                )
                                .where(
                                  'status',
                                  isEqualTo: 'Closed',
                                )
                                .orderBy('created_at', descending: true),
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
                            List<JobsRecord> listViewJobsRecordList =
                                snapshot.data!;
                            if (listViewJobsRecordList.isEmpty) {
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
                              itemCount: listViewJobsRecordList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewJobsRecord =
                                    listViewJobsRecordList[listViewIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 12.0, 16.0, 0.0),
                                  child: _buildJobCard(listViewJobsRecord),
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

  Widget _buildJobCard(JobsRecord job) {
    return Container(
                                    decoration: BoxDecoration(
        color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 3.0,
            color: Color(0xFF2B4C7E).withOpacity(0.1),
            offset: Offset(0.0, 1.0),
                                        )
                                      ],
        borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          ApplicantsListWidget.routeName,
                                          queryParameters: {
                                            'jobPostDetails': serializeParam(
                job.reference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
        onLongPress: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            barrierColor: Color(0x6795A1AC),
            enableDrag: false,
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: Container(
                  height: 220.0,
                  child: OptionsWidget(
                    job: job.reference,
                  ),
                ),
              );
            },
          ).then((value) => safeSetState(() {}));
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                                                  child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Color(0xFF2B4C7E),
                                                    elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                                                    ),
                                                    child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: AuthUserStreamWidget(
                              builder: (context) => ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                                          child: OctoImage(
                                  placeholderBuilder: (_) => SizedBox.expand(
                                                              child: Image(
                                                                image: BlurHashImage(
                                                                    valueOrDefault(
                                          currentUserDocument?.profilePhotoBlurhash,
                                          '',
                                        ),
                                      ),
                                      fit: BoxFit.cover,
                                                              ),
                                                            ),
                                  image: CachedNetworkImageProvider(
                                                              currentUserPhoto,
                                                            ),
                                                            width: 50.0,
                                                            height: 50.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    job.position,
                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0.0,
                                          color: Color(0xFF1A365D),
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                FutureBuilder<List<ApplicationsRecord>>(
                                  future: queryApplicationsRecordOnce(
                                    queryBuilder: (applicationsRecord) => applicationsRecord
                                      .where('job_ref', isEqualTo: job.reference)
                                      .where('company_ref', isEqualTo: currentUserReference),
                                  ),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return SizedBox.shrink();
                                    }
                                    final hasApplicants = snapshot.data!.isNotEmpty;
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: hasApplicants ? Color(0xFFE6F4EA) : Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                                      children: [
                                          Icon(
                                            hasApplicants ? Icons.people_alt_rounded : Icons.person_outline_rounded,
                                            color: hasApplicants ? Color(0xFF1E7E34) : Color(0xFF666666),
                                            size: 16,
                                          ),
                                          SizedBox(width: 4),
                                                        Text(
                                            hasApplicants ? '有申請者' : '無申請者',
                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                  fontFamily: 'Montserrat',
                                                  color: hasApplicants ? Color(0xFF1E7E34) : Color(0xFF666666),
                                                  fontSize: 12,
                                                              ),
                                                        ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                                                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                              child: Text(
                                dateTimeFormat("relative", job.createdAt!),
                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0.0,
                                      color: Color(0xFF2B4C7E).withOpacity(0.7),
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.keyboard_control,
                      color: Color(0xFF2B4C7E),
                      size: 24.0,
                    ),
                    onPressed: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        barrierColor: Color(0x6795A1AC),
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: Container(
                              height: 220.0,
                              child: OptionsWidget(
                                job: job.reference,
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.attach_money_rounded,
                          color: Color(0xFF2B4C7E),
                          size: 16.0,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                          child: Text(
                            job.salaryMinimum > 0 ? '${job.salaryMinimum} - ${job.salaryMaximum} ${job.salaryType}' : '薪資面議',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF2B4C7E),
                                ),
                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: Color(0xFF2B4C7E),
                          size: 16.0,
                                                ),
                                                Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                          child: Text(
                            job.workingHours,
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF2B4C7E),
                                ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          color: Color(0xFF2B4C7E),
                          size: 16.0,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                          child: Text(
                            '截止日期: ${dateTimeFormat('yMMMd', job.closingDate!)}',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF2B4C7E),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: Color(0xFF2B4C7E),
                          size: 16.0,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                          child: Text(
                            job.location,
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF2B4C7E),
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
    );
  }
}
