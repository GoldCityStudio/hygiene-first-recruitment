import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_notifs/empty_notifs_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'notifications_model.dart';
export 'notifications_model.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({super.key});

  static String routeName = 'notifications';
  static String routePath = 'notifications';

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  late NotificationsModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'notifications'});
    
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('NOTIFICATIONS_notifications_ON_INIT_STAT');
      if (valueOrDefault(currentUserDocument?.type, '') == 'Guest') {
        logFirebaseEvent('notifications_navigate_to');
        context.pushNamed(GuestWidget.routeName);
      } else {
        logFirebaseEvent('notifications_wait__delay');
        await Future.delayed(const Duration(milliseconds: 10000));
        logFirebaseEvent('notifications_backend_call');
        await currentUserReference!.update({
          ...mapToFirestore(
            {
              'notifications_last_seen_time': FieldValue.serverTimestamp(),
            },
          ),
        });
      }
    });
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            '通知',
            style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('NOTIFICATIONS_PAGE_Icon_tlwvnodw_ON_TAP');
                  logFirebaseEvent('Icon_navigate_to');
                  context.pushNamed(NotificationSettingsWidget.routeName);
                },
                child: Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        color: Color(0x0A000000),
                        offset: Offset(0.0, 4.0),
                        spreadRadius: 2.0,
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.settings_outlined,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        '查看您的所有通知',
                        style: FlutterFlowTheme.of(context).labelMedium.copyWith(
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        color: Color(0x0A000000),
                        offset: Offset(0.0, -4.0),
                        spreadRadius: 2.0,
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0),
                    ),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: FutureBuilder<List<NotificationsRecord>>(
          future: queryNotificationsRecordOnce(
            queryBuilder: (notificationsRecord) => notificationsRecord
                .where(
                  'recipient',
                  arrayContains: currentUserReference?.id,
                )
                .orderBy('timestamp', descending: true),
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
            List<NotificationsRecord> listViewNotificationsRecordList =
                snapshot.data!;
            if (listViewNotificationsRecordList.isEmpty) {
              return Center(
                child: Container(
                  height: double.infinity,
                  child: EmptyNotifsWidget(),
                ),
              );
            }

            return ListView.separated(
                          padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 48.0),
              scrollDirection: Axis.vertical,
              itemCount: listViewNotificationsRecordList.length,
                          separatorBuilder: (_, __) => SizedBox(height: 16.0),
              itemBuilder: (context, listViewIndex) {
                final listViewNotificationsRecord =
                    listViewNotificationsRecordList[listViewIndex];
                            return _buildNotificationItem(
                              context, 
                              listViewNotificationsRecord,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    NotificationsRecord notification,
  ) {
    String translatedContent = notification.content;
    if (notification.notificationType == 'Application') {
      if (notification.content.contains('has been accepted')) {
        translatedContent = '您申請的職位已被接受。';
      } else if (notification.content.contains('has been rejected')) {
        translatedContent = '您申請的職位已被拒絕。';
      } else if (notification.content.contains('has submitted a new application')) {
        translatedContent = '已提交新申請。';
      }
    }

                return InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
        logFirebaseEvent('NOTIFICATIONS_Container_q0tmgxm8_ON_TAP');
        if (notification.notificationType == '截止通知' ||
            notification.notificationType == '職位通知') {
                      logFirebaseEvent('Container_navigate_to');
                      context.pushNamed(
                        JobDetailsWidget.routeName,
                        queryParameters: {
                          'jobPostDetails': serializeParam(
                notification.relatedJob,
                            ParamType.DocumentReference,
                          ),
                        }.withoutNulls,
                      );
        } else if (notification.notificationType == '入選通知' ||
                   notification.notificationType == '申請通知') {
                      logFirebaseEvent('Container_navigate_to');
                      context.pushNamed(
                        ViewApplicationWidget.routeName,
                        queryParameters: {
                          'candidateDetails': serializeParam(
                            currentUserReference,
                            ParamType.DocumentReference,
                          ),
                          'applicationRef': serializeParam(
                notification.applicationRef,
                            ParamType.DocumentReference,
                          ),
                          'jobRef': serializeParam(
                notification.relatedJob,
                            ParamType.DocumentReference,
                          ),
                        }.withoutNulls,
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
          color: Colors.white,
                      boxShadow: [
                        BoxShadow(
              blurRadius: 8.0,
              color: Color(0x0A000000),
              offset: Offset(0.0, 4.0),
              spreadRadius: 2.0,
                        )
                      ],
          borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
            color: FlutterFlowTheme.of(context).alternate.withOpacity(0.1),
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
          padding: EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                    width: 56.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: _getNotificationIconColor(
                          context,
                          notification.notificationType).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        _getNotificationIcon(notification.notificationType),
                        color: _getNotificationIconColor(
                            context,
                            notification.notificationType),
                        size: 28.0,
                      ),
                    ),
                  ),
                  if (notification.timestamp! >
                      currentUserDocument!.notificationsLastSeenTime!)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                            decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                            color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            ),
                          ),
                ],
              ),
              SizedBox(width: 16),
                          Expanded(
                              child: Column(
                  mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                    Text(
                      notification.notificationTitle,
                      style: FlutterFlowTheme.of(context)
                          .titleMedium
                          .override(
                                                fontFamily: 'Montserrat',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text(
                      translatedContent,
                      style: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context)
                                .secondaryText,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                            lineHeight: 1.4,
                                    ),
                                  ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: FlutterFlowTheme.of(context)
                              .secondaryText.withOpacity(0.6),
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          _formatRelativeTime(notification.timestamp!),
                          style: FlutterFlowTheme.of(context)
                              .labelSmall
                              .override(
                                            fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context)
                                    .secondaryText.withOpacity(0.6),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getNotificationIconColor(
                                context,
                                notification.notificationType).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _getNotificationTypeText(notification.notificationType),
                                style: FlutterFlowTheme.of(context)
                                .labelSmall
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: _getNotificationIconColor(
                                          context,
                                      notification.notificationType),
                                      fontSize: 12.0,
                                  letterSpacing: 0.0,
                                    ),
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

  String _getNotificationTypeText(String notificationType) {
    switch (notificationType) {
      case '截止通知':
        return '截止通知';
      case '職位通知':
        return '職位通知';
      case '申請通知':
        return '申請通知';
      case '入選通知':
        return '入選通知';
      case '一般通知':
        return '一般通知';
      default:
        return '通知';
    }
  }

  Color _getNotificationIconColor(
      BuildContext context, String notificationType) {
    switch (notificationType) {
      case 'Shortlisted':
        return Color(0xFFE91E63); // Pink
      case 'Job':
        return Color(0xFF2196F3); // Blue
      case 'Application':
        return Color(0xFF4CAF50); // Green
          case 'Deadline':
        return Color(0xFFFF9800); // Orange
      case 'General':
        return Color(0xFF9C27B0); // Purple
          default:
            return FlutterFlowTheme.of(context).primary;
        }
  }

  IconData _getNotificationIcon(String notificationType) {
    switch (notificationType) {
      case '截止通知':
        return Icons.timer;
      case '職位通知':
        return Icons.work;
      case '申請通知':
        return Icons.description;
      case '入選通知':
        return Icons.star;
      case '一般通知':
        return Icons.notifications;
      default:
        return Icons.notifications;
    }
  }

  String _formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} 天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} 小時前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} 分鐘前';
    } else {
      return '剛剛';
    }
  }
}
