import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'login_model.dart';
export 'login_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  static String routeName = 'login';
  static String routePath = 'login';

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSmallScreen = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'login'});
    _model.emailAddressTextController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        isSmallScreen = constraints.maxWidth < 600;
        return Scaffold(
        key: scaffoldKey,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildHeaderSection(),
                _buildLoginForm(),
                _buildFooterSection(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderSection() {
            return Container(
      width: double.infinity,
      height: isSmallScreen ? 200 : 300,
              decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
                ),
              ),
                child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
          Image.asset(
            'assets/images/hygienelogo.png',
            width: isSmallScreen ? 80 : 120,
            height: isSmallScreen ? 80 : 120,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 16),
          Text(
            'Hygiene First',
            style: FlutterFlowTheme.of(context).headlineLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
    );
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Form(
        key: _model.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '登入',
              style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
                    fontWeight: FontWeight.bold,
                      ),
                    ),
            SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                  width: 1,
                ),
              ),
                                          child: TextFormField(
                                            controller: _model.emailAddressTextController,
                                            focusNode: _model.emailAddressFocusNode,
                                            autofillHints: [AutofillHints.email],
                                            textInputAction: TextInputAction.next,
                                            obscureText: false,
                                            decoration: InputDecoration(
                  hintText: '電子郵件',
                  hintStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                        color: FlutterFlowTheme.of(context).secondaryText,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                                                ),
                    borderRadius: BorderRadius.circular(12),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context).primary,
                      width: 1,
                                                ),
                    borderRadius: BorderRadius.circular(12),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context).error,
                      width: 1,
                                                ),
                    borderRadius: BorderRadius.circular(12),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context).error,
                      width: 1,
                                                ),
                    borderRadius: BorderRadius.circular(12),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: FlutterFlowTheme.of(context).primary,
                                              ),
                                            ),
                style: FlutterFlowTheme.of(context).bodyMedium,
                keyboardType: TextInputType.emailAddress,
                validator: _model.emailAddressTextControllerValidator.asValidator(context),
                                          ),
                                        ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                  width: 1,
                ),
              ),
                                          child: TextFormField(
                                            controller: _model.passwordTextController,
                                            focusNode: _model.passwordFocusNode,
                                            obscureText: !_model.passwordVisibility,
                                            decoration: InputDecoration(
                  hintText: '密碼',
                  hintStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                        color: FlutterFlowTheme.of(context).secondaryText,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                                                ),
                    borderRadius: BorderRadius.circular(12),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context).primary,
                      width: 1,
                                                ),
                    borderRadius: BorderRadius.circular(12),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context).error,
                      width: 1,
                                                ),
                    borderRadius: BorderRadius.circular(12),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(context).error,
                      width: 1,
                                                ),
                    borderRadius: BorderRadius.circular(12),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: FlutterFlowTheme.of(context).primary,
                                              ),
                                              suffixIcon: InkWell(
                                                onTap: () => setState(
                                                  () => _model.passwordVisibility = !_model.passwordVisibility,
                                                ),
                                                focusNode: FocusNode(skipTraversal: true),
                                                child: Icon(
                                                  _model.passwordVisibility
                                                      ? Icons.visibility_outlined
                                                      : Icons.visibility_off_outlined,
                                                  color: FlutterFlowTheme.of(context).secondaryText,
                      size: 22,
                                                ),
                                              ),
                                            ),
                style: FlutterFlowTheme.of(context).bodyMedium,
                validator: _model.passwordTextControllerValidator.asValidator(context),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(top: 8),
                child: TextButton(
                  onPressed: () => context.pushNamed('forgot_password'),
                  child: Text(
                    '忘記密碼？',
                    style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                          color: FlutterFlowTheme.of(context).primary,
                                            ),
                                          ),
                                        ),
                                      ),
            ),
            SizedBox(height: 24),
                                      FFButtonWidget(
                                          onPressed: () async {
                                            logFirebaseEvent('LOGIN_PAGE_Button-Login_ON_TAP');
                
                                            if (_model.formKey.currentState == null ||
                                                !_model.formKey.currentState!.validate()) {
                                              return;
                                            }

                try {
                                            final user = await authManager.signInWithEmail(
                                              context,
                                              _model.emailAddressTextController.text,
                                              _model.passwordTextController.text,
                                            );
                  
                                            if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('登入失敗，請檢查電子郵件和密碼是否正確'),
                        backgroundColor: FlutterFlowTheme.of(context).error,
                      ),
                    );
                                              return;
                                            }

                  // Get user document to check type
                  final userDoc = await UsersRecord.getDocumentOnce(currentUserReference!);
                  if (!context.mounted) return;

                  // Navigate based on user type
                  if (userDoc.type == 'Company') {
                    context.goNamedAuth('company_dashboard', context.mounted);
                  } else {
                                            context.goNamedAuth('home', context.mounted);
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('登入時發生錯誤：$e'),
                      backgroundColor: FlutterFlowTheme.of(context).error,
                    ),
                  );
                }
                                          },
                                          text: '登入',
                                          options: FFButtonOptions(
                                            width: double.infinity,
                height: 50,
                padding: EdgeInsets.zero,
                iconPadding: EdgeInsets.zero,
                                            color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.copyWith(
                                              color: Colors.white,
                                            ),
                elevation: 2,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                  width: 1,
                                            ),
                borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
    );
  }

  Widget _buildFooterSection() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
                                children: [
                                  Text(
                                    '還沒有帳號？',
            style: FlutterFlowTheme.of(context).bodyMedium,
                                    ),
          SizedBox(height: 8),
                                  FFButtonWidget(
            onPressed: () => context.pushNamed('registration'),
                                    text: '註冊',
                                    options: FFButtonOptions(
              width: double.infinity,
              height: 50,
              padding: EdgeInsets.zero,
              iconPadding: EdgeInsets.zero,
              color: Colors.white,
              textStyle: FlutterFlowTheme.of(context).titleSmall.copyWith(
                                        color: FlutterFlowTheme.of(context).primary,
                                      ),
              elevation: 0,
                                      borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).primary,
                width: 1,
                                      ),
              borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
      ),
    );
  }
}
