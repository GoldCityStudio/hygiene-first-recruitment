import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/create_profile_company/create_profile_company_widget.dart';
import '/pages/check_in_management/check_in_management_widget.dart';
import '/models/statistics_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'company_dashboard_model.dart';
import 'dart:convert';
export 'company_dashboard_model.dart';

class CompanyDashboardWidget extends StatefulWidget {
  const CompanyDashboardWidget({super.key});

  static String routeName = 'company_dashboard';
  static String routePath = 'company_dashboard';

  @override
  State<CompanyDashboardWidget> createState() => _CompanyDashboardWidgetState();
}

class _CompanyDashboardWidgetState extends State<CompanyDashboardWidget> {
  late CompanyDashboardModel _model;
  // Define breakpoints for different screen sizes
  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 900;
  static const double _desktopBreakpoint = 1200;
  
  // Track current screen size
  double _screenWidth = 0;
  bool get _isMobile => _screenWidth < _mobileBreakpoint;
  bool get _isTablet => _screenWidth >= _mobileBreakpoint && _screenWidth < _tabletBreakpoint;
  bool get _isDesktop => _screenWidth >= _desktopBreakpoint;
  
  bool isLoading = true;
  UsersRecord? userDoc;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CompanyDashboardModel());
    _loadUserData();
    // Initialize screen width
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _screenWidth = MediaQuery.of(context).size.width;
      });
    });
  }

  Future<void> _loadUserData() async {
    if (currentUserReference == null) {
      print('Error: currentUserReference is null');
      setState(() {
        isLoading = false;
      });
      context.goNamed('home');
      return;
    }

    try {
      print('Loading user data from reference: ${currentUserReference?.path}');
      final userData = await UsersRecord.getDocumentOnce(currentUserReference!);
      
      // Log user data in JSON format
      final userDataJson = {
        'displayName': userData.displayName,
        'type': userData.type,
        'email': userData.email,
        'photoUrl': userData.photoUrl,
        'photoCoverUrl': userData.photoCoverUrl,
        'location': userData.location,
        'description': userData.description,
        'website': userData.website,
        'createdTime': userData.createdTime?.toIso8601String(),
        'phoneNumber': userData.phoneNumber,
        'emailNotifications': userData.emailNotifications,
        'pushNotifications': userData.pushNotifications,
        'notificationFrequency': userData.notificationFrequency,
        'verifiedAccount': userData.verifiedAccount,
        'profilePhotoBlurhash': userData.profilePhotoBlurhash,
        'coverPhotoBlurhash': userData.coverPhotoBlurhash,
        'uid': userData.uid,
        'reference': userData.reference.path,
      };
      
      print('User Data Loaded (JSON):');
      print(const JsonEncoder.withIndent('  ').convert(userDataJson));
      
      if (mounted) {
        setState(() {
          userDoc = userData;
          isLoading = false;
        });
        
        if (userDoc?.type != 'Company') {
          print('Error: User type is not Company: ${userDoc?.type}');
          context.goNamed('home');
        }
      }
    } catch (e, stackTrace) {
      print('Error loading user data: $e');
      print('Stack trace: $stackTrace');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        context.goNamed('home');
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    context.goNamed('login');
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingScaffold(context);
    }

    if (userDoc == null || userDoc?.type != 'Company') {
      return _buildErrorScaffold(context);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        _screenWidth = constraints.maxWidth;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xFFF5F7FA),
          drawer: _isMobile ? _buildDrawer() : null,
          body: Row(
            children: [
              if (!_isMobile) _buildSidebar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildWelcomeSection(),
                        SizedBox(height: 32),
                        _buildRecentActivity(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: _buildSidebar(),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: _isTablet ? 200 : 250,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Color(0xFF2B4C7E).withOpacity(0.1),
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          _buildSidebarHeader(),
          Divider(
            color: Color(0xFF2B4C7E).withOpacity(0.1),
            thickness: 1,
          ),
          Expanded(
            child: _buildSidebarMenu(),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarHeader() {
    final displayName = userDoc?.displayName ?? '使用者';
    final firstChar = displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U';
    
    return Padding(
      padding: EdgeInsets.all(_isTablet ? 16 : 24),
      child: Row(
        children: [
          CircleAvatar(
            radius: _isTablet ? 20 : 24,
            backgroundColor: Color(0xFF2B4C7E),
            child: Text(
              firstChar,
              style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A365D),
                      ),
                ),
                Text(
                  '公司管理員',
                  style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                        color: Color(0xFF2B4C7E).withOpacity(0.7),
                        fontSize: _isTablet ? 11 : 12,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarMenu() {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: _isTablet ? 12 : 16),
      children: [
        _buildSidebarItem(
          '儀表板',
          Icons.dashboard_outlined,
          true,
          () {},
        ),
        _buildSidebarItem(
          '發布職缺',
          Icons.work_outline,
          false,
          () => context.pushNamed('postJob'),
        ),
        _buildSidebarItem(
          '申請管理',
          Icons.person_outline,
          false,
          () => context.pushNamed('companyJobListings'),
        ),
        _buildSidebarItem(
          '打卡管理',
          Icons.access_time_outlined,
          false,
          () => context.pushNamed(CheckInManagementWidget.routeName),
        ),
        _buildSidebarItem(
          '建立公司資料',
          Icons.business_center_outlined,
          false,
          () => context.pushNamed(CreateProfileCompanyWidget.routeName),
        ),
        Divider(
          color: Color(0xFF2B4C7E).withOpacity(0.1),
          thickness: 1,
        ),
        _buildSidebarItem(
          '返回主頁',
          Icons.home_outlined,
          false,
          () => context.goNamed('home'),
        ),
        _buildSidebarItem(
          '登出',
          Icons.logout_outlined,
          false,
          () async {
            await signOut();
            if (mounted) {
              context.goNamed('home');
            }
          },
        ),
      ],
    );
  }

  Widget _buildSidebarItem(
    String title,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return ListTile(
      dense: _isTablet,
      selectedTileColor: Color(0xFF2B4C7E).withOpacity(0.05),
      hoverColor: Color(0xFF2B4C7E).withOpacity(0.1),
      leading: Icon(
        icon,
        color: isSelected
            ? Color(0xFF2B4C7E)
            : Color(0xFF2B4C7E).withOpacity(0.6),
        size: _isTablet ? 20 : 24,
      ),
      title: Text(
        title,
        style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
              color: isSelected
                  ? Color(0xFF2B4C7E)
                  : Color(0xFF1A365D),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: _isTablet ? 13 : 14,
            ),
      ),
      selected: isSelected,
      onTap: onTap,
    );
  }

  Widget _buildWelcomeSection() {
    final displayName = userDoc?.displayName ?? '使用者';
    
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2B4C7E),
            Color(0xFF1A365D),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '歡迎回來，$displayName',
            style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 8),
          Text(
            '這是您的公司管理儀表板',
            style: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '最近活動',
          style: FlutterFlowTheme.of(context).titleLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color(0xFF2B4C7E).withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0xFF2B4C7E).withOpacity(0.1),
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Column(
            children: [
                      _buildActivityItem(
                        '活躍職缺',
                '查看您目前發布的職缺',
                        Icons.work_outline,
                        FlutterFlowTheme.of(context).primary,
                      ),
                      _buildActivityItem(
                '申請管理',
                '管理收到的求職申請',
                        Icons.person_add_outlined,
                        Colors.orange,
                      ),
              _buildActivityItem(
                '打卡管理',
                '查看員工打卡記錄',
                Icons.access_time_outlined,
                Colors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(String title, String subtitle, IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2B4C7E).withOpacity(0.15),
                  Color(0xFF2B4C7E).withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Color(0xFF2B4C7E),
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  subtitle,
                  style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated logo container
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.8, end: 1.0),
              duration: Duration(milliseconds: 1500),
              curve: Curves.easeInOut,
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF2B4C7E).withOpacity(0.15),
                          Color(0xFF2B4C7E).withOpacity(0.05),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.business_center_rounded,
                        size: 50,
                        color: Color(0xFF2B4C7E),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            // Loading text with fade animation
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 1000),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: Text(
                    '載入中...',
                    style: FlutterFlowTheme.of(context).titleLarge.copyWith(
                      color: FlutterFlowTheme.of(context).primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            // Animated dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  builder: (context, double value, child) {
                    return Transform.translate(
                      offset: Offset(0, -4 * value),
                      child: Container(
                        width: 8,
                        height: 8,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary.withOpacity(0.5 + (0.5 * value)),
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
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
              '無法載入用戶資料',
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
}