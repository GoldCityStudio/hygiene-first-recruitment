import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/permissions_util.dart';
import 'package:flutter/material.dart';
import 'notification_settings_model.dart';
export 'notification_settings_model.dart';

class NotificationSettingsWidget extends StatefulWidget {
  const NotificationSettingsWidget({super.key});

  static String routeName = 'notificationSettings';
  static String routePath = 'notificationSettings';

  @override
  State<NotificationSettingsWidget> createState() =>
      _NotificationSettingsWidgetState();
}

class _NotificationSettingsWidgetState
    extends State<NotificationSettingsWidget> {
  late NotificationSettingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationSettingsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'notificationSettings'});
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
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          buttonSize: 46.0,
          icon: Icon(
            Icons.chevron_left_rounded,
            color: FlutterFlowTheme.of(context).primaryBtnText,
            size: 25.0,
          ),
          onPressed: () async {
            logFirebaseEvent('NOTIFICATION_SETTINGS_chevron_left_round');
            logFirebaseEvent('IconButton_navigate_back');
            context.pop();
          },
        ),
        title: Text(
          '通知設定',
          style: FlutterFlowTheme.of(context).titleMedium.override(
                fontFamily: 'Montserrat',
                color: Color(0xFFFBFBFB),
                letterSpacing: 0.0,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                    child: Text(
                      '選擇您想要接收的通知，我們將更新設定。',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Montserrat',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
            child: AuthUserStreamWidget(
              builder: (context) => Material(
                color: Colors.transparent,
                child: SwitchListTile.adaptive(
                  value: _model.switchListTilePushNotifValue ??=
                      valueOrDefault<bool>(
                          currentUserDocument?.pushNotifications, false),
                  onChanged: (newValue) async {
                    safeSetState(
                        () => _model.switchListTilePushNotifValue = newValue);
                    if (newValue) {
                      logFirebaseEvent(
                          'NOTIFICATION_SETTINGS_SwitchListTilePush');
                      logFirebaseEvent(
                          'SwitchListTilePushNotif_request_permissi');
                      await requestPermission(notificationsPermission);
                    }
                  },
                  title: Text(
                    '推播通知',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0.0,
                          lineHeight: 2.0,
                        ),
                  ),
                  subtitle: Text(
                    '接收來自我們的應用程式的推播通知，以獲得新的工作匹配。',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF8B97A2),
                          letterSpacing: 0.0,
                        ),
                  ),
                  tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                  activeColor: FlutterFlowTheme.of(context).primary,
                  activeTrackColor: FlutterFlowTheme.of(context).primary,
                  dense: false,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 12.0),
                ),
              ),
            ),
          ),
          if (false)
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
              child: Container(
                width: double.infinity,
                height: 60.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '通知頻率',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        AuthUserStreamWidget(
                          builder: (context) => FlutterFlowDropDown<String>(
                            controller: _model.dropDownValueController ??=
                                FormFieldController<String>(
                              _model.dropDownValue ??= valueOrDefault<String>(
                                valueOrDefault(
                                    currentUserDocument?.notificationFrequency,
                                    ''),
                                'Daily Summary Updates',
                              ),
                            ),
                            options: ['每日摘要更新', '即時更新'],
                            onChanged: (val) =>
                                safeSetState(() => _model.dropDownValue = val),
                            width: 220.0,
                            height: 50.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Montserrat',
                                  letterSpacing: 0.0,
                                ),
                            hintText: '請選擇...',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            elevation: 2.0,
                            borderColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            borderWidth: 2.0,
                            borderRadius: 8.0,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                16.0, 4.0, 16.0, 4.0),
                            hidesUnderline: true,
                            isSearchable: false,
                            isMultiSelect: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          AuthUserStreamWidget(
            builder: (context) => Material(
              color: Colors.transparent,
              child: SwitchListTile.adaptive(
                value: _model.switchListTileEmailNotifValue ??=
                    valueOrDefault<bool>(
                        currentUserDocument?.emailNotifications, false),
                onChanged: (newValue) async {
                  safeSetState(
                      () => _model.switchListTileEmailNotifValue = newValue);
                },
                title: Text(
                  '電子郵件通知',
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'Montserrat',
                        letterSpacing: 0.0,
                        lineHeight: 2.0,
                      ),
                ),
                subtitle: Text(
                  '接收來自我們的行銷團隊的相關工作的相關電子郵件通知。',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF8B97A2),
                        letterSpacing: 0.0,
                      ),
                ),
                tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                activeColor: FlutterFlowTheme.of(context).primary,
                activeTrackColor: FlutterFlowTheme.of(context).primary,
                dense: false,
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding:
                    EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 12.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
            child: FFButtonWidget(
              onPressed: () async {
                logFirebaseEvent('NOTIFICATION_SETTINGS_Button-Login_ON_TA');
                logFirebaseEvent('Button-Login_backend_call');

                await currentUserReference!.update(createUsersRecordData(
                  emailNotifications: _model.switchListTilePushNotifValue,
                  notificationFrequency: _model.dropDownValue,
                  pushNotifications: _model.switchListTilePushNotifValue,
                ));
                logFirebaseEvent('Button-Login_navigate_back');
                context.safePop();
              },
              text: '儲存變更',
              options: FFButtonOptions(
                width: 190.0,
                height: 50.0,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      letterSpacing: 0.0,
                    ),
                elevation: 0.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
