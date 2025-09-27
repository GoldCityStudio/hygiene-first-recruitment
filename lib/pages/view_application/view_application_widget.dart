import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_pdf_viewer.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'view_application_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewApplicationWidget extends StatefulWidget {
  const ViewApplicationWidget({
    super.key,
    required this.candidateDetails,
    required this.applicationRef,
    required this.jobRef,
  });

  final DocumentReference? candidateDetails;
  final DocumentReference? applicationRef;
  final DocumentReference? jobRef;

  static String routeName = 'viewApplication';
  static String routePath = 'viewApplication';

  @override
  State<ViewApplicationWidget> createState() => _ViewApplicationWidgetState();
}

class _ViewApplicationWidgetState extends State<ViewApplicationWidget> {
  late ViewApplicationModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewApplicationModel());
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      if (widget.candidateDetails == null || 
          widget.applicationRef == null || 
          widget.jobRef == null) {
        throw Exception('Missing required references');
      }

      final userDoc = await widget.candidateDetails!.get();
      if (!userDoc.exists) throw Exception('User not found');

      final appDoc = await widget.applicationRef!.get();
      if (!appDoc.exists) throw Exception('Application not found');

      final jobDoc = await widget.jobRef!.get();
      if (!jobDoc.exists) throw Exception('Job not found');

      final appData = appDoc.data() as Map<String, dynamic>;
      // Convert Timestamp to DateTime
      if (appData['time_created'] is Timestamp) {
        appData['time_created'] = (appData['time_created'] as Timestamp).toDate();
      }

      setState(() {
        _model.user = UsersRecord.fromSnapshot(userDoc);
        _model.application = ApplicationsRecord.fromSnapshot(appDoc);
        _model.job = JobsRecord.fromSnapshot(jobDoc);
        _model.isLoading = false;
      });
    } catch (e) {
      setState(() {
        _model.hasError = true;
        _model.errorMessage = e.toString();
        _model.isLoading = false;
      });
    }
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitFoldingCube(
            color: Color(0xFF2B4C7E),
                  size: 28.0,
                ),
          SizedBox(height: 16.0),
          Text(
            '載入申請詳情...',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Montserrat',
                  color: Color(0xFF2B4C7E),
                  letterSpacing: 0.0,
                ),
              ),
        ],
            ),
          );
        }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Color(0xFFE60000),
              size: 48.0,
            ),
            SizedBox(height: 16.0),
            Text(
              _model.errorMessage ?? '發生錯誤',
              style: FlutterFlowTheme.of(context).bodyLarge.override(
                    fontFamily: 'Montserrat',
                    color: Color(0xFF1A365D),
                    letterSpacing: 0.0,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.0),
            FFButtonWidget(
              onPressed: () => context.safePop(),
              text: '返回',
              options: FFButtonOptions(
                width: 130.0,
                height: 40.0,
                color: Color(0xFF2B4C7E),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Montserrat',
                  color: Colors.white,
                      letterSpacing: 0.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                                    child: Row(
                                      children: [
          Container(
                                            width: 80.0,
                                            height: 80.0,
                                            decoration: BoxDecoration(
              color: Color(0xFF2B4C7E),
                                              shape: BoxShape.circle,
                                            ),
                                            child: ClipRRect(
              borderRadius: BorderRadius.circular(40.0),
              child: _buildProfileImage(),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                  Text(
                    _model.user?.displayName ?? '',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily: 'Montserrat',
                          color: Color(0xFF1A365D),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                                                    children: [
                      Icon(
                                                          Icons.location_pin,
                        color: Color(0xFF2B4C7E),
                                                          size: 16.0,
                                                      ),
                                                      Text(
                        _model.user?.location ?? '',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF2B4C7E),
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                                                    ),
                                                  ],
                                                ),
            ),
          ),
        ],
                                                        ),
                                                      );
                                                    }

  Widget _buildProfileImage() {
    if (_model.user?.photoUrl?.isEmpty ?? true) {
      return Icon(
        Icons.person,
        color: FlutterFlowTheme.of(context).primaryBackground,
        size: 40.0,
      );
    }

    return CachedNetworkImage(
      imageUrl: _model.user!.photoUrl,
      width: 70.0,
      height: 70.0,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            FlutterFlowTheme.of(context).primary,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.error_outline,
        color: FlutterFlowTheme.of(context).error,
      ),
    );
  }

  Widget _buildApplicationDetails() {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
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
                                          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                  '申請職位',
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF2B4C7E),
                        letterSpacing: 0.0,
                      ),
                ),
                SizedBox(height: 4.0),
                Text(
                  _model.job?.position ?? '',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF1A365D),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: 16.0),
                Text(
                  '申請狀態',
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF2B4C7E),
                        letterSpacing: 0.0,
                      ),
                ),
                SizedBox(height: 4.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: _getStatusColor(_model.application?.status),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                                                                child: Text(
                    _model.application?.status ?? 'Pending',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                      color: Colors.white,
                          letterSpacing: 0.0,
                    ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
          ),
          if (_model.job?.requiresCoverLetter == true && 
              _model.application?.coverLetter?.isNotEmpty == true) ...[
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                    '求職信',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF2B4C7E),
                          letterSpacing: 0.0,
                        ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    _model.application!.coverLetter!,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF1A365D),
                          letterSpacing: 0.0,
                        ),
                                                            ),
                                                          ],
                                                        ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResumeViewer() {
    if (_model.application?.attachmentUrl == null ||
        _model.application!.attachmentUrl.isEmpty) {
      return const Center(
        child: Text(
          '未上傳履歷',
          style: TextStyle(
            color: Color(0xFF2B4C7E),
            fontFamily: 'Montserrat',
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
          Text(
                '履歷',
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF1A365D),
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
          ),
              FFButtonWidget(
                onPressed: () async {
                  final url = Uri.parse(_model.application!.attachmentUrl);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('無法開啟履歷連結'),
                      ),
                    );
                  }
                },
                text: '下載履歷',
                options: FFButtonOptions(
                  height: 40,
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: Color(0xFF2B4C7E),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        letterSpacing: 0.0,
                      ),
                  elevation: 3,
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 400,
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
                                                    child: FlutterFlowPdfViewer(
                networkPath: _model.application!.attachmentUrl,
                width: double.infinity,
                height: double.infinity,
                horizontalScroll: false,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
          if (currentUserReference == _model.job?.companyRef)
            Expanded(
              child: FFButtonWidget(
                                        onPressed: () async {
                  print('Accept button pressed');
                  print('Application Reference: ${_model.application?.reference.path}');
                  
                  if (_model.application == null) {
                    print('錯誤：找不到申請');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('錯誤：找不到申請'),
                        backgroundColor: FlutterFlowTheme.of(context).error,
                      ),
                    );
                    return;
                  }

                  try {
                    print('Updating application status to Accepted');
                    await _model.application!.reference.update({
                      'status': 'Accepted',
                      'time_updated': FieldValue.serverTimestamp(),
                    });
                    
                    print('Creating calendar event for accepted application');
                    await CalendarEventsRecord.collection.doc().set({
                      'title': 'Interview: ${_model.job?.position}',
                      'description': 'Interview with ${_model.user?.displayName} for ${_model.job?.position} position at ${_model.job?.companyName}',
                      'startTime': DateTime.now().add(Duration(days: 1)), // Default to tomorrow
                      'endTime': DateTime.now().add(Duration(days: 1, hours: 1)), // 1 hour duration
                      'isAllDay': false,
                      'recurring': false,
                      'color': FlutterFlowTheme.of(context).primary.value,
                      'createdBy': currentUserReference,
                      'companyRef': _model.job?.companyRef,
                      'applicationRef': _model.application?.reference,
                      'jobRef': _model.job?.reference,
                      'applicantRef': _model.application?.applicantRef,
                      'timeCreated': FieldValue.serverTimestamp(),
                    });
                    
                    print('Creating notification for applicant');
                    await NotificationsRecord.collection.doc().set({
                      'notificationType': '申請通知',
                      'applicationRef': _model.application?.reference,
                      'taggedCompanyRef': _model.job?.companyRef,
                      'relatedJob': _model.job?.reference,
                      'notificationTitle': '申請已接受',
                      'content': '您申請的${_model.job?.position}職位已被接受。',
                      'isRead': false,
                      'taggedUserRef': _model.application?.applicantRef,
                      'timeToLive': dateTimeFromSecondsSinceEpoch(functions.maximumDate()),
                      'timestamp': FieldValue.serverTimestamp(),
                      'recipient': [_model.application?.applicantRef?.id],
                    });

                    print('Sending push notification');
                                          triggerPushNotification(
                      notificationTitle: '申請已接受',
                      notificationText: '您申請的${_model.job?.position}職位已被接受。',
                      userRefs: [_model.application!.applicantRef!],
                                            initialPageName: 'viewApplication',
                                            parameterData: {
                        'candidateDetails': _model.application?.applicantRef,
                        'applicationRef': _model.application?.reference,
                        'jobRef': _model.job?.reference,
                      },
                    );

                    print('Showing success message');
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                        content: Text('申請已成功接受'),
                        backgroundColor: FlutterFlowTheme.of(context).success,
                      ),
                    );
                  } catch (e) {
                    print('Error accepting application: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to accept application. Please try again.'),
                        backgroundColor: FlutterFlowTheme.of(context).error,
                      ),
                    );
                  }
                },
                text: '接受',
                icon: Icon(
                  Icons.check_circle_outline,
                  size: 20.0,
                ),
                                        options: FFButtonOptions(
                                          width: 130.0,
                                          height: 40.0,
                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFF00D709),
                                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                fontFamily: 'Montserrat',
                                                color: Colors.white,
                        letterSpacing: 0.0,
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
          if (currentUserReference == _model.job?.companyRef)
            SizedBox(width: 16.0),
          if (currentUserReference == _model.job?.companyRef)
            Expanded(
              child: FFButtonWidget(
                                        onPressed: () async {
                  print('Reject button pressed');
                  print('Application Reference: ${_model.application?.reference.path}');
                  
                  if (_model.application == null) {
                    print('錯誤：申請為空');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('錯誤：申請為空'),
                        backgroundColor: FlutterFlowTheme.of(context).error,
                      ),
                    );
                    return;
                  }

                  try {
                    print('Updating application status to Rejected');
                    await _model.application!.reference.update({
                      'status': 'Rejected',
                      'time_updated': FieldValue.serverTimestamp(),
                    });
                    
                    print('Creating notification for applicant');
                    await NotificationsRecord.collection.doc().set({
                      'notificationType': '申請通知',
                      'applicationRef': _model.application?.reference,
                      'taggedCompanyRef': _model.job?.companyRef,
                      'relatedJob': _model.job?.reference,
                      'notificationTitle': '申請已拒絕',
                      'content': '您申請的${_model.job?.position}職位已被拒絕。',
                      'isRead': false,
                      'taggedUserRef': _model.application?.applicantRef,
                      'timeToLive': dateTimeFromSecondsSinceEpoch(functions.maximumDate()),
                      'timestamp': FieldValue.serverTimestamp(),
                      'recipient': [_model.application?.applicantRef?.id],
                    });

                    print('Sending push notification');
                                          triggerPushNotification(
                      notificationTitle: '申請已拒絕',
                      notificationText: '您申請的${_model.job?.position}職位已被拒絕。',
                      userRefs: [_model.application!.applicantRef!],
                                            initialPageName: 'viewApplication',
                                            parameterData: {
                        'candidateDetails': _model.application?.applicantRef,
                        'applicationRef': _model.application?.reference,
                        'jobRef': _model.job?.reference,
                      },
                    );

                    print('Showing success message');
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                        content: Text('申請已成功拒絕'),
                        backgroundColor: FlutterFlowTheme.of(context).error,
                      ),
                    );
                  } catch (e) {
                    print('Error rejecting application: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('無法拒絕申請，請稍後再試。'),
                                              backgroundColor: FlutterFlowTheme.of(context).error,
                                            ),
                                          );
                  }
                },
                text: '拒絕',
                icon: Icon(
                  Icons.cancel_outlined,
                  size: 20.0,
                ),
                                        options: FFButtonOptions(
                                          width: 130.0,
                                          height: 40.0,
                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFFE60000),
                                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                fontFamily: 'Montserrat',
                                                color: Colors.white,
                        letterSpacing: 0.0,
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
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
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
      appBar: AppBar(
        backgroundColor: Color(0xFF2B4C7E),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            color: Colors.white,
          ),
          onPressed: () => context.safePop(),
        ),
        title: Text(
          '申請詳情',
          style: FlutterFlowTheme.of(context).headlineSmall.override(
                fontFamily: 'Montserrat',
                color: Colors.white,
                letterSpacing: 0.0,
              ),
                            ),
                        elevation: 0.0,
      ),
      body: SafeArea(
        child: _model.isLoading
            ? _buildLoadingState()
            : _model.hasError
                ? _buildErrorState()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildProfileSection(),
                        _buildApplicationDetails(),
                        _buildResumeViewer(),
                        _buildActionButtons(context),
                      ],
                    ),
                  ),
      ),
    );
  }
}
