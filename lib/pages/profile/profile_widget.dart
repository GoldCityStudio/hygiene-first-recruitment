import '/auth/firebase_auth/auth_util.dart';
import '/components/dark_light_switch/dark_light_switch_widget.dart';
import '/components/edit_phone_number/edit_phone_number_widget.dart';
import '/components/modal_edit_profile/modal_edit_profile_widget.dart';
import '/components/modal_log_out/modal_log_out_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import '/backend/schema/users_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'profile_model.dart';
export 'profile_model.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  static String routeName = 'profile';
  static String routePath = 'profile';

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late ProfileModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'profile'});
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PROFILE_PAGE_profile_ON_INIT_STATE');
      if (valueOrDefault(currentUserDocument?.type, '') == 'Guest') {
        logFirebaseEvent('profile_navigate_to');
        context.goNamed(GuestWidget.routeName);
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _showEditProfileModal() async {
    logFirebaseEvent('PROFILE_PAGE_EDIT_PROFILE_BTN_ON_TAP');
    try {
      if (currentUserReference == null) {
        throw Exception('User not signed in');
      }
      final userDoc = await UsersRecord.getDocumentOnce(currentUserReference!);
      if (!mounted) return;
      
      await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: ModalEditProfileWidget(userDoc: userDoc),
          ),
        ),
      );
      if (mounted) setState(() {});
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('無法載入個人資料：${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserReference == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '請先登入以查看個人資料',
                style: FlutterFlowTheme.of(context).titleMedium,
              ),
              SizedBox(height: 16),
              FFButtonWidget(
                onPressed: () => context.goNamed('login'),
                text: '登入',
                options: FFButtonOptions(
                  width: 130,
                  height: 40,
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.copyWith(
                    color: Colors.white,
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(currentUserReference!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '載入個人資料時發生錯誤',
                    style: FlutterFlowTheme.of(context).titleMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                      color: FlutterFlowTheme.of(context).error,
                    ),
                  ),
                  SizedBox(height: 16),
                  FFButtonWidget(
                    onPressed: () => setState(() {}),
                    text: '重試',
                    options: FFButtonOptions(
                      width: 130,
                      height: 40,
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context).titleSmall.copyWith(
                        color: Colors.white,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final userDoc = snapshot.data!;
        return Scaffold(
        key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Text(
              '個人資料',
              style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
            ),
            centerTitle: true,
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Profile Header
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24.0),
                      bottomRight: Radius.circular(24.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),
                      // Profile Picture
                      Container(
                        width: 120.0,
                        height: 120.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8.0,
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0.0, 4.0),
                              spreadRadius: 2.0,
                              )
                            ],
                          ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60.0),
                            child: userDoc.photoUrl != null && userDoc.photoUrl!.isNotEmpty
                                ? Image.network(
                                    userDoc.photoUrl!,
                                    width: 120.0,
                                    height: 120.0,
                                fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Icon(
                                      Icons.person,
                                      color: FlutterFlowTheme.of(context).primary,
                                      size: 60.0,
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 60.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // User Info
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            Text(
                              userDoc.displayName ?? '未設定名稱',
                              style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              userDoc.email ?? '未設定電子郵件',
                              style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Edit Profile Button
                      Container(
                        margin: const EdgeInsets.only(bottom: 24.0),
                        child: FFButtonWidget(
                          onPressed: _showEditProfileModal,
                          text: '編輯個人資料',
                          options: FFButtonOptions(
                            width: 160,
                            height: 44,
                                        color: Colors.white,
                            textStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontWeight: FontWeight.w600,
                                ),
                            elevation: 3,
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Settings Sections
                Padding(
                  padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      // Account Settings Section
                      _buildSectionHeader('帳號設定'),
                      _buildSettingItem(
                        icon: Icons.phone,
                        title: '電話號碼',
                        subtitle: userDoc.phoneNumber ?? '未設定',
                            onTap: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                            builder: (context) => EditPhoneNumberWidget(),
                          );
                        },
                      ),
                      const Divider(),
                      // Support Section
                      _buildSectionHeader('支援與協助'),
                      _buildSettingItem(
                        icon: Icons.help_outline,
                        title: '常見問題',
                        onTap: () {
                          logFirebaseEvent('PROFILE_PAGE_FAQ_BTN_ON_TAP');
                          context.pushNamed('faq');
                        },
                      ),
                      _buildSettingItem(
                        icon: Icons.contact_support_outlined,
                        title: '聯絡我們',
                        onTap: () {
                          logFirebaseEvent('PROFILE_PAGE_CONTACT_US_BTN_ON_TAP');
                          context.pushNamed('contact_us');
                        },
                      ),
                      const Divider(),
                      // About Section
                      _buildSectionHeader('關於'),
                      _buildSettingItem(
                        icon: Icons.privacy_tip_outlined,
                        title: '隱私權政策',
                        onTap: () {
                          logFirebaseEvent('PROFILE_PAGE_PRIVACY_POLICY_BTN_ON_TAP');
                          context.pushNamed('privacy_policy');
                        },
                      ),
                      _buildSettingItem(
                        icon: Icons.description_outlined,
                        title: '服務條款',
                        onTap: () async {
                          logFirebaseEvent('PROFILE_Container_1q3j8j8j_ON_TAP');
                          logFirebaseEvent('Container_navigate_to');

                          context.pushNamed(
                            'legal',
                            queryParameters: {
                              'route': serializeParam(
                                'EST',
                                ParamType.String,
                              ),
                            }.withoutNulls,
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                        // Logout Button
                      Center(
                          child: FFButtonWidget(
                            onPressed: () async {
                            logFirebaseEvent('PROFILE_PAGE_LOG_OUT_BTN_ON_TAP');
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => ModalLogOutWidget(),
                              );
                            },
                            text: '登出',
                            options: FFButtonOptions(
                            width: 200,
                            height: 48,
                                color: FlutterFlowTheme.of(context).error,
                            textStyle: FlutterFlowTheme.of(context).titleSmall.copyWith(
                                  color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            elevation: 2,
                            borderRadius: BorderRadius.circular(24),
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
      );
    },
  );
}

Widget _buildSectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Text(
      title,
      style: FlutterFlowTheme.of(context).titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
    ),
  );
}

Widget _buildSettingItem({
  required IconData icon,
  required String title,
  String? subtitle,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: FlutterFlowTheme.of(context).bodyLarge,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                  ),
                ],
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: FlutterFlowTheme.of(context).secondaryText,
            size: 24,
          ),
        ],
        ),
      ),
    );
  }
}
