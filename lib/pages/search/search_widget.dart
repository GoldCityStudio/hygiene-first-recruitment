import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/modal_guest_profile/modal_guest_profile_widget.dart';
import '/components/search_results/search_results_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'search_model.dart';
export 'search_model.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  static String routeName = 'search';
  static String routePath = 'search';

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late SearchModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'search'});
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        title: Text(
          '搜尋',
          style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24.0),
                    bottomRight: Radius.circular(24.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 24.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent('SEARCH_PAGE__BTN_ON_TAP');
                      logFirebaseEvent('Button_bottom_sheet');
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: SearchResultsWidget(),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                    text: '搜尋職位...',
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 56.0,
                      padding: EdgeInsets.all(0.0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
                      color: Colors.white,
                      textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                          ),
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '職位類別',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 24.0),
                child: FutureBuilder<List<CategoriesRecord>>(
                future: FFAppState().categories(
                  requestFn: () => queryCategoriesRecordOnce(
                    queryBuilder: (categoriesRecord) =>
                        categoriesRecord.orderBy('name'),
                  ),
                ),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 32.0,
                        height: 32.0,
                        child: SpinKitFoldingCube(
                          color: FlutterFlowTheme.of(context).primary,
                          size: 32.0,
                        ),
                      ),
                    );
                  }
                  List<CategoriesRecord> listViewCategoriesRecordList =
                      snapshot.data!;
                  if (listViewCategoriesRecordList.isEmpty) {
                    return Center(
                      child: Image.asset(
                        'assets/images/noJobPosts@2x.png',
                        width: 200.0,
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewCategoriesRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewCategoriesRecord =
                          listViewCategoriesRecordList[listViewIndex];
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x33000000),
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                                            child: Text(
                                              listViewCategoriesRecord.name,
                                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (valueOrDefault(currentUserDocument?.type, '') != 'Company')
                                        Align(
                                          alignment: AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                                            child: AuthUserStreamWidget(
                                              builder: (context) => Container(
                                                width: 40.0,
                                                height: 40.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 4.0,
                                                      color: Color(0x33000000),
                                                      offset: Offset(0.0, 2.0),
                                                    )
                                                  ],
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(context).alternate,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: StreamBuilder<UsersRecord>(
                                                  stream: FFAppState().heart(
                                                    requestFn: () => UsersRecord.getDocument(currentUserReference!),
                                                  ),
                                                  builder: (context, snapshot) {
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

                                                    final toggleIconUsersRecord = snapshot.data!;
                                                    return ToggleIcon(
                                                      onPressed: () async {
                                                        final categoryInterestsElement = listViewCategoriesRecord.reference;
                                                        final categoryInterestsUpdate = toggleIconUsersRecord.categoryInterests.contains(categoryInterestsElement)
                                                            ? FieldValue.arrayRemove([categoryInterestsElement])
                                                            : FieldValue.arrayUnion([categoryInterestsElement]);
                                                        await toggleIconUsersRecord.reference.update({
                                                          ...mapToFirestore(
                                                            {
                                                              'category_interests': categoryInterestsUpdate,
                                                            },
                                                          ),
                                                        });
                                                        logFirebaseEvent('SEARCH_ToggleIcon_dzdblk8j_ON_TOGGLE');
                                                        if (loggedIn == true) {
                                                          if (valueOrDefault(currentUserDocument?.type, '') == 'Guest') {
                                                            await showModalBottomSheet(
                                                              isScrollControlled: true,
                                                              backgroundColor: Color(0x66222222),
                                                              isDismissible: false,
                                                              enableDrag: false,
                                                              context: context,
                                                              builder: (context) {
                                                                return Padding(
                                                                  padding: MediaQuery.viewInsetsOf(context),
                                                                  child: ModalGuestProfileWidget(),
                                                                );
                                                              },
                                                            ).then((value) => safeSetState(() {}));
                                                          } else {
                                                            if (toggleIconUsersRecord.categoryInterests.contains(listViewCategoriesRecord.reference)) {
                                                              HapticFeedback.selectionClick();
                                                              ScaffoldMessenger.of(context).clearSnackBars();
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Removed from your interests.',
                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                          fontFamily: 'Montserrat',
                                                                          color: FlutterFlowTheme.of(context).primaryBtnText,
                                                                          letterSpacing: 0.0,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(milliseconds: 4000),
                                                                  backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                ),
                                                              );
                                                            } else {
                                                              HapticFeedback.selectionClick();
                                                              ScaffoldMessenger.of(context).clearSnackBars();
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Added to your interests.',
                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                          fontFamily: 'Montserrat',
                                                                          color: FlutterFlowTheme.of(context).primaryBtnText,
                                                                          letterSpacing: 0.0,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(milliseconds: 4000),
                                                                  backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                ),
                                                              );
                                                            }
                                                          }
                                                        } else {
                                                          await showModalBottomSheet(
                                                            isScrollControlled: true,
                                                            backgroundColor: Color(0x66222222),
                                                            isDismissible: false,
                                                            enableDrag: false,
                                                            context: context,
                                                            builder: (context) {
                                                              return Padding(
                                                                padding: MediaQuery.viewInsetsOf(context),
                                                                child: ModalGuestProfileWidget(),
                                                              );
                                                            },
                                                          ).then((value) => safeSetState(() {}));
                                                        }
                                                      },
                                                      value: toggleIconUsersRecord.categoryInterests.contains(listViewCategoriesRecord.reference),
                                                      onIcon: Icon(
                                                        Icons.favorite_rounded,
                                                        color: FlutterFlowTheme.of(context).error,
                                                        size: 20.0,
                                                      ),
                                                      offIcon: Icon(
                                                        Icons.favorite_border_rounded,
                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                        size: 20.0,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (listViewIndex < listViewCategoriesRecordList.length - 1)
                              Divider(
                                height: 1.0,
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context).alternate,
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '最新職位',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 24.0),
                child: StreamBuilder<List<JobsRecord>>(
                  stream: queryJobsRecord(
                    queryBuilder: (jobsRecord) => jobsRecord
                        .orderBy('created_at', descending: true)
                        .limit(10),
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final jobs = snapshot.data!;
                    if (jobs.isEmpty) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate.withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.work_outline,
                              size: 48,
                              color: FlutterFlowTheme.of(context).secondaryText.withOpacity(0.5),
                            ),
                            SizedBox(height: 12),
                            Text(
                              '暫無職位',
                              style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                                color: FlutterFlowTheme.of(context).secondaryText,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '請稍後再查看',
                              style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                color: FlutterFlowTheme.of(context).secondaryText.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return Column(
                      children: jobs.map((job) => _buildJobCard(job)).toList(),
                    );
                  },
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobCard(JobsRecord job) {
    bool isExpired = job.closingDate != null && 
        job.closingDate!.isBefore(DateTime.now());

    String getSalaryText() {
      if (job.salaryMinimum == 0 && job.salaryMaximum == 0) {
        return '薪資面議';
      }
      
      final formatter = NumberFormat('#,###');
      String salaryText = '';
      
      if (job.salaryMinimum > 0 && job.salaryMaximum > 0) {
        salaryText = '${formatter.format(job.salaryMinimum)} - ${formatter.format(job.salaryMaximum)}';
      } else if (job.salaryMinimum > 0) {
        salaryText = '${formatter.format(job.salaryMinimum)} 起';
      } else if (job.salaryMaximum > 0) {
        salaryText = '至 ${formatter.format(job.salaryMaximum)}';
      }
      
      if (salaryText.isNotEmpty) {
        salaryText += ' ${job.salaryType}';
      }
      
      return salaryText;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => context.pushNamed(
          'jobDetails',
          queryParameters: {
            'jobPostDetails': serializeParam(
              job.reference,
              ParamType.DocumentReference,
            ),
          }.withoutNulls,
        ),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.work_outline,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 24,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.position,
                          style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          job.companyName,
                          style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (isExpired)
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.red.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 14,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '已過期',
                                style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (job.isFeatured ?? false)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).primary.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            '精選',
                            style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                              color: FlutterFlowTheme.of(context).primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              if (job.location != null && job.location!.isNotEmpty) ...[
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        job.location!,
                        style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      getSalaryText(),
                      style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                        color: FlutterFlowTheme.of(context).primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (job.createdAt != null)
                    Text(
                      DateFormat('yyyy/MM/dd').format(job.createdAt!),
                      style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
