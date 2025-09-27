import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'candidate_contact_details_model.dart';
export 'candidate_contact_details_model.dart';

class CandidateContactDetailsWidget extends StatefulWidget {
  const CandidateContactDetailsWidget({
    super.key,
    required this.email,
    required this.phone,
  });

  final String? email;
  final String? phone;

  @override
  State<CandidateContactDetailsWidget> createState() =>
      _CandidateContactDetailsWidgetState();
}

class _CandidateContactDetailsWidgetState
    extends State<CandidateContactDetailsWidget> with TickerProviderStateMixin {
  late CandidateContactDetailsModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CandidateContactDetailsModel());

    animationsMap.addAll({
      'iconOnActionTriggerAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 150.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(0.75, 0.75),
          ),
        ],
      ),
      'iconOnActionTriggerAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 150.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(0.75, 0.75),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
              child: Text(
                '電子郵件',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Montserrat',
                      fontSize: 24.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Divider(
              thickness: 1.0,
              color: FlutterFlowTheme.of(context).lineColor,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 16.0, 4.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'CANDIDATE_CONTACT_DETAILS_Text_q0rz6c5g_');
                      logFirebaseEvent('Text_send_email');
                      await launchUrl(Uri(
                        scheme: 'mailto',
                        path: widget.email!,
                      ));
                    },
                    onLongPress: () async {
                      logFirebaseEvent(
                          'CANDIDATE_CONTACT_DETAILS_Text_q0rz6c5g_');
                      logFirebaseEvent('Text_copy_to_clipboard');
                      await Clipboard.setData(
                          ClipboardData(text: widget.email!));
                      logFirebaseEvent('Text_show_snack_bar');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Copied Email to Clipboard!',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Montserrat',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondary,
                        ),
                      );
                    },
                    child: Text(
                      widget.email!,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF009EFF),
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent(
                        'CANDIDATE_CONTACT_DETAILS_Icon_35my7lwv_');
                    logFirebaseEvent('Icon_copy_to_clipboard');
                    await Clipboard.setData(
                        ClipboardData(text: widget.email!));
                    logFirebaseEvent('Icon_widget_animation');
                    if (animationsMap['iconOnActionTriggerAnimation1'] !=
                        null) {
                      await animationsMap['iconOnActionTriggerAnimation1']!
                          .controller
                          .forward(from: 0.0);
                    }
                    logFirebaseEvent('Icon_show_snack_bar');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Email Copied To Clipboard',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Montserrat',
                                color:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                                letterSpacing: 0.0,
                              ),
                        ),
                        duration: Duration(milliseconds: 4000),
                        backgroundColor: FlutterFlowTheme.of(context).primary,
                      ),
                    );
                  },
                  child: Icon(
                    Icons.content_copy,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 20.0,
                  ),
                ).animateOnActionTrigger(
                  animationsMap['iconOnActionTriggerAnimation1']!,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8.0, 16.0, 0.0, 0.0),
              child: Text(
                '電話號碼',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Montserrat',
                      fontSize: 24.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Divider(
              thickness: 1.0,
              color: FlutterFlowTheme.of(context).lineColor,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 16.0, 4.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'CANDIDATE_CONTACT_DETAILS_Text_a47mnv46_');
                      logFirebaseEvent('Text_call_number');
                      await launchUrl(Uri(
                        scheme: 'tel',
                        path: widget.phone!,
                      ));
                    },
                    onLongPress: () async {
                      logFirebaseEvent(
                          'CANDIDATE_CONTACT_DETAILS_Text_a47mnv46_');
                      logFirebaseEvent('Text_copy_to_clipboard');
                      await Clipboard.setData(
                          ClipboardData(text: widget.phone!));
                    },
                    child: Text(
                      valueOrDefault<String>(
                        widget.phone,
                        'Unavailable',
                      ),
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF009EFF),
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent(
                        'CANDIDATE_CONTACT_DETAILS_Icon_dlza4fqo_');
                    logFirebaseEvent('Icon_copy_to_clipboard');
                    await Clipboard.setData(
                        ClipboardData(text: widget.phone!));
                    logFirebaseEvent('Icon_widget_animation');
                    if (animationsMap['iconOnActionTriggerAnimation2'] !=
                        null) {
                      await animationsMap['iconOnActionTriggerAnimation2']!
                          .controller
                          .forward(from: 0.0);
                    }
                    logFirebaseEvent('Icon_show_snack_bar');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Phone Number Copied To Clipboard',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Montserrat',
                                color:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                                letterSpacing: 0.0,
                              ),
                        ),
                        duration: Duration(milliseconds: 4000),
                        backgroundColor: FlutterFlowTheme.of(context).primary,
                      ),
                    );
                  },
                  child: Icon(
                    Icons.content_copy,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 20.0,
                  ),
                ).animateOnActionTrigger(
                  animationsMap['iconOnActionTriggerAnimation2']!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
