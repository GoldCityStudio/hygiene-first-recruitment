import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'calendar_model.dart';
import 'dart:async' show StreamGroup;
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/check_ins_record.dart';
export 'calendar_model.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  static String routeName = 'calendar';
  static String routePath = 'calendar';

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late CalendarModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<CalendarEventsRecord>> _events = {};
  Map<DateTime, List<ApplicationsRecord>> _hiredJobs = {};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarModel());
    _selectedDay = _focusedDay;
    _loadEvents();
    _loadHiredJobs();

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'calendar'});
  }

  void _loadEvents() {
    print('Loading events...');
    final creatorQuery = CalendarEventsRecord.collection
        .where('created_by', isEqualTo: currentUserReference)
        .snapshots();
    
    final applicantQuery = CalendarEventsRecord.collection
        .where('applicant_ref', isEqualTo: currentUserReference)
        .snapshots();
    
    Rx.combineLatest2<QuerySnapshot, QuerySnapshot, List<QuerySnapshot>>(
      creatorQuery,
      applicantQuery,
      (creator, applicant) => [creator, applicant],
    ).listen((snapshots) {
      print('Received ${snapshots.length} snapshots');
      final newEvents = <DateTime, List<CalendarEventsRecord>>{};
      
      for (final snapshot in snapshots) {
        for (final doc in snapshot.docs) {
          final event = CalendarEventsRecord.fromSnapshot(doc);
          if (event.startTime == null) {
            print('Skipping event with null start time: ${event.reference.path}');
            continue;
          }
          
          final eventDate = DateTime(
            event.startTime!.year,
            event.startTime!.month,
            event.startTime!.day,
          );
          
          newEvents.putIfAbsent(eventDate, () => []).add(event);
          print('Added event for date: $eventDate');
        }
      }
      
      setState(() {
        _events = newEvents;
        print('Updated events: ${_events.length} dates with events');
      });
    });
  }

  void _loadHiredJobs() {
    print('Loading hired jobs...');
    ApplicationsRecord.collection
        .where('applicant_ref', isEqualTo: currentUserReference)
        .where('status', isEqualTo: 'Accepted')
        .snapshots()
        .listen((snapshot) async {
      print('Received ${snapshot.docs.length} hired jobs');
      final newHiredJobs = <DateTime, List<ApplicationsRecord>>{};
      
      for (final doc in snapshot.docs) {
        final application = ApplicationsRecord.fromSnapshot(doc);
        if (application.jobRef == null) {
          print('Skipping application with null job ref: ${application.reference.path}');
          continue;
        }
        
        try {
          final jobDoc = await application.jobRef!.get();
          if (!jobDoc.exists) {
            print('Skipping application with non-existent job: ${application.jobRef!.path}');
            continue;
          }
          
          final job = JobsRecord.fromSnapshot(jobDoc);
          if (job.startDate == null) {
            print('Skipping job with null start date: ${job.reference.path}');
            continue;
          }
          
          // Get the date range between start and end date (or current date if end date is null)
          final endDate = job.endDate ?? DateTime.now().add(Duration(days: 365));
          final startDate = job.startDate!;
          
          // Add the job to each day in the employment period
          for (var date = DateTime(startDate.year, startDate.month, startDate.day);
               date.isBefore(DateTime(endDate.year, endDate.month, endDate.day).add(Duration(days: 1)));
               date = date.add(Duration(days: 1))) {
            final workDate = DateTime(date.year, date.month, date.day);
          newHiredJobs.putIfAbsent(workDate, () => []).add(application);
          }
          
          print('Added hired job from ${startDate} to ${endDate}');
        } catch (e) {
          print('Error loading job for application ${application.reference.path}: $e');
        }
      }
      
      setState(() {
        _hiredJobs = newHiredJobs;
        print('Updated hired jobs: ${_hiredJobs.length} dates with hired jobs');
      });
    });
  }

  List<CalendarEventsRecord> _getEventsForDay(DateTime day) {
    final events = _events[DateTime(day.year, day.month, day.day)] ?? [];
    return events;
  }

  List<ApplicationsRecord> _getHiredJobsForDay(DateTime day) {
    return _hiredJobs[DateTime(day.year, day.month, day.day)] ?? [];
  }

  bool _hasHiredJobForDay(DateTime day) {
    final hiredJobs = _hiredJobs[DateTime(day.year, day.month, day.day)] ?? [];
    return hiredJobs.isNotEmpty;
  }

  List<ApplicationsRecord> _getWorkDatesForDay(DateTime day) {
    return _hiredJobs[DateTime(day.year, day.month, day.day)] ?? [];
  }

  bool _hasWorkDateForDay(DateTime day) {
    final workDates = _getWorkDatesForDay(day);
    return workDates.isNotEmpty;
  }

  void _showJobDetailsDialog(ApplicationsRecord application, JobsRecord job) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('工作詳情'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '職位: ${job.position}',
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily: 'Montserrat',
                      letterSpacing: 0.0,
                    ),
              ),
              SizedBox(height: 12.0),
              Text(
                '公司: ${job.companyName}',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      letterSpacing: 0.0,
                    ),
              ),
              SizedBox(height: 8.0),
              Text(
                '地點: ${job.location}',
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
              SizedBox(height: 8.0),
              Text(
                '工作類型: ${job.type}',
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
              SizedBox(height: 8.0),
              if (job.salaryMinimum != null && job.salaryMaximum != null)
              Text(
                  '薪資範圍: \$${job.salaryMinimum} - \$${job.salaryMaximum}',
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              Divider(height: 24.0),
              Text(
                '申請狀態',
                style: FlutterFlowTheme.of(context).titleSmall,
              ),
              SizedBox(height: 8.0),
              Text(
                '申請日期: ${DateFormat('yyyy-MM-dd').format(application.timeCreated!)}',
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: _getStatusColor(application.status),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      application.status ?? '待處理',
                      style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                            color: Colors.white,
                    ),
                    ),
                  ),
                ],
              ),
              if (job.startDate != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                SizedBox(height: 16.0),
                Text(
                      '工作時間',
                      style: FlutterFlowTheme.of(context).titleSmall,
                ),
                    SizedBox(height: 8.0),
                    Text(
                      '開始日期: ${DateFormat('yyyy-MM-dd').format(job.startDate!)}',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                    if (job.endDate != null)
                Text(
                        '結束日期: ${DateFormat('yyyy-MM-dd').format(job.endDate!)}',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    if (job.workingHours != null)
                      Text(
                        '工作時數: ${job.workingHours}',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ],
                ),
              SizedBox(height: 24.0),
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('check_ins')
                    .where('application_ref', isEqualTo: application.reference)
                    .where('check_in_time', isGreaterThanOrEqualTo: DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                    ))
                    .where('check_in_time', isLessThan: DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                    ).add(Duration(days: 1)))
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  
                  final docs = snapshot.data?.docs ?? [];
                  final hasCheckedIn = docs.isNotEmpty;
                  final checkInDoc = hasCheckedIn ? docs.first : null;
                  final checkIn = hasCheckedIn ? CheckInsRecord.fromSnapshot(checkInDoc!) : null;
                  final hasCheckedOut = checkIn?.hasCheckOutTime() ?? false;
                  final isLateCheckIn = checkIn?.status == 'late_check_in';
                  final isEarlyCheckOut = checkIn?.status == 'early_checkout_pending';
                  
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '今日打卡狀態',
                        style: FlutterFlowTheme.of(context).titleSmall,
                      ),
                      SizedBox(height: 8.0),
                      if (hasCheckedIn) ...[
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                            SizedBox(width: 8),
                            Text(
                              '簽到時間: ${DateFormat('HH:mm').format(checkIn!.checkInTime!)}',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                            if (isLateCheckIn && checkIn?.hasLateReason() == true) ...[
                              SizedBox(width: 8),
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.red.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.warning_amber_rounded,
                                          size: 16,
                                          color: Colors.red,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '遲到原因',
                                          style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      checkIn?.lateReason ?? '',
                                      style: FlutterFlowTheme.of(context).bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (hasCheckedOut) ...[
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.logout,
                                size: 16,
                                color: FlutterFlowTheme.of(context).secondaryText,
                              ),
                              SizedBox(width: 8),
                              Text(
                                '簽退時間: ${DateFormat('HH:mm').format(checkIn.checkOutTime!)}',
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                            ],
                          ),
                        ],
                        if (isEarlyCheckOut && checkIn?.hasEarlyCheckoutReason() == true) ...[
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.purple.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.purple.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.timer_off,
                                      size: 16,
                                      color: Colors.purple,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        '提前簽退申請理由',
                                        style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.purple.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '審核中',
                                        style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                          color: Colors.purple,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                      ),
                ),
              ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  checkIn?.earlyCheckoutReason ?? '',
                                  style: FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ] else ...[
                        Text(
                          '今日尚未打卡',
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text('關閉'),
          ),
          TextButton(
            onPressed: () {
              context.pop();
              context.pushNamed(
                'jobDetails',
                queryParameters: {
                  'jobPostDetails': serializeParam(
                    job.reference,
                    ParamType.DocumentReference,
                  ),
                }.withoutNulls,
                extra: <String, dynamic>{
                  kTransitionInfoKey: TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.rightToLeft,
                  ),
                },
              );
            },
            child: Text('查看完整資料'),
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

  Color _getJobTypeColor(String? jobType) {
    switch (jobType?.toLowerCase()) {
      case 'full-time':
        return Color(0xFF4CAF50); // Green
      case 'part-time':
        return Color(0xFF2196F3); // Blue
      case 'temporary':
        return Color(0xFFFFA726); // Orange
      case 'contract':
        return Color(0xFF9C27B0); // Purple
      case 'internship':
        return Color(0xFF00BCD4); // Cyan
      default:
        return Color(0xFF757575); // Grey
    }
  }

  Widget _buildEventMarker(CalendarEventsRecord event, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.5),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  Widget _buildHiredJobMarker(ApplicationsRecord application) {
    return FutureBuilder<DocumentSnapshot>(
      future: application.jobRef?.get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Container();
        }

        final job = JobsRecord.fromSnapshot(snapshot.data!);
        final isStartDate = job.startDate != null && 
          isSameDay(_selectedDay!, job.startDate!);
        final isEndDate = job.endDate != null && 
          isSameDay(_selectedDay!, job.endDate!);

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 1.5),
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isStartDate || isEndDate
                ? _getStatusColor(application.status)
                : _getStatusColor(application.status).withOpacity(0.5),
            border: isStartDate || isEndDate
                ? Border.all(color: Colors.white, width: 1.5)
                : null,
          ),
        );
      },
    );
  }

  Future<void> _handleCheckIn(ApplicationsRecord application, JobsRecord job) async {
    try {
      // Get current time and date
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      
      // Check if it's the correct date
      final jobStartDate = job.startDate!;
      final jobDate = DateTime(jobStartDate.year, jobStartDate.month, jobStartDate.day);
      
      // Check if we're within the job date range
      if (job.endDate != null) {
        final jobEndDate = job.endDate!;
        final jobEndDateTime = DateTime(jobEndDate.year, jobEndDate.month, jobEndDate.day, 23, 59, 59);
        if (now.isAfter(jobEndDateTime)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('工作已結束，無法打卡'),
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }
      }
      
      // Get working hours and construct the start time for today
      final workingHours = int.tryParse(job.workingHours ?? '8') ?? 8;
      final startHour = 9; // Default start time is 9:00 AM if not specified
      final jobStartTime = DateTime(
        today.year, 
        today.month, 
        today.day, 
        startHour, 
        0, // Start at the beginning of the hour
      );
      
      // Calculate allowed check-in time (30 minutes before start time)
      final earliestCheckInTime = jobStartTime.subtract(Duration(minutes: 30));
      
      // Verify if it's too early to check in
      if (now.isBefore(earliestCheckInTime)) {
        final minutesEarly = earliestCheckInTime.difference(now).inMinutes;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('請在 $minutesEarly 分鐘後打卡（開始時間前 30 分鐘）'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }
      
      // Check if already checked in today
      final todayStart = DateTime(today.year, today.month, today.day);
      final todayEnd = todayStart.add(Duration(days: 1));

      final existingCheckIn = await FirebaseFirestore.instance
          .collection('check_ins')
          .where('application_ref', isEqualTo: application.reference)
          .where('check_in_time', isGreaterThanOrEqualTo: todayStart)
          .where('check_in_time', isLessThan: todayEnd)
          .get();

      if (existingCheckIn.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('您今天已經打卡了'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      // Check if employee is late (after the start time)
      final isLate = now.isAfter(jobStartTime);
      
      // If late, prompt for reason
      if (isLate) {
        _showLateCheckInDialog(application, job);
        return;
      }

      // Normal check-in (on time)
      await _performCheckIn(application, job);
    } catch (e) {
      print('Error during check-in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('打卡失敗，請稍後再試'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  
  void _showLateCheckInDialog(ApplicationsRecord application, JobsRecord job) {
    final reasonController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded, 
              color: Colors.orange,
              size: 28,
            ),
            SizedBox(width: 12),
            Text(
              '遲到打卡說明',
              style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '您正在進行遲到打卡。為了維護良好的考勤記錄，請提供遲到理由：',
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.orange.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.orange,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '工作開始時間: ${DateFormat('HH:mm').format(DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          9, // Default start hour
                          0,
                        ))}',
                        style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: reasonController,
                decoration: InputDecoration(
                  hintText: '請輸入遲到理由',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryText.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                maxLines: 3,
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              '取消',
              style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: Colors.grey,
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              if (reasonController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('請提供遲到理由'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              
              Navigator.pop(context);
              await _performCheckIn(application, job, isLate: true, reason: reasonController.text);
            },
            icon: Icon(Icons.login),
            label: Text('提交並打卡'),
            style: ElevatedButton.styleFrom(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
        actionsPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      ),
    );
  }
  
  Future<void> _performCheckIn(
    ApplicationsRecord application, 
    JobsRecord job, 
    {bool isLate = false, 
    String reason = ''}
  ) async {
    try {
      // Create new check-in record
      final checkInData = {
        'application_ref': application.reference,
        'user_ref': currentUserReference,
        'job_ref': job.reference,
        'employee_ref': currentUserReference,
        'check_in_time': DateTime.now(),
        'status': isLate ? 'late_check_in' : 'checked_in',
        'company_ref': job.companyRef,
      };
      
      if (isLate && reason.isNotEmpty) {
        checkInData['late_reason'] = reason;
      }
      
      await FirebaseFirestore.instance.collection('check_ins').add(checkInData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isLate ? '遲到打卡已記錄' : '打卡成功'),
          duration: Duration(seconds: 2),
        ),
      );
      
      setState(() {}); // Refresh UI
    } catch (e) {
      print('Error during check-in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('打卡失敗，請稍後再試'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _handleCheckOut(ApplicationsRecord application, JobsRecord job, DocumentReference checkInRef) async {
    try {
      // Get current time and date
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      // Get working hours and construct the end time for today
      final workingHours = int.tryParse(job.workingHours ?? '8') ?? 8;
      final startHour = 9; // Default start time is 9:00 AM if not specified
      final endHour = startHour + workingHours;
      
      final jobEndTime = DateTime(
        today.year, 
        today.month, 
        today.day, 
        endHour, 
        0, // End at the end of the hour
      );
      
      // If trying to check out before the end of the work day, show early check-out dialog
      if (now.isBefore(jobEndTime)) {
        _showEarlyCheckOutDialog(application, job, checkInRef);
        return;
      }
      
      // Normal check-out (after work hours)
      await _performCheckOut(checkInRef);
    } catch (e) {
      print('Error during check-out: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('簽退失敗，請稍後再試'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  
  void _showEarlyCheckOutDialog(ApplicationsRecord application, JobsRecord job, DocumentReference checkInRef) {
    final reasonController = TextEditingController();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final workingHours = int.tryParse(job.workingHours ?? '8') ?? 8;
    final startHour = 9; // Default start time is 9:00 AM if not specified
    final endHour = startHour + workingHours;
    final endTime = DateTime(today.year, today.month, today.day, endHour, 0);
    final minutesEarly = endTime.difference(now).inMinutes;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.timer_off, 
              color: Colors.purple,
              size: 28,
            ),
            SizedBox(width: 12),
            Text(
              '提前簽退申請',
              style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '您正在申請提前簽退（比預定時間早 $minutesEarly 分鐘）。請提供理由，主管將審核您的申請：',
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.purple.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.purple,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '當前時間: ${DateFormat('HH:mm').format(now)}',
                            style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.purple,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '預定下班時間: ${DateFormat('HH:mm').format(endTime)}',
                            style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                '提前簽退理由：',
                style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: reasonController,
                decoration: InputDecoration(
                  hintText: '請輸入提前簽退理由',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryText.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                maxLines: 3,
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              '取消',
              style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: Colors.grey,
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              if (reasonController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('請提供提前簽退理由'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              
              Navigator.pop(context);
              await _performCheckOut(checkInRef, isEarly: true, reason: reasonController.text);
            },
            icon: Icon(Icons.send),
            label: Text('提交申請'),
            style: ElevatedButton.styleFrom(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
        actionsPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      ),
    );
  }
  
  Future<void> _performCheckOut(DocumentReference checkInRef, {bool isEarly = false, String reason = ''}) async {
    try {
      final updateData = {
        'check_out_time': DateTime.now(),
        'status': isEarly ? 'early_checkout_pending' : 'checked_out',
      };
      
      if (isEarly && reason.isNotEmpty) {
        updateData['early_checkout_reason'] = reason;
      }
      
      // Update check-in record with check-out time
      await checkInRef.update(updateData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isEarly ? '提前簽退申請已提交，等待審核' : '簽退成功'),
          duration: Duration(seconds: 2),
        ),
      );
      
      // Refresh the state
      setState(() {});
    } catch (e) {
      print('Error during check-out: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('簽退失敗，請稍後再試'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<bool> _isCheckedInToday(ApplicationsRecord application) async {
    try {
      final today = DateTime.now();
      final todayStart = DateTime(today.year, today.month, today.day);
      final todayEnd = todayStart.add(Duration(days: 1));

      final checkIn = await FirebaseFirestore.instance
          .collection('check_ins')
          .where('application_ref', isEqualTo: application.reference)
          .where('check_in_time', isGreaterThanOrEqualTo: todayStart)
          .where('check_in_time', isLessThan: todayEnd)
          .get();

      return checkIn.docs.isNotEmpty;
    } catch (e) {
      print('Error checking check-in status: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> _getCheckInStatus(ApplicationsRecord application) async {
    try {
      final today = DateTime.now();
      final todayStart = DateTime(today.year, today.month, today.day);
      final todayEnd = todayStart.add(Duration(days: 1));

      final checkInQuery = await FirebaseFirestore.instance
          .collection('check_ins')
          .where('application_ref', isEqualTo: application.reference)
          .where('check_in_time', isGreaterThanOrEqualTo: todayStart)
          .where('check_in_time', isLessThan: todayEnd)
          .get();

      if (checkInQuery.docs.isEmpty) {
        return {
          'checked_in': false,
          'checked_out': false,
        };
      }

      final checkInDoc = checkInQuery.docs.first;
      final checkIn = CheckInsRecord.fromSnapshot(checkInDoc);
      
      return {
        'checked_in': true,
        'checked_out': checkIn.hasCheckOutTime(),
        'check_in_doc': checkInDoc,
        'status': checkIn.status,
      };
    } catch (e) {
      print('Error checking check-in status: $e');
      return {
        'checked_in': false,
        'checked_out': false,
      };
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '行事曆',
              style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                  color: FlutterFlowTheme.of(context).primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () => context.pushNamed('calendarSettings'),
              child: Text(
                '設定',
                style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                  color: FlutterFlowTheme.of(context).primary,
                ),
              ),
            ),
                  ],
                ),
        actions: [
          _buildNotificationButton(),
          _buildProfileButton(),
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              _buildCalendarSection(),
              SizedBox(height: 24),
              _buildEventsSection(),
              SizedBox(height: 24),
              _buildHiredJobsSection(),
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

  Widget _buildProfileButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: FlutterFlowTheme.of(context).primary,
        child: Text(
          currentUserDisplayName.isNotEmpty 
              ? currentUserDisplayName.substring(0, 1).toUpperCase() 
              : 'U',
          style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                color: Colors.white,
                  ),
                ),
              ),
    );
  }

  Widget _buildCalendarSection() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
                  ],
                ),
                  child: Column(
                    children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left, size: 28),
                      onPressed: () {
                        setState(() {
                          _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                    SizedBox(width: 16),
                    Text(
                      DateFormat('MMMM yyyy').format(_focusedDay),
                      style: FlutterFlowTheme.of(context).headlineSmall.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(width: 16),
                    IconButton(
                      icon: Icon(Icons.chevron_right, size: 28),
                      onPressed: () {
                        setState(() {
                          _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
                      Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '2 weeks',
                    style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                      color: Colors.black87,
                    ),
                          ),
                        ),
              ],
            ),
          ),
          
                            TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                              focusedDay: _focusedDay,
                              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat: CalendarFormat.month,
                  startingDayOfWeek: StartingDayOfWeek.monday,
            headerVisible: false,
            daysOfWeekHeight: 40,
            rowHeight: 60,
            eventLoader: (day) {
              final events = _getEventsForDay(day);
              final hiredJobs = _getHiredJobsForDay(day);
              return [...events, ...hiredJobs];
            },
                              onDaySelected: (selectedDay, focusedDay) {
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                });
                              },
                  calendarStyle: CalendarStyle(
              markersMaxCount: 2,
              markerSize: 8,
                                markerDecoration: BoxDecoration(
                color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                todayDecoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                todayTextStyle: TextStyle(
                color: FlutterFlowTheme.of(context).primary,
                                  fontWeight: FontWeight.bold,
                                ),
              selectedDecoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
                                  shape: BoxShape.circle,
                                ),
              defaultTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                                ),
              weekendTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                                ),
              outsideTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black26,
                                ),
              cellMargin: EdgeInsets.all(4),
              cellPadding: EdgeInsets.zero,
                                ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                                ),
              weekendStyle: TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                                ),
                              ),
                              calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isEmpty) return null;
                
                final List<Widget> markers = [];
                int jobCount = 0;
                int eventCount = 0;
                
                // First process job events to ensure they take priority
                for (final event in events) {
                  if (event is ApplicationsRecord && jobCount < 2) {
                    markers.add(
                      FutureBuilder<DocumentSnapshot>(
                        future: event.jobRef?.get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || !snapshot.data!.exists) {
                            return Container(width: 0, height: 0);
                          }
                          
                          final job = JobsRecord.fromSnapshot(snapshot.data!);
                                  return Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.symmetric(horizontal: 1),
                                    decoration: BoxDecoration(
                              color: _getJobTypeColor(job.type),
                                      shape: BoxShape.circle,
                            ),
                          );
                        },
                      ),
                    );
                    jobCount++;
                  }
                }
                
                // Then process calendar events if there's still space
                if (jobCount < 2) {
                  for (final event in events) {
                    if (event is CalendarEventsRecord && eventCount < (2 - jobCount)) {
                      markers.add(
                        Container(
                          width: 8,
                          height: 8,
                          margin: EdgeInsets.symmetric(horizontal: 1),
                                              decoration: BoxDecoration(
                            color: Color(event.color),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                      );
                      eventCount++;
                    }
                  }
                }
                
                if (markers.isEmpty) return null;
                
                return Positioned(
                  bottom: 6,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: markers,
                                    ),
                                  );
                                },
              selectedBuilder: (context, date, _) {
                final isToday = isSameDay(date, DateTime.now());
                return Container(
                  margin: EdgeInsets.all(4),
                  alignment: Alignment.center,
                                    decoration: BoxDecoration(
                    color: isToday ? Colors.white : FlutterFlowTheme.of(context).primary,
                    shape: BoxShape.circle,
                    border: isToday ? Border.all(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 2,
                    ) : null,
                  ),
                  child: Text(
                    '${date.day}',
                    style: TextStyle(
                      color: isToday ? FlutterFlowTheme.of(context).primary : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                                          ),
                  ),
                );
              },
              todayBuilder: (context, date, _) {
                return Container(
                  margin: EdgeInsets.all(4),
                  alignment: Alignment.center,
                                              decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                  child: Text(
                    '${date.day}',
                    style: TextStyle(
                      color: FlutterFlowTheme.of(context).primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '即將到來',
                style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                                            color: FlutterFlowTheme.of(context).primary,
                  fontWeight: FontWeight.w600,
                                          ),
                                        ),
              TextButton(
                onPressed: () => context.pushNamed('upcomingEvents'),
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
          ..._getEventsForDay(_selectedDay!).map((event) => _buildEventCard(event)),
        ],
      ),
    );
  }

  Widget _buildEventCard(CalendarEventsRecord event) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 8.0),
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
                                  child: ListTile(
                                    title: Text(event.title),
                                    subtitle: Text(event.description),
                                    leading: Container(
                                      width: 4.0,
                                      decoration: BoxDecoration(
                                        color: Color(event.color),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                    ),
                                    trailing: Text(
                                      '${DateFormat('HH:mm').format(event.startTime!)} - ${DateFormat('HH:mm').format(event.endTime!)}',
                                      style: FlutterFlowTheme.of(context).bodySmall,
                                    ),
                                  ),
                                );
  }

  Widget _buildHiredJobsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '已排程',
                style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                  color: FlutterFlowTheme.of(context).primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () => context.pushNamed('scheduledEvents'),
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
          ..._getHiredJobsForDay(_selectedDay!).map((job) => _buildHiredJobCard(job)),
        ],
      ),
    );
  }

  Widget _buildHiredJobCard(ApplicationsRecord application) {
    return FutureBuilder<DocumentSnapshot>(
      future: application.jobRef?.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container(
            margin: EdgeInsets.only(bottom: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
                                ),
                              );
                            }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return SizedBox();
        }

        final job = JobsRecord.fromSnapshot(snapshot.data!);
        final jobTypeColor = _getJobTypeColor(job.type);

                              return Container(
          margin: EdgeInsets.only(bottom: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: jobTypeColor.withOpacity(0.3),
              width: 1,
                    ),
          ),
          child: InkWell(
            onTap: () => _showJobDetailsDialog(application, job),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: jobTypeColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.work_outline,
                            color: jobTypeColor,
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
                              job.position ?? '職位未指定',
                              style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                            SizedBox(height: 4),
                                                  Text(
                              job.companyName ?? '公司未指定',
                              style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                color: FlutterFlowTheme.of(context).secondaryText,
                                                      ),
                                                    ),
                          ],
                                                  ),
                      ),
                                                  FutureBuilder<Map<String, dynamic>>(
                                                    future: _getCheckInStatus(application),
                                                    builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return SizedBox.shrink();
                          }
                          
                          final statusMap = snapshot.data ?? {'checked_in': false, 'checked_out': false};
                          final isCheckedIn = statusMap['checked_in'] ?? false;
                          final isCheckedOut = statusMap['checked_out'] ?? false;
                          final checkInDoc = statusMap['check_in_doc'];
                          final status = statusMap['status'];
                          final checkIn = isCheckedIn && checkInDoc != null 
                              ? CheckInsRecord.fromSnapshot(checkInDoc) 
                              : null;
                          final isEarlyCheckoutPending = status == 'early_checkout_pending';
                          final isLateCheckIn = status == 'late_check_in';
                          
                          // If already checked out or early checkout pending, show status only
                          if (isCheckedIn && isCheckedOut) {
                            return OutlinedButton.icon(
                              onPressed: null, // Disabled button
                              icon: Icon(
                                Icons.done_all,
                                size: 16,
                                color: Colors.green,
                              ),
                              label: Text(
                                '已完成',
                                style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.green,
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                minimumSize: Size(0, 28),
                                side: BorderSide(color: Colors.green),
                              ),
                            );
                          }
                          // Early checkout pending
                          else if (isCheckedIn && isEarlyCheckoutPending) {
                            return OutlinedButton.icon(
                              onPressed: null, // Disabled button
                              icon: Icon(
                                Icons.pending_actions,
                                size: 16,
                                color: Colors.purple,
                              ),
                              label: Text(
                                '提前簽退審核中',
                                style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w500,
                                              ),
                                            ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.purple,
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                minimumSize: Size(0, 28),
                                side: BorderSide(color: Colors.purple),
                              ),
                            );
                          }
                          // Late check-in
                          else if (isCheckedIn && isLateCheckIn) {
                            return Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.red, width: 1),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.warning_amber_rounded,
                                        size: 12,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 4),
                                                  Text(
                                        '遲到',
                                        style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                          color: Colors.red,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                OutlinedButton.icon(
                                  onPressed: () async {
                                    if (checkInDoc != null) {
                                      await _handleCheckOut(application, job, checkInDoc.reference);
                                      setState(() {});
                                    }
                                  },
                                  icon: Icon(
                                    Icons.logout,
                                    size: 16,
                                    color: Colors.blue,
                                  ),
                                  label: Text(
                                    '簽退',
                                    style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.blue,
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                    minimumSize: Size(0, 28),
                                    side: BorderSide(color: Colors.blue),
                                                      ),
                                                    ),
                              ],
                            );
                          }
                          // If checked in but not checked out
                          else if (isCheckedIn) {
                            return OutlinedButton.icon(
                              onPressed: () async {
                                if (checkInDoc != null) {
                                  await _handleCheckOut(application, job, checkInDoc.reference);
                                  setState(() {});
                                }
                              },
                              icon: Icon(
                                Icons.logout,
                                size: 16,
                                color: Colors.blue,
                              ),
                              label: Text(
                                '簽退',
                                style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.blue,
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                minimumSize: Size(0, 28),
                                side: BorderSide(color: Colors.blue),
                                                          ),
                            );
                          }
                          // Not checked in yet
                          else {
                            return OutlinedButton.icon(
                              onPressed: () async {
                                await _handleCheckIn(application, job);
                                setState(() {});
                                                    },
                              icon: Icon(
                                Icons.login,
                                size: 16,
                                color: Colors.orange,
                                            ),
                              label: Text(
                                '簽到',
                                style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.orange,
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                minimumSize: Size(0, 28),
                                side: BorderSide(color: Colors.orange),
                              ),
                            );
                          }
                          },
                        ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                job.location ?? '地點未指定',
                                style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                ),
                              ),
                            ),
                            if (job.workingHours != null) ...[
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: FlutterFlowTheme.of(context).secondaryText,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '${job.workingHours} 小時',
                                style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
              ),
            ],
            ),
        ),
      ),
        );
      },
    );
  }
} 