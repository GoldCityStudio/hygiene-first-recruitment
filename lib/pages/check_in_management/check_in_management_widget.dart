import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/form_field_controller.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/jobs_record.dart';
import '/backend/schema/applications_record.dart';
import '/backend/schema/check_ins_record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CheckInManagementWidget extends StatefulWidget {
  const CheckInManagementWidget({Key? key}) : super(key: key);

  static String get routeName => 'check_in_management';
  static String get routePath => 'check-in-management';

  @override
  _CheckInManagementWidgetState createState() => _CheckInManagementWidgetState();
}

class _CheckInManagementWidgetState extends State<CheckInManagementWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _searchQuery = '';
  String _selectedDepartment = '所有部門';
  String _selectedStatus = '所有狀態';
  bool _isGridView = false;
  
  // Add state variables for check-in management
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  String _selectedCheckInStatus = '全部狀態';
  String _selectedCheckInDepartment = '全部部門';
  Map<DateTime, List<Map<String, dynamic>>> _events = {};
  Map<DateTime, List<Map<String, dynamic>>> _employmentPeriods = {};
  
  final List<String> _departments = ['所有部門', '行政部', '人力資源部', '財務部', '營運部', 'IT部門'];
  final List<String> _statuses = ['所有狀態', '在職', '試用期', '已離職'];
  final List<String> _checkInStatuses = ['全部狀態', '待處理', '已批准', '已拒絕'];

  // Add the _isEmploymentDay method
  bool _isEmploymentDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    final periods = _employmentPeriods[normalizedDay] ?? [];
    return periods.any((period) => period['type'] == 'employment_period');
  }

  @override
  void initState() {
    super.initState();
    
    // Initialize calendar dates
    _selectedDay = DateTime.now();
    _focusedDay = _selectedDay;
    
    // Load initial events
    _loadEvents();
    
    // Print current user reference for debugging
    print('Current user reference: $currentUserReference');
    if (currentUserReference == null) {
      print('Warning: currentUserReference is null!');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF2B4C7E),
                Color(0xFF1A365D),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: true,
        title: Text(
          '打卡管理',
          style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
            color: Colors.white,
            fontSize: 22.0,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            color: Colors.white,
            onPressed: () => setState(() => _isGridView = !_isGridView),
            tooltip: _isGridView ? '列表檢視' : '網格檢視',
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            color: Colors.white,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('使用說明'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• 點擊右上角圖示可切換列表/網格檢視'),
                      Text('• 使用搜尋欄位尋找特定員工'),
                      Text('• 使用篩選器按部門或狀態篩選'),
                      Text('• 點擊員工卡片查看詳細資訊'),
                      Text('• 使用右下角按鈕新增員工'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('了解'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            },
            tooltip: '使用說明',
          ),
        ],
        elevation: 2,
      ),
      body: _buildCheckInRecords(),
    );
  }

  Widget _buildCheckInRecords() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0xFF2B4C7E).withOpacity(0.15),
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: FlutterFlowDropDown<String>(
                      controller: FormFieldController<String>(_selectedCheckInStatus),
                      options: _checkInStatuses,
                      onChanged: (val) => setState(() => _selectedCheckInStatus = val!),
                      width: double.infinity,
                      height: 50,
                      textStyle: FlutterFlowTheme.of(context).bodyMedium,
                      hintText: '選擇狀態',
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFF2B4C7E),
                        size: 24,
                      ),
                      fillColor: Colors.white,
                      elevation: 2,
                      borderColor: Color(0xFF2B4C7E).withOpacity(0.3),
                      borderWidth: 2,
                      borderRadius: 8,
                      margin: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                      hidesUnderline: true,
                      isSearchable: false,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: FlutterFlowDropDown<String>(
                      controller: FormFieldController<String>(_selectedCheckInDepartment),
                      options: ['全部部門', '行政部', '人力資源部', '財務部', '營運部', 'IT部門'],
                      onChanged: (val) => setState(() => _selectedCheckInDepartment = val!),
                      width: double.infinity,
                      height: 50,
                      textStyle: FlutterFlowTheme.of(context).bodyMedium,
                      hintText: '選擇部門',
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFF2B4C7E),
                        size: 24,
                      ),
                      fillColor: Colors.white,
                      elevation: 2,
                      borderColor: Color(0xFF2B4C7E).withOpacity(0.3),
                      borderWidth: 2,
                      borderRadius: 8,
                      margin: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                      hidesUnderline: true,
                      isSearchable: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildCalendar(),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('applications')
                .where('company_ref', isEqualTo: currentUserReference)
                .where('status', isEqualTo: 'Accepted')
                .snapshots(),
            builder: (context, employeeSnapshot) {
              if (employeeSnapshot.hasError) {
                return Center(child: Text('Error: ${employeeSnapshot.error}'));
              }

              if (!employeeSnapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final employees = employeeSnapshot.data!.docs;
              
              if (employees.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 64,
                        color: Color(0xFF2B4C7E).withOpacity(0.5),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '暫無員工資料',
                        style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                          color: Color(0xFF2B4C7E).withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return StreamBuilder<QuerySnapshot>(
                stream: (() {
                  final startOfDay = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
                  final endOfDay = startOfDay.add(Duration(days: 1));
                  
                  return FirebaseFirestore.instance
                      .collection('check_ins')
                      .where('company_ref', isEqualTo: currentUserReference)
                      .where('check_in_time', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
                      .where('check_in_time', isLessThan: Timestamp.fromDate(endOfDay))
                      .orderBy('check_in_time', descending: true)
                      .snapshots();
                })(),
                builder: (context, checkInSnapshot) {
                  if (checkInSnapshot.hasError) {
                    return Center(child: Text('Error: ${checkInSnapshot.error}'));
                  }

                  final checkIns = checkInSnapshot.hasData 
                      ? checkInSnapshot.data!.docs
                      : [];
                  
                  final Map<String, DocumentSnapshot> checkInMap = Map.fromEntries(
                    checkIns.map((doc) {
                      final checkIn = CheckInsRecord.fromSnapshot(doc);
                      return MapEntry(checkIn.employeeRef?.path ?? '', doc);
                    })
                  );

                  if (_isGridView) {
                    return GridView.builder(
                      padding: EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 3 : 
                                     MediaQuery.of(context).size.width > 800 ? 2 : 1,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: employees.length,
                      itemBuilder: (context, index) {
                        return _buildEmployeeCard(
                          employees[index],
                          checkInMap,
                          employeeSnapshot.data!.docs[index],
                        );
                      },
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: employees.length,
                    itemBuilder: (context, index) {
                      return _buildEmployeeCard(
                        employees[index],
                        checkInMap,
                        employeeSnapshot.data!.docs[index],
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmployeeCard(
    DocumentSnapshot employeeDoc,
    Map<String, DocumentSnapshot> checkInMap,
    DocumentSnapshot applicationDoc,
  ) {
    final application = ApplicationsRecord.fromSnapshot(applicationDoc);
                      final employeeRef = application.applicantRef;
                      final checkInDoc = checkInMap[employeeRef?.path];
                      final hasCheckedIn = checkInDoc != null;
                      
                      return FutureBuilder<DocumentSnapshot>(
                        future: employeeRef?.get(),
                        builder: (context, employeeDataSnapshot) {
                          if (!employeeDataSnapshot.hasData) {
                            return Card(
                              child: ListTile(
                                leading: CircularProgressIndicator(),
                                title: Text('載入中...'),
                              ),
                            );
                          }

                          final employeeData = employeeDataSnapshot.data!.data() as Map<String, dynamic>;
                          final employeeName = employeeData['displayName'] as String? ?? '未知';
                          
                          // Apply department filter if needed
                          if (_selectedCheckInDepartment != '全部部門' && 
                              employeeData['department'] != _selectedCheckInDepartment) {
                            return SizedBox.shrink();
                          }

                          // If there's a check-in, get its details
                          String status = 'pending';
                          DateTime? checkInTime;
                          DateTime? checkOutTime;
                          
                          if (hasCheckedIn) {
                            final checkIn = CheckInsRecord.fromSnapshot(checkInDoc!);
                            status = checkIn.status;
                            checkInTime = checkIn.checkInTime;
                            checkOutTime = checkIn.checkOutTime;
                          }

                          // Apply status filter
                          if (_selectedCheckInStatus != '全部狀態') {
                            String statusToCompare = '';
                            switch (_selectedCheckInStatus) {
                              case '待處理':
                                statusToCompare = 'pending';
                                break;
                              case '已批准':
                                statusToCompare = 'approved';
                                break;
                              case '已拒絕':
                                statusToCompare = 'rejected';
                                break;
                            }
                            if (status != statusToCompare) {
                              return SizedBox.shrink();
                            }
                          }

                          return FutureBuilder<DocumentSnapshot>(
                            future: application.jobRef?.get(),
                            builder: (context, jobSnapshot) {
                              if (!jobSnapshot.hasData) {
                                return Card(
                                  child: ListTile(
                                    leading: CircularProgressIndicator(),
                                    title: Text('載入中...'),
                                  ),
                                );
                              }

                              final jobData = jobSnapshot.data!.data() as Map<String, dynamic>;
                              final startDate = jobData['start_date'] as Timestamp?;
                              final endDate = jobData['end_date'] as Timestamp?;

                              return Card(
              margin: EdgeInsets.only(bottom: 16),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              shadowColor: Color(0xFF2B4C7E).withOpacity(0.25),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                  // Header section with employee info and status
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF2B4C7E).withOpacity(0.08),
                          Colors.white,
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                        // Avatar with border
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFF2B4C7E).withOpacity(0.3),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF2B4C7E).withOpacity(0.1),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 28,
                                            backgroundImage: employeeData['photo_url'] != null
                                                ? NetworkImage(employeeData['photo_url'])
                                                : null,
                                            child: employeeData['photo_url'] == null
                                ? Icon(Icons.person, size: 28)
                                                : null,
                                          ),
                        ),
                        SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  employeeName,
                                                  style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                                                    fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xFF1A365D),
                                                  ),
                                                ),
                              SizedBox(height: 4),
                                          Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xFF2B4C7E).withOpacity(0.15),
                                      Color(0xFF2B4C7E).withOpacity(0.08),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Color(0xFF2B4C7E).withOpacity(0.1),
                                    width: 1,
                                  ),
                                            ),
                                            child: Text(
                                  employeeData['department'] ?? '未指定部門',
                                              style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                    color: Color(0xFF1A365D),
                                    fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                              SizedBox(height: 4),
                                          Text(
                                application.position ?? '未指定職位',
                                style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                  color: Color(0xFF2B4C7E),
                                  fontWeight: FontWeight.w500,
                                ),
                                          ),
                                        ],
                                      ),
                        ),
                        // Status badge
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                _getStatusColor(status).withOpacity(0.2),
                                _getStatusColor(status).withOpacity(0.1),
                                          ],
                                        ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _getStatusColor(status).withOpacity(0.3),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: _getStatusColor(status).withOpacity(0.1),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                          child: Text(
                            hasCheckedIn ? _getStatusText(status) : '未打卡',
                            style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                              color: _getStatusColor(status),
                              fontWeight: FontWeight.w600,
                            ),
                  ),
                ),
              ],
            ),
                  ),
                  
                  // Divider
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFF2B4C7E).withOpacity(0.08),
                  ),
                  
                  // Check-in information section
                  Container(
              padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                        // Section title
                                          Text(
                          '打卡資訊',
                          style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                              fontWeight: FontWeight.bold,
                            color: Color(0xFF1A365D),
                                          ),
                        ),
                        SizedBox(height: 12),
                        
                        // Check-in time
                        _buildInfoRow(
                          icon: Icons.access_time,
                          label: '簽到時間',
                          value: hasCheckedIn && checkInTime != null 
                              ? DateFormat('HH:mm').format(checkInTime)
                              : '尚未打卡',
                          iconColor: hasCheckedIn ? Color(0xFF2E7D32) : Color(0xFF2B4C7E).withOpacity(0.7),
                                          ),
                        
                        // Check-out time (if available)
                        if (checkOutTime != null)
                          _buildInfoRow(
                            icon: Icons.logout,
                            label: '簽退時間',
                            value: DateFormat('HH:mm').format(checkOutTime),
                            iconColor: Color(0xFF1A365D).withOpacity(0.7),
                                          ),
                                        ],
                                      ),
                                    ),
                  
                  // Divider
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFF2B4C7E).withOpacity(0.08),
                  ),
                  
                  // Contact information section
                                    Container(
                    padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                      color: Colors.white,
                                      ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                        // Section title
                                    Text(
                          '聯絡資訊',
                          style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A365D),
                          ),
                                ),
                        SizedBox(height: 12),
                        
                        // Phone number (if available)
                        if (employeeData['phone_number'] != null)
                          _buildInfoRow(
                            icon: Icons.phone,
                            label: '電話',
                            value: employeeData['phone_number'],
                            iconColor: Color(0xFF1A365D).withOpacity(0.7),
                                    ),
                        
                        // Email (if available)
                        if (employeeData['email'] != null)
                          _buildInfoRow(
                            icon: Icons.email,
                            label: '電郵',
                            value: employeeData['email'],
                            iconColor: Color(0xFF1A365D).withOpacity(0.7),
                                    ),
                                  ],
                                ),
                  ),
                  
                  // Divider
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFF2B4C7E).withOpacity(0.08),
                  ),
                  
                  // Employment information section
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                        // Section title
                                      Text(
                          '工作資訊',
                          style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A365D),
                          ),
                        ),
                        SizedBox(height: 12),
                        
                        // Position
                        _buildInfoRow(
                          icon: Icons.work_outline,
                          label: '職位',
                          value: employeeData['position'] ?? '未指定職位',
                          iconColor: Color(0xFF1A365D).withOpacity(0.7),
                        ),
                        
                        // Start date
                        _buildInfoRow(
                          icon: Icons.calendar_today,
                          label: '入職日期',
                          value: startDate != null 
                              ? DateFormat('yyyy-MM-dd').format(startDate.toDate())
                              : '未指定',
                          iconColor: Color(0xFF1A365D).withOpacity(0.7),
                                    ),
                        
                        // End date (if available)
                        if (endDate != null)
                          _buildInfoRow(
                            icon: Icons.event_busy,
                            label: '離職日期',
                            value: DateFormat('yyyy-MM-dd').format(endDate.toDate()),
                            iconColor: Color(0xFF1A365D).withOpacity(0.7),
                          ),
                              ],
                            ),
                          ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCalendar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFF2B4C7E).withOpacity(0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF2B4C7E).withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            currentDay: DateTime.now(),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,
            rowHeight: 52,
            availableCalendarFormats: const {
              CalendarFormat.month: '月',
            },
            eventLoader: (day) {
              // Normalize the date to start of day for comparison
              final normalizedDay = DateTime(day.year, day.month, day.day);
              final events = _events[normalizedDay] ?? [];
              final periods = _employmentPeriods[normalizedDay] ?? [];
              return [...events, ...periods];
            },
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              weekendTextStyle: TextStyle(
                color: Color(0xFF2B4C7E).withOpacity(0.7),
              ),
              holidayTextStyle: TextStyle(
                color: Color(0xFF2B4C7E).withOpacity(0.7),
              ),
              selectedDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2B4C7E),
                    Color(0xFF1A365D),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF2B4C7E).withOpacity(0.3),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              todayDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2B4C7E).withOpacity(0.15),
                    Color(0xFF2B4C7E).withOpacity(0.05),
                  ],
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFF2B4C7E).withOpacity(0.3),
                  width: 1,
              ),
              ),
              defaultTextStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: Color(0xFF1A365D),
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              todayTextStyle: TextStyle(
                color: Color(0xFF1A365D),
                fontWeight: FontWeight.bold,
              ),
              outsideTextStyle: TextStyle(
                color: Color(0xFF1A365D).withOpacity(0.3),
              ),
            ),
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: FlutterFlowTheme.of(context).titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
              headerPadding: EdgeInsets.symmetric(vertical: 12),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 28,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 28,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2B4C7E),
                    Color(0xFF1A365D),
                  ],
                ),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A365D),
              ),
              weekendStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: Color(0xFF2B4C7E).withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                final isEmploymentDay = _isEmploymentDay(day);

                return Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isEmploymentDay ? Color(0xFF2B4C7E) : null,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                      color: isEmploymentDay ? Colors.white : null,
                    ),
                  ),
                );
              },
              selectedBuilder: (context, day, focusedDay) {
                return Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Color(0xFF2B4C7E),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
              todayBuilder: (context, day, focusedDay) {
                final isEmploymentDay = _isEmploymentDay(day);

                return Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isEmploymentDay ? Color(0xFF2B4C7E) : null,
                    border: Border.all(
                      color: Color(0xFF2B4C7E),
                      width: 1,
                    ),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                      color: isEmploymentDay ? Colors.white : Color(0xFF2B4C7E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
              markerBuilder: (context, date, events) {
                if (events.isEmpty) return null;

                final checkIns = events.where((e) => e is Map<String, dynamic> && e['type'] == 'check_in').length;
                final starts = events.where((e) => e is Map<String, dynamic> && e['type'] == 'start').length;
                final ends = events.where((e) => e is Map<String, dynamic> && e['type'] == 'end').length;

                return Positioned(
                  bottom: 4,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (checkIns > 0)
                        Container(
                          width: 6,
                          height: 6,
                          margin: EdgeInsets.only(right: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      if (starts > 0)
                        Container(
                          width: 6,
                          height: 6,
                          margin: EdgeInsets.only(right: 2),
                          decoration: BoxDecoration(
                            color: Color(0xFF2E7D32),
                            shape: BoxShape.circle,
                          ),
                        ),
                      if (ends > 0)
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Color(0xFFC62828),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          
          // Legend
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(
                  color: Color(0xFF2B4C7E),
                  label: '打卡記錄',
                  icon: Icons.circle,
                  size: 8,
                ),
                SizedBox(width: 16),
                _buildLegendItem(
                  color: Color(0xFF2E7D32),
                  label: '入職',
                  icon: Icons.circle,
                  size: 8,
                ),
                SizedBox(width: 16),
                _buildLegendItem(
                  color: Color(0xFFC62828),
                  label: '離職',
                  icon: Icons.circle,
                  size: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    required IconData icon,
    required double size,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: size,
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Color(0xFF2E7D32);
      case 'rejected':
        return Color(0xFFC62828);
      case 'pending':
        return Color(0xFFF57C00);
      default:
        return Color(0xFF616161);
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return '已批准';
      case 'rejected':
        return '已拒絕';
      case 'pending':
        return '待處理';
      default:
        return '未知';
    }
  }

  void _showEmployeeDetails(ApplicationsRecord application, Map<String, dynamic> userData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              height: 4,
              width: 40,
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryText.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '員工資料',
                    style: FlutterFlowTheme.of(context).headlineSmall,
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: userData['photo_url'] != null
                              ? NetworkImage(userData['photo_url'])
                              : null,
                          child: userData['photo_url'] == null
                              ? Icon(Icons.person, size: 40)
                              : null,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userData['displayName'] ?? '未知',
                                style: FlutterFlowTheme.of(context).titleLarge,
                              ),
                              Text(
                                application.position,
                                style: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    _buildDetailSection(
                      title: '基本資料',
                      children: [
                        _buildDetailItem('電話', userData['phone_number'] ?? '未提供'),
                        _buildDetailItem('電郵', userData['email'] ?? '未提供'),
                        _buildDetailItem('性別', userData['gender'] ?? '未提供'),
                        if (userData['date_of_birth'] != null)
                          _buildDetailItem(
                            '出生日期',
                            DateFormat('yyyy-MM-dd').format(
                              (userData['date_of_birth'] as Timestamp).toDate(),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 24),
                    _buildDetailSection(
                      title: '工作資料',
                      children: [
                        FutureBuilder<DocumentSnapshot>(
                          future: application.jobRef?.get(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text('載入中...');
                            }
                            final job = JobsRecord.fromSnapshot(snapshot.data!);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDetailItem('職位', job.position),
                                _buildDetailItem('部門', '未指定'),
                                _buildDetailItem(
                                  '入職日期',
                                  job.startDate != null
                                      ? DateFormat('yyyy-MM-dd').format(job.startDate!)
                                      : '未指定',
                                ),
                                _buildDetailItem(
                                  '合約到期',
                                  job.endDate != null
                                      ? DateFormat('yyyy-MM-dd').format(job.endDate!)
                                      : '無限期',
                                ),
                                _buildDetailItem('工作類型', job.type),
                                if (job.workingHours != null)
                                  _buildDetailItem('工作時間', job.workingHours!),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    _buildDetailSection(
                      title: '專業技能',
                      children: [
                        if (userData['skills'] != null)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: (userData['skills'] as List<dynamic>)
                                .map((skill) => Chip(
                                      label: Text(skill.toString()),
                                      backgroundColor: FlutterFlowTheme.of(context)
                                          .primary
                                          .withOpacity(0.1),
                                      labelStyle: TextStyle(
                                        color: FlutterFlowTheme.of(context).primary,
                                      ),
                                    ))
                                .toList(),
                          ),
                        if (userData['languages'] != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Text(
                                '語言能力',
                                style: FlutterFlowTheme.of(context).labelMedium,
                              ),
                              SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: (userData['languages'] as List<dynamic>)
                                    .map((lang) => Chip(
                                          label: Text(lang.toString()),
                                          backgroundColor: FlutterFlowTheme.of(context)
                                              .secondary
                                              .withOpacity(0.1),
                                          labelStyle: TextStyle(
                                            color: FlutterFlowTheme.of(context).secondary,
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            _showCheckInRecords(application);
                          },
                          icon: Icon(Icons.access_time),
                          label: Text('打卡記錄'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: FlutterFlowTheme.of(context).primary,
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('確認終止聘用'),
                                content: Text('確定要終止該員工的聘用嗎？'),
                                actions: [
                                  TextButton(
                                    child: Text('取消'),
                                    onPressed: () => Navigator.pop(context, false),
                                  ),
                                  TextButton(
                                    child: Text(
                                      '確定',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () => Navigator.pop(context, true),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              try {
                                await application.reference.update({
                                  'status': 'Terminated',
                                  'end_date': DateTime.now(),
                                });
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('已終止員工聘用'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } catch (e) {
                                print('Error terminating employee: $e');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('終止聘用失敗: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          icon: Icon(Icons.person_remove),
                          label: Text('終止聘用'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
      ),
    );
  }

  void _showCheckInRecords(ApplicationsRecord application) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              height: 4,
              width: 40,
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryText.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '打卡記錄',
                    style: FlutterFlowTheme.of(context).headlineSmall,
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('check_ins')
                    .where('employee_ref', isEqualTo: application.applicantRef)
                    .orderBy('check_in_time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final checkIns = snapshot.data!.docs;

                  if (checkIns.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 64,
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                          SizedBox(height: 16),
                          Text(
                            '暫無打卡記錄',
                            style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: checkIns.length,
                    itemBuilder: (context, index) {
                      final checkIn = CheckInsRecord.fromSnapshot(checkIns[index]);
                      final checkInTime = checkIn.checkInTime;
                      final checkOutTime = checkIn.checkOutTime;
                      final status = checkIn.status;

                      return Card(
                        margin: EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Icon(
                            Icons.access_time,
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                          title: Text(
                            DateFormat('yyyy-MM-dd').format(checkInTime!),
                            style: FlutterFlowTheme.of(context).titleMedium,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '簽到時間: ${DateFormat('HH:mm').format(checkInTime)}',
                              ),
                              if (checkOutTime != null)
                                Text(
                                  '簽退時間: ${DateFormat('HH:mm').format(checkOutTime)}',
                                ),
                            ],
                          ),
                          trailing: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _getStatusColor(status).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _getStatusText(status),
                              style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                color: _getStatusColor(status),
                              ),
                            ),
                          ),
                          onTap: () {
                            _showCheckInDetails(checkIn);
                          },
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
    );
  }

  void _showCheckInDetails(CheckInsRecord checkIn) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('打卡詳情'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('打卡時間: ${DateFormat('yyyy-MM-dd HH:mm').format(checkIn.checkInTime!)}'),
            if (checkIn.checkOutTime != null)
              Text('簽退時間: ${DateFormat('yyyy-MM-dd HH:mm').format(checkIn.checkOutTime!)}'),
            if (checkIn.location != null)
              Text('位置: ${checkIn.location!['address'] ?? '未知位置'}'),
            Text('狀態: ${checkIn.status}'),
            if (checkIn.notes != null && checkIn.notes.isNotEmpty)
              Text('備註: ${checkIn.notes}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('關閉'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: FlutterFlowTheme.of(context).titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _loadEvents() {
    // Debug print
    print('Loading events...');
    
    FirebaseFirestore.instance
        .collection('check_ins')
        .where('company_ref', isEqualTo: currentUserReference)
        .get()
        .then((checkInsSnapshot) {
      final events = <DateTime, List<Map<String, dynamic>>>{};
      
      for (var doc in checkInsSnapshot.docs) {
        final checkInData = doc.data();
        final timestamp = checkInData['check_in_time'] as Timestamp;
        // Normalize the date to start of day
        final date = DateTime(
          timestamp.toDate().year,
          timestamp.toDate().month,
          timestamp.toDate().day,
        );
        
        if (!events.containsKey(date)) {
          events[date] = [];
        }
        events[date]!.add({
          ...checkInData,
          'type': 'check_in',
        });
      }
      
      // Debug print
      print('Loaded ${events.length} days with events');
      events.forEach((date, dayEvents) {
        print('Date: $date, Events: ${dayEvents.length}');
      });
      
      setState(() {
        _events = events;
      });
    });

    FirebaseFirestore.instance
        .collection('applications')
        .where('company_ref', isEqualTo: currentUserReference)
        .where('status', isEqualTo: 'Accepted')
        .get()
        .then((applicationsSnapshot) {
      final periods = <DateTime, List<Map<String, dynamic>>>{};
      
      for (var doc in applicationsSnapshot.docs) {
        final application = ApplicationsRecord.fromSnapshot(doc);
        if (application.jobRef != null) {
          application.jobRef!.get().then((jobDoc) {
            final jobData = jobDoc.data() as Map<String, dynamic>;
            
            final startDate = jobData['start_date'] as Timestamp?;
            final endDate = jobData['end_date'] as Timestamp?;
            
            if (startDate != null) {
              // Normalize the date to start of day
              final start = DateTime(
                startDate.toDate().year,
                startDate.toDate().month,
                startDate.toDate().day,
              );
              
              if (!periods.containsKey(start)) {
                periods[start] = [];
              }
              periods[start]!.add({
                'type': 'start',
                'employee_ref': application.applicantRef,
              });
            }
            
            if (endDate != null) {
              // Normalize the date to start of day
              final end = DateTime(
                endDate.toDate().year,
                endDate.toDate().month,
                endDate.toDate().day,
              );
              
              if (!periods.containsKey(end)) {
                periods[end] = [];
              }
              periods[end]!.add({
                'type': 'end',
                'employee_ref': application.applicantRef,
              });
            }
            
            // Debug print
            print('Loaded ${periods.length} days with employment periods');
            periods.forEach((date, dayPeriods) {
              print('Date: $date, Periods: ${dayPeriods.length}');
            });
            
            setState(() {
              _employmentPeriods = periods;
            });
          });
        }
      }
    });
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  iconColor.withOpacity(0.15),
                  iconColor.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: iconColor.withOpacity(0.1),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 18,
              color: iconColor,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                    color: Color(0xFF1A365D).withOpacity(0.6),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A365D),
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