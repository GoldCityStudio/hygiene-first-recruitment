import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'registration_model.dart';
export 'registration_model.dart';

class RegistrationWidget extends StatefulWidget {
  const RegistrationWidget({super.key});

  static String routeName = 'registration';
  static String routePath = 'registration';

  @override
  State<RegistrationWidget> createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  late RegistrationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSmallScreen = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RegistrationModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'registration'});
    _model.emailAddressTextController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    _model.confirmPasswordTextController ??= TextEditingController();
    _model.confirmPasswordFocusNode ??= FocusNode();
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
                _buildRegistrationForm(),
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
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: isSmallScreen ? 5 : 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/hygienelogo.png',
                    width: isSmallScreen ? 80 : 120,
                    height: isSmallScreen ? 80 : 120,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Hygiene First',
                    style: FlutterFlowTheme.of(context).headlineLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Form(
        key: _model.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '註冊',
            style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 24),
          _buildEmailField(),
          SizedBox(height: 16),
          _buildPasswordField(),
          SizedBox(height: 16),
          _buildConfirmPasswordField(),
          SizedBox(height: 24),
          _buildRegisterButton(),
        ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
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
    );
  }

  Widget _buildPasswordField() {
    return Container(
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
        textInputAction: TextInputAction.next,
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
    );
  }

  Widget _buildConfirmPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: _model.confirmPasswordTextController,
        focusNode: _model.confirmPasswordFocusNode,
        textInputAction: TextInputAction.done,
        obscureText: !_model.confirmPasswordVisibility,
        decoration: InputDecoration(
          hintText: '確認密碼',
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
              () => _model.confirmPasswordVisibility = !_model.confirmPasswordVisibility,
            ),
            focusNode: FocusNode(skipTraversal: true),
            child: Icon(
              _model.confirmPasswordVisibility
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 22,
            ),
          ),
        ),
        style: FlutterFlowTheme.of(context).bodyMedium,
        validator: _model.confirmPasswordTextControllerValidator.asValidator(context),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return FFButtonWidget(
      onPressed: () async {
        print('Register button pressed'); // Debug log
        logFirebaseEvent('REGISTRATION_PAGE_註冊_BTN_ON_TAP');
        
        print('Validating form...'); // Debug log
        // First validate the form
        final isValid = _model.formKey.currentState?.validate() ?? false;
        print('Form validation result: $isValid'); // Debug log
        
        if (!isValid) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('請檢查表單是否填寫正確'),
              backgroundColor: FlutterFlowTheme.of(context).error,
            ),
          );
          return;
        }

        print('Showing loading indicator...'); // Debug log
        // Show loading indicator
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                SizedBox(width: 16),
                Text('註冊中...'),
              ],
            ),
            duration: Duration(seconds: 4),
            backgroundColor: FlutterFlowTheme.of(context).primary,
          ),
        );

        print('Attempting Firebase registration...'); // Debug log
        try {
          print('Email: ${_model.emailAddressTextController.text.trim()}'); // Debug log (be careful with logging sensitive data in production)
          final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _model.emailAddressTextController.text.trim(),
            password: _model.passwordTextController.text,
          );

          print('Firebase registration response received'); // Debug log
          if (user.user != null) {
            print('Registration successful, navigating to profile creation'); // Debug log
            // Clear any existing snackbars
            ScaffoldMessenger.of(context).clearSnackBars();
            
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('註冊成功！'),
                backgroundColor: Colors.green,
              ),
            );

            // Navigate to create profile page
            context.goNamed('createProfile');
          }
        } on FirebaseAuthException catch (e) {
          print('Firebase Auth Exception: ${e.code} - ${e.message}'); // Debug log
          // Clear any existing snackbars
          ScaffoldMessenger.of(context).clearSnackBars();
          
          String errorMessage;
          switch (e.code) {
            case 'email-already-in-use':
              errorMessage = '此電子郵件已被註冊';
              break;
            case 'invalid-email':
              errorMessage = '無效的電子郵件格式';
              break;
            case 'operation-not-allowed':
              errorMessage = '註冊功能目前未開放';
              break;
            case 'weak-password':
              errorMessage = '密碼強度不足';
              break;
            default:
              errorMessage = '註冊失敗：${e.message}';
          }
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: FlutterFlowTheme.of(context).error,
            ),
          );
        } catch (e) {
          print('General Exception during registration: $e'); // Debug log
          // Clear any existing snackbars
          ScaffoldMessenger.of(context).clearSnackBars();
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('註冊時發生錯誤，請稍後再試'),
              backgroundColor: FlutterFlowTheme.of(context).error,
            ),
          );
        }
      },
      text: '註冊',
      options: FFButtonOptions(
        width: double.infinity,
        height: 50.0,
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
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  Widget _buildFooterSection() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            '已經有帳號？',
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
          SizedBox(height: 8),
          FFButtonWidget(
            onPressed: () => context.pushNamed('login'),
            text: '登入',
            options: FFButtonOptions(
              width: double.infinity,
              height: 50.0,
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              color: Colors.white,
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Montserrat',
                    color: FlutterFlowTheme.of(context).primary,
                  ),
              elevation: 0.0,
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).primary,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ],
      ),
    );
  }
}
