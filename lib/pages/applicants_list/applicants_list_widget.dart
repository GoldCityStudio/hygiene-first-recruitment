import '/backend/backend.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:octo_image/octo_image.dart';
import 'package:share_plus/share_plus.dart';
import 'applicants_list_model.dart';
export 'applicants_list_model.dart';

class ApplicantsListWidget extends StatefulWidget {
  const ApplicantsListWidget({
    super.key,
    required this.jobPostDetails,
  });

  final DocumentReference? jobPostDetails;

  static String routeName = 'applicantsList';
  static String routePath = 'applicantsList';

  @override
  State<ApplicantsListWidget> createState() => _ApplicantsListWidgetState();
}

class _ApplicantsListWidgetState extends State<ApplicantsListWidget> {
  late ApplicantsListModel _model;
  bool _isGridView = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ApplicantsListModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'applicantsList'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<JobsRecord>(
      future: JobsRecord.getDocumentOnce(widget.jobPostDetails!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFFF5F7FA),
            body: Center(
              child: SizedBox(
                width: 28.0,
                height: 28.0,
                child: SpinKitFoldingCube(
                  color: Color(0xFF2B4C7E),
                  size: 28.0,
                ),
              ),
            ),
          );
        }

        final applicantsListJobsRecord = snapshot.data!;

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xFFF5F7FA),
          appBar: AppBar(
            backgroundColor: Color(0xFF2B4C7E),
            iconTheme: IconThemeData(color: Colors.white),
            automaticallyImplyLeading: true,
            title: Text(
              '申請者列表',
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
          body: SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: AutoSizeText(
                                    applicantsListJobsRecord.position,
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    style: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF1A365D),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (applicantsListJobsRecord.status ==
                                        'Active')
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 8.0, 0.0),
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 0.0,
                                          shape: const CircleBorder(),
                                          child: Container(
                                            width: 32.0,
                                            height: 32.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x66000000),
                                              shape: BoxShape.circle,
                                            ),
                                            child: FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30.0,
                                              buttonSize: 46.0,
                                              icon: Icon(
                                                Icons.edit,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                size: 14.0,
                                              ),
                                              onPressed: () async {
                                                logFirebaseEvent(
                                                    'APPLICANTS_LIST_PAGE_edit_ICN_ON_TAP');
                                                logFirebaseEvent(
                                                    'IconButton_navigate_to');
                                                if (Navigator.of(context)
                                                    .canPop()) {
                                                  context.pop();
                                                }
                                                context.pushNamed(
                                                  EditJobWidget.routeName,
                                                  queryParameters: {
                                                    'jobRef': serializeParam(
                                                      applicantsListJobsRecord
                                                          .jobUid,
                                                      ParamType
                                                          .DocumentReference,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (false)
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 8.0, 0.0),
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 0.0,
                                          shape: const CircleBorder(),
                                          child: Container(
                                            width: 32.0,
                                            height: 32.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x66000000),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Builder(
                                              builder: (context) =>
                                                  FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 30.0,
                                                buttonSize: 46.0,
                                                icon: Icon(
                                                  Icons.share_sharp,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  size: 16.0,
                                                ),
                                                onPressed: () async {
                                                  logFirebaseEvent(
                                                      'APPLICANTS_LIST_share_sharp_ICN_ON_TAP');
                                                  logFirebaseEvent(
                                                      'IconButton_generate_current_page_link');
                                                  _model.currentPageLink =
                                                      await generateCurrentPageLink(
                                                    context,
                                                    title:
                                                        'Job Opportunity: ${applicantsListJobsRecord.position}',
                                                    description:
                                                        'Discover your next career move! ${applicantsListJobsRecord.companyName} is hiring a ${applicantsListJobsRecord.position}. Learn more and apply on JobConnect today!',
                                                  );

                                                  logFirebaseEvent(
                                                      'IconButton_copy_to_clipboard');
                                                  await Clipboard.setData(
                                                      ClipboardData(
                                                          text: _model
                                                              .currentPageLink));
                                                  logFirebaseEvent(
                                                      'IconButton_share');
                                                  await Share.share(
                                                    _model.currentPageLink,
                                                    sharePositionOrigin:
                                                        getWidgetBoundingBox(
                                                            context),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 4.0, 16.0, 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  applicantsListJobsRecord.companyName,
                                  maxLines: 1,
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
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Colors.white,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF2B4C7E).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.work_outline_rounded,
                                                color: Color(0xFF2B4C7E),
                                                size: 16.0,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  applicantsListJobsRecord.type,
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        color: Color(0xFF2B4C7E),
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: applicantsListJobsRecord.status == 'Active'
                                                  ? Color(0xFF00D709).withOpacity(0.1)
                                                  : Color(0xFFE60000).withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  applicantsListJobsRecord.status == 'Active'
                                                      ? Icons.check_circle_outline_rounded
                                                      : Icons.cancel_outlined,
                                                  color: applicantsListJobsRecord.status == 'Active'
                                                      ? Color(0xFF00D709)
                                                      : Color(0xFFE60000),
                                                  size: 16.0,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    applicantsListJobsRecord.status == 'Active' ? '進行中' : '已結束',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          color: applicantsListJobsRecord.status == 'Active'
                                                              ? Color(0xFF00D709)
                                                              : Color(0xFFE60000),
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.attach_money_rounded,
                                            color: Color(0xFF2B4C7E),
                                            size: 16.0,
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              () {
                                                if (applicantsListJobsRecord.salaryMinimum > 0.0) {
                                                  return '${formatNumber(
                                                    applicantsListJobsRecord.salaryMinimum,
                                                    formatType: FormatType.decimal,
                                                    decimalType: DecimalType.periodDecimal,
                                                    currency: 'K',
                                                  )} - ${formatNumber(
                                                    applicantsListJobsRecord.salaryMaximum,
                                                    formatType: FormatType.decimal,
                                                    decimalType: DecimalType.periodDecimal,
                                                    currency: 'K',
                                                  )} ${applicantsListJobsRecord.salaryType}';
                                                } else {
                                                  return '薪資面議';
                                                }
                                              }(),
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF2B4C7E),
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.access_time_rounded,
                                            color: Color(0xFF2B4C7E),
                                            size: 16.0,
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              applicantsListJobsRecord.workingHours,
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF2B4C7E),
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.calendar_today_rounded,
                                            color: Color(0xFF2B4C7E),
                                            size: 16.0,
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              '截止日期: ${dateTimeFormat('yMMMd', applicantsListJobsRecord.closingDate!)}',
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF2B4C7E),
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.location_on_rounded,
                                            color: Color(0xFF2B4C7E),
                                            size: 16.0,
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              applicantsListJobsRecord.location,
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF2B4C7E),
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (applicantsListJobsRecord.description != null && applicantsListJobsRecord.description!.isNotEmpty)
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '服務說明',
                                              style: FlutterFlowTheme.of(context).titleSmall.override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF1A365D),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Text(
                                                applicantsListJobsRecord.description!,
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF2B4C7E),
                                                      letterSpacing: 0.0,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (applicantsListJobsRecord.requirements != null && applicantsListJobsRecord.requirements!.isNotEmpty)
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '服務要求',
                                              style: FlutterFlowTheme.of(context).titleSmall.override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF1A365D),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Text(
                                                applicantsListJobsRecord.requirements!,
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF2B4C7E),
                                                      letterSpacing: 0.0,
                                                    ),
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
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<int>(
                          future: queryApplicationsRecordCount(
                            queryBuilder: (applicationsRecord) =>
                                applicationsRecord.where(
                              'job_ref',
                              isEqualTo: widget.jobPostDetails,
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
                            int rowCount = snapshot.data!;

                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '已提交申請',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    rowCount.toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                Text(
                                  'Your Applicants',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        fontSize: 1.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            );
                          },
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          decoration: BoxDecoration(),
                          child: FutureBuilder<List<ApplicationsRecord>>(
                            future: queryApplicationsRecordOnce(
                              queryBuilder: (applicationsRecord) {
                                return applicationsRecord
                                    .where(
                                      'job_ref',
                                      isEqualTo: widget.jobPostDetails,
                                    )
                                    .where(
                                      'company_ref',
                                      isEqualTo: applicantsListJobsRecord.companyRef,
                                    )
                                    .orderBy('time_created', descending: true);
                              },
                            ),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 50.0, 0.0, 0.0),
                                    child: SizedBox(
                                      width: 28.0,
                                      height: 28.0,
                                      child: SpinKitFoldingCube(
                                        color: Color(0xFF2B4C7E),
                                        size: 28.0,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              List<ApplicationsRecord> listViewApplicationsRecordList =
                                  snapshot.data!;
                              if (listViewApplicationsRecordList.isEmpty) {
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
                                      itemCount: listViewApplicationsRecordList.length,
                                      itemBuilder: (context, index) {
                                        final listViewApplicationsRecord =
                                            listViewApplicationsRecordList[index];
                                        return _buildApplicantCard(listViewApplicationsRecord);
                                      },
                                    )
                                  : ListView.builder(
                                      padding: EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        48.0,
                                      ),
                                      primary: false,
                                      scrollDirection: Axis.vertical,
                                      itemCount: listViewApplicationsRecordList.length,
                                      itemBuilder: (context, listViewIndex) {
                                        final listViewApplicationsRecord =
                                            listViewApplicationsRecordList[listViewIndex];
                                        return _buildApplicantCard(listViewApplicationsRecord);
                                      },
                                    );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildApplicantCard(ApplicationsRecord application) {
    return FutureBuilder<UsersRecord>(
      future: UsersRecord.getDocumentOnce(application.applicantRef!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            width: 100.0,
            height: 75.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Color(0xFF2B4C7E).withOpacity(0.1),
                width: 1.0,
              ),
            ),
            child: Center(
              child: SizedBox(
                width: 24.0,
                height: 24.0,
                child: SpinKitFoldingCube(
                  color: Color(0xFF2B4C7E),
                  size: 24.0,
                ),
              ),
            ),
          );
        }
        final rowUsersRecord = snapshot.data!;
        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              16.0, 6.0, 16.0, 6.0),
          child: Material(
            color: Colors.transparent,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              width: 100.0,
              height: 75.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Color(0xFF2B4C7E).withOpacity(0.1),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3.0,
                    color: Color(0xFF2B4C7E).withOpacity(0.1),
                    offset: Offset(0.0, 1.0),
                  )
                ],
              ),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pushNamed(
                    ViewApplicationWidget.routeName,
                    queryParameters: {
                      'candidateDetails': serializeParam(
                        rowUsersRecord.reference,
                        ParamType.DocumentReference,
                      ),
                      'applicationRef': serializeParam(
                        application.reference,
                        ParamType.DocumentReference,
                      ),
                      'jobRef': serializeParam(
                        widget.jobPostDetails,
                        ParamType.DocumentReference,
                      ),
                    }.withoutNulls,
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          8.0, 0.0, 0.0, 0.0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 2.0,
                        shape: const CircleBorder(),
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Color(0xFF2B4C7E),
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: OctoImage(
                              placeholderBuilder: (_) => SizedBox.expand(
                                child: Image(
                                  image: BlurHashImage(
                                      rowUsersRecord.profilePhotoBlurhash),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              image: CachedNetworkImageProvider(
                                rowUsersRecord.photoUrl,
                              ),
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 1.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              rowUsersRecord.displayName,
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF1A365D),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 4.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    dateTimeFormat(
                                        "relative",
                                        application.timeCreated!),
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF2B4C7E).withOpacity(0.7),
                                          letterSpacing: 0.0,
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
            ),
          ),
        );
      },
    );
  }
}
