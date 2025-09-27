import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/modal_closed_job/modal_closed_job_widget.dart';
import '/components/modal_company_acc/modal_company_acc_widget.dart';
import '/components/modal_guest_profile/modal_guest_profile_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:octo_image/octo_image.dart';
import 'package:share_plus/share_plus.dart';
import 'job_details_model.dart';
export 'job_details_model.dart';

class JobDetailsWidget extends StatefulWidget {
  const JobDetailsWidget({
    super.key,
    required this.jobPostDetails,
  });

  final DocumentReference? jobPostDetails;

  static String routeName = 'jobDetails';
  static String routePath = 'jobDetails';

  @override
  State<JobDetailsWidget> createState() => _JobDetailsWidgetState();
}

class _JobDetailsWidgetState extends State<JobDetailsWidget>
    with TickerProviderStateMixin {
  late JobDetailsModel _model;
  late JobsRecord jobDetailsJobsRecord;
  bool isSmallScreen = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JobDetailsModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'jobDetails'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('JOB_DETAILS_jobDetails_ON_INIT_STATE');
      if (getRemoteConfigBool('underMaintenance')) {
        logFirebaseEvent('jobDetails_navigate_to');

        context.pushNamed(UnderMaintenanceWidget.routeName);

        return;
      } else {
        logFirebaseEvent('jobDetails_custom_action');
        _model.build = await actions.getAppBuildNumber();
        if (_model.build! <
            () {
              if (isiOS) {
                return getRemoteConfigInt('minBuildNoIOS');
              } else if (isAndroid) {
                return getRemoteConfigInt('minBuildNoAndroid');
              } else {
                return 0;
              }
            }()) {
          logFirebaseEvent('jobDetails_navigate_to');

          context.goNamed(ForceUpdateWidget.routeName);

          return;
        }
      }
    });

    animationsMap.addAll({
      'wrapOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 200.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<JobsRecord>(
      stream: JobsRecord.getDocument(widget.jobPostDetails!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildErrorScaffold(context);
        }

        if (!snapshot.hasData) {
          return _buildLoadingScaffold(context);
        }

        jobDetailsJobsRecord = snapshot.data!;
        return LayoutBuilder(
          builder: (context, constraints) {
            isSmallScreen = constraints.maxWidth < 600;
            return Scaffold(
              key: scaffoldKey,
              backgroundColor: Colors.white,
              appBar: _buildAppBar(),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _buildHeaderSection(),
                    _buildContentSection(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: FlutterFlowIconButton(
        borderColor: Colors.transparent,
        borderRadius: 30.0,
        borderWidth: 1.0,
        buttonSize: 60.0,
        icon: Icon(
          Icons.arrow_back_rounded,
          color: FlutterFlowTheme.of(context).primaryText,
          size: 30.0,
        ),
        onPressed: () async {
          context.pop();
        },
      ),
      title: Text(
        '服務詳情',
        style: FlutterFlowTheme.of(context).headlineMedium,
      ),
      actions: [
        if (!isSmallScreen)
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
            child: FFButtonWidget(
              onPressed: () => _handleApplyButton(context),
              text: '立即申請',
              options: FFButtonOptions(
                width: 120.0,
                height: 40.0,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                    ),
                elevation: 2.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
      ],
      centerTitle: true,
      elevation: 0.0,
    );
  }

  Widget _buildHeaderSection() {
    bool isExpired = jobDetailsJobsRecord.closingDate != null && 
        jobDetailsJobsRecord.closingDate!.isBefore(DateTime.now());

    String getSalaryDisplay() {
      if (jobDetailsJobsRecord.salaryType == 'hourly') {
        if (jobDetailsJobsRecord.salaryMinimum == 0 && jobDetailsJobsRecord.salaryMaximum == 0) {
          return '時薪面議';
        }
        return '時薪 \$${jobDetailsJobsRecord.salaryMinimum.toStringAsFixed(0)} - \$${jobDetailsJobsRecord.salaryMaximum.toStringAsFixed(0)} / 小時';
      } else {
        if (jobDetailsJobsRecord.salaryMinimum == 0 && jobDetailsJobsRecord.salaryMaximum == 0) {
          return '月薪面議';
        }
        return '月薪 \$${jobDetailsJobsRecord.salaryMinimum.toStringAsFixed(0)} - \$${jobDetailsJobsRecord.salaryMaximum.toStringAsFixed(0)} / 月';
      }
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            FlutterFlowTheme.of(context).primary,
            FlutterFlowTheme.of(context).primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Design elements
          Positioned(
            right: -50,
            top: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            left: -30,
            bottom: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.fromLTRB(24, 32, 24, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jobDetailsJobsRecord.position,
                            style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                              fontSize: 32,
                              letterSpacing: -0.5,
                  ),
            ),
            SizedBox(height: 16),
              Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.business,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                ),
                                SizedBox(width: 12),
                                Expanded(
                child: Text(
                                    jobDetailsJobsRecord.companyName,
                  style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                        color: Colors.white,
                                      fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
          ],
        ),
                          ),
                        ],
                      ),
                    ),
                    if (isExpired)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.red.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 6),
                            Text(
                              '已過期',
                              style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildHeaderInfoItem(
                        Icons.attach_money,
                        getSalaryDisplay(),
                        jobDetailsJobsRecord.salaryType == 'hourly' ? '時薪範圍' : '月薪範圍',
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      _buildHeaderInfoItem(
                        Icons.work_outline,
                        jobDetailsJobsRecord.type,
                        '服務類型',
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      _buildHeaderInfoItem(
                        Icons.location_on_outlined,
                        jobDetailsJobsRecord.location,
                        '服務地點',
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

  Widget _buildHeaderInfoItem(IconData icon, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: FlutterFlowTheme.of(context).titleSmall.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: FlutterFlowTheme.of(context).bodySmall.copyWith(
            color: Colors.white.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildJobDetailsGrid(),
          SizedBox(height: 12),
          _buildJobDescription(),
          SizedBox(height: 12),
          _buildRequirements(),
          SizedBox(height: 12),
          _buildApplicationDetails(),
          SizedBox(height: 12),
          if (isSmallScreen) _buildApplyButton(),
          SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildJobDetailsGrid() {
    final jobAttributes = [
      JobAttribute(
        icon: Icons.timer_outlined,
        iconColor: Color(0xFF9C27B0),
        backgroundColor: Color(0xFFF3E5F5),
        label: '經驗要求',
        value: '${jobDetailsJobsRecord.minExperience} 年',
      ),
      JobAttribute(
        icon: Icons.access_time_rounded,
        iconColor: Color(0xFFE91E63),
        backgroundColor: Color(0xFFFCE4EC),
        label: '工作時間',
        value: jobDetailsJobsRecord.workingHours,
      ),
      JobAttribute(
        icon: Icons.calendar_today_outlined,
        iconColor: Color(0xFF795548),
        backgroundColor: Color(0xFFEFEBE9),
        label: '工作期間',
        value: jobDetailsJobsRecord.startDate != null && jobDetailsJobsRecord.endDate != null
            ? '${dateTimeFormat('MM/dd/yyyy', jobDetailsJobsRecord.startDate)} - ${dateTimeFormat('MM/dd/yyyy', jobDetailsJobsRecord.endDate)}'
            : '長期',
          ),
    ];

    if (isSmallScreen) {
      return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
        itemCount: jobAttributes.length,
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) => _buildJobAttributeCard(jobAttributes[index]),
      );
    }

    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text(
            '服務資訊',
            style: FlutterFlowTheme.of(context).headlineSmall.copyWith(
              fontWeight: FontWeight.bold,
              color: FlutterFlowTheme.of(context).primaryText,
        ),
          ),
          SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: jobAttributes.length,
            itemBuilder: (context, index) => _buildJobAttributeItem(jobAttributes[index]),
        ),
        ],
      ),
    );
  }

  Widget _buildJobAttributeCard(JobAttribute attribute) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
        ),
      ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: attribute.backgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              attribute.icon,
              color: attribute.iconColor,
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
      children: [
        Text(
                  attribute.label,
                  style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontWeight: FontWeight.w500,
              ),
        ),
                SizedBox(height: 4),
                Text(
                  attribute.value,
                  style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobAttributeItem(JobAttribute attribute) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
        color: attribute.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
            border: Border.all(
          color: attribute.iconColor.withOpacity(0.2),
              width: 1,
            ),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: attribute.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  attribute.icon,
                  color: attribute.iconColor,
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Text(
                attribute.label,
                style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                  color: FlutterFlowTheme.of(context).secondaryText,
                  fontWeight: FontWeight.w500,
          ),
        ),
      ],
          ),
          SizedBox(height: 12),
          Text(
            attribute.value,
            style: FlutterFlowTheme.of(context).titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildJobDescription() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.description_outlined,
                  color: FlutterFlowTheme.of(context).primary,
                  size: 24,
                ),
              ),
              SizedBox(width: 12),
        Text(
                '服務說明',
          style: FlutterFlowTheme.of(context).titleLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
              ),
            ],
        ),
        SizedBox(height: 16),
          Text(
            jobDetailsJobsRecord.description,
            style: FlutterFlowTheme.of(context).bodyLarge.copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirements() {
    return Container(
      padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
        borderRadius: BorderRadius.circular(16),
            border: Border.all(
          color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
              width: 1,
            ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: Offset(0, 4),
        ),
      ],
      ),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.assignment_outlined,
                  color: FlutterFlowTheme.of(context).primary,
                  size: 24,
                ),
              ),
              SizedBox(width: 12),
        Text(
                '服務要求',
          style: FlutterFlowTheme.of(context).titleLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
              ),
            ],
        ),
        SizedBox(height: 16),
          Text(
            jobDetailsJobsRecord.requirements,
            style: FlutterFlowTheme.of(context).bodyLarge.copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationDetails() {
    String formatDate(dynamic date) {
      if (date == null) return 'N/A';
      if (date is DateTime) return dateTimeFormat('MM/dd/yyyy', date);
      if (date is Timestamp) return dateTimeFormat('MM/dd/yyyy', date.toDate());
      return 'N/A';
    }

    return Container(
      padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
        borderRadius: BorderRadius.circular(16),
            border: Border.all(
          color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
              width: 1,
            ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.app_registration,
                  color: FlutterFlowTheme.of(context).primary,
                  size: 24,
                ),
              ),
              SizedBox(width: 12),
              Text(
                '申請詳情',
                style: FlutterFlowTheme.of(context).titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
              _buildApplicationDetailRow(
                '申請截止日期',
            formatDate(jobDetailsJobsRecord.closingDate),
                Icons.calendar_today_outlined,
              ),
              SizedBox(height: 16),
              _buildApplicationDetailRow(
                '需要求職信',
                jobDetailsJobsRecord.requiresCoverLetter ? '是' : '否',
                Icons.description_outlined,
              ),
              if (jobDetailsJobsRecord.applicationLink.isNotEmpty) ...[
                SizedBox(height: 16),
                _buildApplicationDetailRow(
                  '申請連結',
                  jobDetailsJobsRecord.applicationLink,
                  Icons.link_outlined,
                ),
              ],
            ],
          ),
    );
  }

  Widget _buildApplicationDetailRow(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
      children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
          icon,
          color: FlutterFlowTheme.of(context).primary,
          size: 20,
            ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
      ),
    );
  }

  Widget _buildApplyButton() {
    return Container(
        width: double.infinity,
      height: 60.0,
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            FlutterFlowTheme.of(context).primary,
            FlutterFlowTheme.of(context).primary.withOpacity(0.8),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: FlutterFlowTheme.of(context).primary.withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
          color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleApplyButton(context),
          borderRadius: BorderRadius.circular(20.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.rocket_launch_rounded,
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: 12),
                Text(
                  '立即申請',
                  style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleApplyButton(BuildContext context) async {
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('請先登入以申請服務'),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
      return;
    }

    // Check if user has already applied
    final applicationsQuery = await ApplicationsRecord.collection
        .where('job_ref', isEqualTo: widget.jobPostDetails)
        .where('applicant_ref', isEqualTo: currentUserReference)
        .get();

    if (applicationsQuery.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('您已經申請過此服務'),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
      return;
    }

    // Check if job is still active
    if (jobDetailsJobsRecord.status != 'Active') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('此服務已關閉'),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
      return;
    }

    // Check if job has reached closing date
    if (jobDetailsJobsRecord.closingDate != null && 
        jobDetailsJobsRecord.closingDate!.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('此服務已截止申請'),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
      return;
    }

    // Navigate to create application page
    context.pushNamed(
      'createApplication',
      queryParameters: {
        'jobPostDetails': serializeParam(
          widget.jobPostDetails,
          ParamType.DocumentReference,
        ),
        'position': serializeParam(
          jobDetailsJobsRecord.position,
          ParamType.String,
        ),
        'compName': serializeParam(
          jobDetailsJobsRecord.companyName,
          ParamType.String,
        ),
        'compRefDoc': serializeParam(
          jobDetailsJobsRecord.companyRef,
          ParamType.DocumentReference,
        ),
        'requiresCoverLetter': serializeParam(
          jobDetailsJobsRecord.requiresCoverLetter,
          ParamType.bool,
                ),
      }.withoutNulls,
    );
  }

  Widget _buildErrorScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 30.0,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        title: Text(
          'Error',
          style: FlutterFlowTheme.of(context).headlineMedium,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error loading job details',
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  context.pop();
                },
                text: 'Go Back',
                options: FFButtonOptions(
                  width: 130.0,
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                      ),
                  elevation: 2.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 30.0,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        title: Text(
          'Loading...',
          style: FlutterFlowTheme.of(context).headlineMedium,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class JobAttribute {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String label;
  final String value;

  JobAttribute({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.label,
    required this.value,
  });
}
