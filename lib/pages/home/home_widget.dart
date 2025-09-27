import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_list/empty_list_widget.dart';
import '/components/modal_guest_profile/modal_guest_profile_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import '/pages/company_dashboard/company_dashboard_widget.dart';
import 'package:badges/badges.dart' as badges;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';
import 'package:intl/intl.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static String routeName = 'home';
  static String routePath = 'home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  late HomeModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final animationsMap = <String, AnimationInfo>{};
  bool isSmallScreen = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'home'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('HOME_PAGE_home_ON_INIT_STATE');
      if (getRemoteConfigBool('underMaintenance')) {
        logFirebaseEvent('home_navigate_to');
        context.pushNamed(UnderMaintenanceWidget.routeName);
        return;
      } else {
        logFirebaseEvent('home_custom_action');
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
          logFirebaseEvent('home_navigate_to');
          context.goNamed(ForceUpdateWidget.routeName);
          return;
        } else {
          logFirebaseEvent('home_wait__delay');
          await Future.delayed(const Duration(milliseconds: 3000));
          
          // Wait for user document to be loaded
          if (currentUserReference == null) {
            return;
          }
          
          try {
            final userDoc = await UsersRecord.getDocumentOnce(currentUserReference!);
            if (!mounted) return;
          
          // Check if user has a profile type set
            final userType = valueOrDefault(userDoc.type, '');
          
          if (userType.isEmpty && currentUserDisplayName.isEmpty) {
            // New user without profile
            logFirebaseEvent('home_navigate_to');
            context.goNamed(CreateProfileWidget.routeName);
            return;
            } else if (userType == 'Company') {
              // Company user, redirect to dashboard
              logFirebaseEvent('home_navigate_to');
              context.goNamed(CompanyDashboardWidget.routeName);
              return;
            } else if (userType == 'Individual') {
              // Individual user, no need to redirect
            if (!(await getPermissionStatus(notificationsPermission))) {
              logFirebaseEvent('home_request_permissions');
              await requestPermission(notificationsPermission);
            }
            return;
          } else if (userType == 'Guest') {
            // Guest user, no need to redirect
              return;
            }
          } catch (e) {
            print('Error loading user document: $e');
            return;
          }
        }
      }
    });

    animationsMap.addAll({
      'floatingActionButtonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(100.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'searchBarOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, -20.0),
            end: Offset(0.0, 0.0),
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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        title: Text(
          '首頁',
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
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '歡迎回來',
                        style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                        child: Text(
                          currentUserDisplayName,
                          style: FlutterFlowTheme.of(context).titleLarge.copyWith(
                                fontFamily: 'Montserrat',
                                color: Colors.white.withOpacity(0.8),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              _buildRecentJobsSection(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
      child: IconButton(
        icon: Icon(
          Icons.notifications_outlined,
          color: FlutterFlowTheme.of(context).primaryText,
          size: 24.0,
          ),
        onPressed: () => context.pushNamed('notifications'),
      ),
    );
  }

  Widget _buildProfileButton(UsersRecord userDoc) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: FlutterFlowTheme.of(context).primary,
        child: Text(
          userDoc.displayName?.isNotEmpty == true 
              ? userDoc.displayName!.substring(0, 1).toUpperCase() 
              : 'U',
          style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '熱門類別',
                style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                  color: FlutterFlowTheme.of(context).primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () => context.pushNamed('categories'),
                child: Text(
                  '查看全部',
                  style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                final category = [
                  {'name': '全部', 'icon': Icons.all_inclusive},
                  {'name': '全職', 'icon': Icons.work},
                  {'name': '兼職', 'icon': Icons.work_outline},
                  {'name': '實習', 'icon': Icons.school},
                  {'name': '遠程', 'icon': Icons.computer},
                ][index];
                return _buildCategoryCard(category);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () => context.pushNamed(
          'jobsByCategory',
          queryParameters: {
            'category': category['name'],
          },
        ),
        child: Container(
          width: 100,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                category['icon'],
                color: FlutterFlowTheme.of(context).primary,
                size: 32,
              ),
              SizedBox(height: 8),
              Text(
                category['name'],
                style: FlutterFlowTheme.of(context).bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedJobsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '精選職位',
                style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                  color: FlutterFlowTheme.of(context).primary,
                  fontWeight: FontWeight.w600,
                    ),
              ),
              TextButton(
                onPressed: () => context.pushNamed('featuredJobs'),
                child: Text(
                  '查看全部',
                  style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          StreamBuilder<List<JobsRecord>>(
            stream: queryJobsRecord(
              queryBuilder: (jobsRecord) => jobsRecord
                  .where('is_featured', isEqualTo: true)
                  .orderBy('created_at', descending: true)
                  .limit(3),
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star_outline,
                        size: 48,
                        color: FlutterFlowTheme.of(context).secondaryText.withOpacity(0.5),
                      ),
                      SizedBox(height: 12),
                      Text(
                        '暫無精選職位',
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
        ],
      ),
    );
  }

  Widget _buildRecentJobsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '最新職位',
                style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                  color: FlutterFlowTheme.of(context).primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () => context.pushNamed('recentJobs'),
                child: Text(
                  '查看全部',
                  style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          StreamBuilder<List<JobsRecord>>(
      stream: queryJobsRecord(
              queryBuilder: (jobsRecord) => jobsRecord
                  .orderBy('created_at', descending: true)
            .limit(5),
      ),
      builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
        }

              final jobs = snapshot.data!;
              if (jobs.isEmpty) {
                return Center(
                  child: Text('暫無職位'),
                );
        }

              return Column(
                children: jobs.map((job) => _buildJobCard(job)).toList(),
              );
          },
          ),
        ],
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
      
      // Add salary type
      if (salaryText.isNotEmpty) {
        salaryText += ' ${job.salaryType}';
      }
      
      return salaryText;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
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
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                children: [
                  Icon(
                    Icons.attach_money,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 20,
                  ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  getSalaryText(),
                                  style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                  ),
                ],
              ),
                        ),
                        Container(
                          width: 1,
                          height: 24,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          color: FlutterFlowTheme.of(context).alternate.withOpacity(0.3),
                        ),
                        Expanded(
                          child: Row(
                  children: [
                    Icon(
                                Icons.timer_outlined,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 20,
                    ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${job.minExperience} 年經驗',
                                  style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                    fontWeight: FontWeight.w500,
                ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                Row(
                      children: [
                        Expanded(
                          child: Row(
                  children: [
                    Icon(
                                Icons.location_on_outlined,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 20,
                    ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  job.location,
                                  style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                    fontWeight: FontWeight.w500,
                    ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                ),
              ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 24,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          color: FlutterFlowTheme.of(context).alternate.withOpacity(0.3),
                        ),
                        Expanded(
                          child: Row(
                  children: [
                    Icon(
                                Icons.work_outline,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 20,
                    ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  job.type,
                                  style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                    fontWeight: FontWeight.w500,
                    ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                ),
                              ),
            ],
          ),
        ),
                      ],
                    ),
                  ],
                ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '載入失敗',
              style: FlutterFlowTheme.of(context).headlineMedium,
            ),
            SizedBox(height: 16),
            FFButtonWidget(
              onPressed: () {
                setState(() {});
              },
              text: '重試',
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
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

