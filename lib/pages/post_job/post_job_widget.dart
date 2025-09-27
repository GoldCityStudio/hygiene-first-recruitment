import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/categories_dropdown/categories_dropdown_widget.dart';
import '/components/edit_phone_number/edit_phone_number_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'post_job_model.dart';
export 'post_job_model.dart';

class PostJobWidget extends StatefulWidget {
  const PostJobWidget({super.key});

  static String routeName = 'postJob';
  static String routePath = 'postJob';

  @override
  State<PostJobWidget> createState() => _PostJobWidgetState();
}

class _PostJobWidgetState extends State<PostJobWidget> {
  late PostJobModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostJobModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'postJob'});
    _model.jobPosTextFieldTextController ??= TextEditingController();
    _model.jobPosTextFieldFocusNode ??= FocusNode();
    _model.jobPosTextFieldFocusNode!.addListener(
      () async {
        logFirebaseEvent('POST_JOB_jobPosTextField_ON_FOCUS_CHANGE');
        logFirebaseEvent('jobPosTextField_custom_action');
        _model.trimOutput = await actions.trimTextAction(
          _model.jobPosTextFieldTextController.text,
        );
        logFirebaseEvent('jobPosTextField_set_form_field');
        safeSetState(() {
          _model.jobPosTextFieldTextController?.text = _model.trimOutput!;
        });

        safeSetState(() {});
      },
    );
    _model.jobDescriptionTextController ??= TextEditingController();
    _model.jobDescriptionFocusNode ??= FocusNode();

    _model.requirementsTextController ??= TextEditingController();
    _model.requirementsFocusNode ??= FocusNode();

    _model.appLinkTextFieldTextController ??= TextEditingController();
    _model.appLinkTextFieldFocusNode ??= FocusNode();

    _model.undisclosedSalary = false;
    _model.coverLetterSwitchValue = true;
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF5F7FA),
        appBar: AppBar(
          backgroundColor: Color(0xFF2B4C7E),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => context.safePop(),
          ),
          title: Text(
            '創建服務崗位發布',
            style: FlutterFlowTheme.of(context).titleMedium.override(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  letterSpacing: 0.0,
                ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: Form(
            key: _model.formKey,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isSmallScreen = constraints.maxWidth < 600;
                final isMediumScreen = constraints.maxWidth < 1200;
                final formWidth = isSmallScreen
                    ? constraints.maxWidth
                    : isMediumScreen
                        ? constraints.maxWidth * 0.8
                        : 1200.0;
                
                return Center(
                  child: SingleChildScrollView(
                    child: Container(
                      width: formWidth,
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 12.0 : 24.0,
                        vertical: 24.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '創建服務崗位發布',
                            style: FlutterFlowTheme.of(context).headlineMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF2B4C7E),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(height: 24),
                          _buildHeader(),
                          SizedBox(height: 24),
                          _buildSectionTitle('基本資訊'),
                          _buildJobPositionField(),
                          SizedBox(height: 24),
                          _buildJobDescriptionField(),
                          SizedBox(height: 24),
                          _buildRequirementsField(),
                          SizedBox(height: 32),
                          _buildSectionTitle('服務詳情'),
                          _buildJobDetailsRow(isSmallScreen),
                          SizedBox(height: 24),
                          _buildJobDurationFields(isSmallScreen),
                          SizedBox(height: 24),
                          _buildWorkingHoursField(isSmallScreen),
                          SizedBox(height: 24),
                          _buildLocationField(),
                          SizedBox(height: 24),
                          _buildCategoriesField(),
                          SizedBox(height: 32),
                          _buildSectionTitle('服務酬金'),
                          _buildSalarySection(isSmallScreen),
                          SizedBox(height: 32),
                          _buildSectionTitle('申請詳情'),
                          _buildApplicationLinkField(),
                          SizedBox(height: 24),
                          _buildCoverLetterSwitch(),
                          SizedBox(height: 24),
                          _buildDeadlineField(),
                          SizedBox(height: 40),
                          _buildSubmitButton(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2B4C7E), Color(0xFF1A365D)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Color(0xFF2B4C7E).withOpacity(0.3),
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: AuthUserStreamWidget(
              builder: (context) => ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  currentUserPhoto,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthUserStreamWidget(
                  builder: (context) => Text(
                    currentUserDisplayName,
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Text(
                  '發布新服務崗位',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        color: Colors.white.withOpacity(0.8),
                        letterSpacing: 0.0,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: FlutterFlowTheme.of(context).titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A365D),
              letterSpacing: 0.5,
            ),
      ),
    );
  }

  Widget _buildJobPositionField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
      child: FlutterFlowDropDown<String>(
        controller: _model.jobPosValueController ??= FormFieldController<String>(null),
        options: [
          '註冊護士 (RN)',
          '登記護士 (EN)',
          '物理治療師 (PT)',
          '職業治療師 (OT)',
          '言語治療師 (ST)',
          '營養師 (Dietitian)',
          '物理治療師助理 (PTA)',
          '職業治療師助理 (OTA)',
          '註冊醫生 (VMO Doctor)',
          '註冊社工 (SWA/ASWO)',
          '陪診員 (Escort Service)',
          '診所助護 (Clinic Nurse)',
          '抽血員 (Phlebotomist)',
          '活動助理 (Programme Worker)',
          '保健員 (HCA/HW)',
          '護理員 (PCW/PCA)',
          '司機 (Driver)',
          '廚師 (Chef)',
          '廚房幫工/工友/庶務員(WM)',
          '看守員',
        ],
        onChanged: (val) => setState(() => _model.jobPosValue = val),
        width: double.infinity,
        height: 50,
        textStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
          color: Color(0xFF1A365D),
        ),
        hintText: '請選擇服務崗位',
        icon: Icon(
          Icons.work_outline,
          color: Color(0xFF2B4C7E),
        ),
        fillColor: Colors.white,
        elevation: 2,
        borderColor: Colors.transparent,
        borderWidth: 1,
        borderRadius: 12,
        margin: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
        hidesUnderline: true,
        isSearchable: false,
      ),
    );
  }

  Widget _buildJobDescriptionField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
      child: TextFormField(
        controller: _model.jobDescriptionTextController,
        focusNode: _model.jobDescriptionFocusNode,
        obscureText: false,
        maxLines: 5,
        decoration: InputDecoration(
          labelText: '服務說明',
          labelStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: Color(0xFF2B4C7E).withOpacity(0.7),
              ),
          hintText: '請詳細描述工作內容、職責和要求',
          hintStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: Color(0xFF2B4C7E).withOpacity(0.5),
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
              color: Color(0xFF2B4C7E),
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
            Icons.description_outlined,
            color: Color(0xFF2B4C7E),
          ),
        ),
        style: FlutterFlowTheme.of(context).bodyMedium,
        validator: _model.jobDescriptionTextControllerValidator.asValidator(context),
      ),
    );
  }

  Widget _buildRequirementsField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
      child: TextFormField(
        controller: _model.requirementsTextController,
        focusNode: _model.requirementsFocusNode,
        obscureText: false,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: '服務要求',
          labelStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: Color(0xFF2B4C7E).withOpacity(0.7),
              ),
          hintText: '請列出工作所需的技能和經驗要求',
          hintStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: Color(0xFF2B4C7E).withOpacity(0.5),
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
              color: Color(0xFF2B4C7E),
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
            Icons.checklist_outlined,
            color: Color(0xFF2B4C7E),
          ),
        ),
        style: FlutterFlowTheme.of(context).bodyMedium,
        validator: _model.requirementsTextControllerValidator.asValidator(context),
      ),
    );
  }

  Widget _buildJobDetailsRow(bool isSmallScreen) {
    return isSmallScreen
        ? Column(
      children: [
              _buildJobTypeDropdown(),
              SizedBox(height: 16),
              _buildExperienceDropdown(),
            ],
          )
        : Row(
            children: [
              Expanded(child: _buildJobTypeDropdown()),
        SizedBox(width: 16),
              Expanded(child: _buildExperienceDropdown()),
      ],
    );
  }

  Widget _buildJobTypeDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
      child: FlutterFlowDropDown<String>(
        controller: _model.jobTypeValueController ??= FormFieldController<String>(null),
        options: [
          '安老院舍',
          '殘疾院舍',
          '幼兒中心',
          '日間中心',
          '展能中心',
          '外展服務',
          '診所服務',
          '上門服務',
          '活動',
          '義工服務'
        ].map((option) => '  $option').toList(),
        onChanged: (val) => setState(() => _model.jobTypeValue = val?.trim()),
        width: double.infinity,
        height: 50,
        textStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
          color: Color(0xFF1A365D),
        ),
        hintText: '  服務類型',
        icon: Icon(
          Icons.work_outline,
          color: Color(0xFF2B4C7E),
        ),
        fillColor: Colors.white,
        elevation: 2,
        borderColor: Colors.transparent,
        borderWidth: 1,
        borderRadius: 12,
        margin: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
        hidesUnderline: true,
        isSearchable: false,
      ),
    );
  }

  Widget _buildExperienceDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
      child: FlutterFlowDropDown<String>(
        controller: _model.minExperienceValueController ??= FormFieldController<String>(null),
        options: ['無經驗', '1年以下', '1-3年', '3-5年', '5-10年', '10年以上'],
        onChanged: (val) => setState(() => _model.minExperienceValue = val),
        width: double.infinity,
        height: 50,
        textStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
          color: Color(0xFF1A365D),
        ),
        hintText: '最低經驗要求',
        icon: Icon(
          Icons.timer_outlined,
          color: Color(0xFF2B4C7E),
        ),
        fillColor: Colors.white,
        elevation: 2,
        borderColor: Colors.transparent,
        borderWidth: 1,
        borderRadius: 12,
        margin: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
        hidesUnderline: true,
        isSearchable: false,
      ),
    );
  }

  Widget _buildJobDurationFields(bool isSmallScreen) {
    return isSmallScreen
        ? Column(
      children: [
              _buildDateField(
                label: '開始日期',
                value: _model.startDate,
                onChanged: (date) => setState(() => _model.startDate = date),
        ),
              SizedBox(height: 16),
              _buildDateField(
                label: '結束日期',
                value: _model.endDate,
                onChanged: (date) => setState(() => _model.endDate = date),
              ),
            ],
          )
        : Row(
          children: [
            Expanded(
              child: _buildDateField(
                label: '開始日期',
                value: _model.startDate,
                  onChanged: (date) => setState(() => _model.startDate = date),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildDateField(
                label: '結束日期',
                value: _model.endDate,
                  onChanged: (date) => setState(() => _model.endDate = date),
            ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? value,
    required Function(DateTime?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
      child: Material(
        color: Colors.transparent,
      child: InkWell(
          borderRadius: BorderRadius.circular(12),
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: value ?? DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365 * 2)),
              locale: const Locale('zh', 'HK'),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: FlutterFlowTheme.of(context).primary,
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: Colors.black,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
          );
          if (date != null) {
            onChanged(date);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
                Icon(
                  Icons.calendar_today,
                  color: Color(0xFF2B4C7E),
                  size: 20,
                ),
                SizedBox(width: 12),
              Text(
                value != null
                      ? '${value.year}年${value.month}月${value.day}日'
                    : label,
                style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                      color: value != null
                          ? FlutterFlowTheme.of(context).primaryText
                          : FlutterFlowTheme.of(context).secondaryText,
                        fontWeight: value != null ? FontWeight.w500 : FontWeight.normal,
                    ),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWorkingHoursField(bool isSmallScreen) {
    return isSmallScreen
        ? Column(
      children: [
              _buildTimeField(
                label: '開始時間',
                value: _model.workingHoursStart,
                onChanged: (val) => setState(() => _model.workingHoursStart = val),
        ),
              SizedBox(height: 16),
              _buildTimeField(
                label: '結束時間',
                value: _model.workingHoursEnd,
                onChanged: (val) => setState(() => _model.workingHoursEnd = val),
              ),
            ],
          )
        : Row(
          children: [
            Expanded(
                child: _buildTimeField(
                  label: '開始時間',
                  value: _model.workingHoursStart,
                  onChanged: (val) => setState(() => _model.workingHoursStart = val),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
                child: _buildTimeField(
                  label: '結束時間',
                  value: _model.workingHoursEnd,
                  onChanged: (val) => setState(() => _model.workingHoursEnd = val),
                ),
              ),
            ],
          );
  }

  Widget _buildTimeField({
    required String label,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
                child: FlutterFlowDropDown<String>(
        controller: label == '開始時間'
            ? _model.workingHoursStartController ??= FormFieldController<String>(null)
            : _model.workingHoursEndController ??= FormFieldController<String>(null),
                  options: List.generate(24, (index) {
                    final hour = index.toString().padLeft(2, '0');
          return '  $hour:00';
                  }),
        onChanged: (val) => onChanged(val?.trim()),
                  width: double.infinity,
                  height: 50,
        textStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
              color: Color(0xFF1A365D),
              fontWeight: FontWeight.w500,
            ),
        hintText: '  $label',
                  icon: Icon(
                    Icons.access_time,
                    color: Color(0xFF2B4C7E),
          size: 24,
                  ),
                  fillColor: Colors.white,
                  elevation: 2,
                  borderColor: Colors.transparent,
                  borderWidth: 1,
        borderRadius: 12,
        margin: EdgeInsetsDirectional.fromSTEB(24, 4, 16, 4),
                  hidesUnderline: true,
                  isSearchable: false,
                ),
    );
  }

  Widget _buildLocationField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
      child: FlutterFlowDropDown<String>(
        controller: _model.locationValueController ??= FormFieldController<String>(null),
        options: [
          '香港島',
          '中環',
          '金鐘',
          '灣仔',
          '銅鑼灣',
          '北角',
          '鰂魚涌',
          '太古',
          '西灣河',
          '筲箕灣',
          '柴灣',
          '小西灣',
          '九龍',
          '尖沙咀',
          '佐敦',
          '油麻地',
          '旺角',
          '太子',
          '深水埗',
          '長沙灣',
          '荔枝角',
          '美孚',
          '新界',
          '荃灣',
          '葵涌',
          '青衣',
          '沙田',
          '大圍',
          '馬鞍山',
          '大埔',
          '粉嶺',
          '上水',
          '元朗',
          '屯門',
          '天水圍',
          '將軍澳',
          '調景嶺',
          '坑口',
          '寶琳',
          '康城',
          '離島',
          '東涌',
          '大嶼山',
          '長洲',
          '南丫島',
          '其他'
        ],
        onChanged: (val) => setState(() => _model.locationValue = val),
        width: double.infinity,
        height: 50,
        textStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
          color: Color(0xFF1A365D),
        ),
        hintText: '服務地點',
        icon: Icon(
          Icons.location_on_outlined,
          color: Color(0xFF2B4C7E),
        ),
        fillColor: Colors.white,
        elevation: 2,
        borderColor: Colors.transparent,
        borderWidth: 1,
        borderRadius: 12,
        margin: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
        hidesUnderline: true,
        isSearchable: true,
        searchHintText: '搜尋地區...',
      ),
    );
  }

  Widget _buildCategoriesField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
      padding: EdgeInsets.symmetric(vertical: 8),
      child: CategoriesDropdownWidget(),
    );
  }

  Widget _buildSalarySection(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '酬金類型',
          style: FlutterFlowTheme.of(context).bodyMedium,
        ),
        SizedBox(height: 8),
        _buildSalaryTypeDropdown(),
        SizedBox(height: 16),
        if (!_model.undisclosedSalary) ...[
          if (_model.salaryType == '每更') ...[
            _buildPerShiftField(
              label: '每更酬金',
              value: _model.hourlyRate,
              onChanged: (val) => setState(() => _model.hourlyRate = val),
            ),
          ] else ...[
            _buildHourlyRateField(
              label: '時薪',
              value: _model.hourlyRate,
              onChanged: (val) => setState(() => _model.hourlyRate = val),
            ),
          ],
        ],
        SizedBox(height: 16),
        _buildUndisclosedSalarySwitch(),
      ],
    );
  }

  Widget _buildSalaryTypeDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
      child: FlutterFlowDropDown<String>(
        controller: _model.salaryTypeController ??= FormFieldController<String>(null),
        options: ['每更', '時薪'],
        onChanged: (val) => setState(() => _model.salaryType = val),
        width: double.infinity,
        height: 50,
        textStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
          color: Color(0xFF1A365D),
        ),
        hintText: '請選擇酬金類型',
        icon: Icon(
          Icons.attach_money,
          color: Color(0xFF2B4C7E),
        ),
        fillColor: Colors.white,
        elevation: 2,
        borderColor: Colors.transparent,
        borderWidth: 1,
        borderRadius: 12,
        margin: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
        hidesUnderline: true,
        isSearchable: false,
      ),
    );
  }

  Widget _buildPerShiftField({
    required String label,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
      child: TextFormField(
        controller: _model.hourlyRateController,
        focusNode: _model.hourlyRateFocusNode,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        onChanged: (val) {
          setState(() => _model.hourlyRate = val);
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
            color: Color(0xFF2B4C7E).withOpacity(0.7),
          ),
          hintText: '輸入每更酬金...',
          hintStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
            color: Color(0xFF2B4C7E).withOpacity(0.5),
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
              color: Color(0xFF2B4C7E),
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
            Icons.attach_money,
            color: Color(0xFF2B4C7E),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        style: FlutterFlowTheme.of(context).bodyMedium,
        validator: (val) {
          if (val == null || val.isEmpty) return '請輸入酬金';
          if (double.tryParse(val) == null) return '請輸入有效的數字';
          if (double.parse(val) <= 0) return '酬金必須大於0';
          return null;
        },
      ),
    );
  }

  Widget _buildHourlyRateField({
    required String label,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
      child: TextFormField(
        controller: _model.hourlyRateController,
        focusNode: _model.hourlyRateFocusNode,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        onChanged: (val) {
          setState(() => _model.hourlyRate = val);
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
            color: Color(0xFF2B4C7E).withOpacity(0.7),
          ),
          hintText: '輸入時薪...',
          hintStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
            color: Color(0xFF2B4C7E).withOpacity(0.5),
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
          color: Color(0xFF2B4C7E),
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
          Icons.attach_money,
          color: Color(0xFF2B4C7E),
        ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        style: FlutterFlowTheme.of(context).bodyMedium,
        validator: (val) {
          if (val == null || val.isEmpty) return '請輸入時薪';
          if (double.tryParse(val) == null) return '請輸入有效的數字';
          if (double.parse(val) <= 0) return '時薪必須大於0';
          return null;
        },
      ),
    );
  }

  Widget _buildUndisclosedSalarySwitch() {
    return SwitchListTile(
      value: _model.undisclosedSalary,
      onChanged: (newValue) {
        setState(() => _model.undisclosedSalary = newValue);
      },
      title: Text(
        '酬金面議',
        style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
          color: Color(0xFF1A365D),
        ),
      ),
      activeColor: FlutterFlowTheme.of(context).primary,
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _buildApplicationLinkField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
      child: TextFormField(
        controller: _model.appLinkTextFieldTextController,
        focusNode: _model.appLinkTextFieldFocusNode,
        obscureText: false,
        decoration: InputDecoration(
          labelText: '申請連結',
          labelStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: Color(0xFF2B4C7E).withOpacity(0.7),
              ),
          hintText: '請輸入申請連結（選填）',
          hintStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                color: Color(0xFF2B4C7E).withOpacity(0.5),
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
              color: Color(0xFF2B4C7E),
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
            Icons.link_outlined,
            color: Color(0xFF2B4C7E),
          ),
        ),
        style: FlutterFlowTheme.of(context).bodyMedium,
        keyboardType: TextInputType.url,
        validator: _model.appLinkTextFieldTextControllerValidator.asValidator(context),
      ),
    );
  }

  Widget _buildCoverLetterSwitch() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
      child: SwitchListTile(
        value: _model.coverLetterSwitchValue ??= true,
        onChanged: (newValue) async {
          setState(() => _model.coverLetterSwitchValue = newValue);
        },
        title: Text(
          '需要求職信',
          style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
            color: Color(0xFF1A365D),
          ),
        ),
        activeColor: FlutterFlowTheme.of(context).primary,
        dense: true,
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  Widget _buildDeadlineField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
      child: InkWell(
        onTap: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: _model.deadlineDate ?? DateTime.now().add(Duration(days: 1)),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365)),
            locale: const Locale('zh', 'HK'),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: FlutterFlowTheme.of(context).primary,
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: Colors.black,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );
          if (pickedDate != null) {
            setState(() {
              _model.deadlineDate = pickedDate;
            });
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Color(0xFF2B4C7E),
                size: 20,
              ),
              SizedBox(width: 12),
              Text(
                _model.deadlineDate != null
                    ? '${_model.deadlineDate!.year}年${_model.deadlineDate!.month}月${_model.deadlineDate!.day}日'
                    : '申請截止日期',
                style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                      color: _model.deadlineDate != null
                          ? Color(0xFF1A365D)
                          : Color(0xFF2B4C7E).withOpacity(0.5),
                      fontWeight: _model.deadlineDate != null ? FontWeight.w500 : FontWeight.normal,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return FFButtonWidget(
      onPressed: () async {
        if (_model.formKey.currentState?.validate() ?? false) {
          logFirebaseEvent('POST_JOB_SUBMIT_BUTTON');
          
          // Validate salary if not undisclosed
          if (!_model.undisclosedSalary) {
            if (_model.salaryType == '月薪') {
              double minSalary = _getSalaryValue(_model.minSalaryValue ?? '25,000以下');
              double maxSalary = _getSalaryValue(_model.maxSalaryValue ?? '25,000以下', isMaximum: true);

              if (maxSalary <= minSalary) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('最高酬金必須大於最低酬金'),
                    backgroundColor: FlutterFlowTheme.of(context).error,
            ),
          );
                return;
              }
            }
          }

          try {
            // Create job record
            final jobRef = JobsRecord.collection.doc();
            final jobData = createJobsRecordData(
              position: _model.jobPosValue ?? '',
              description: _model.jobDescriptionTextController.text,
              requirements: _model.requirementsTextController.text,
              minExperience: _getExperienceYears(_model.minExperienceValue ?? '無經驗'),
              type: _model.jobTypeValue,
              location: _model.locationValue ?? '',
              salaryMinimum: _model.undisclosedSalary 
                ? null 
                : _model.salaryType == '月薪'
                  ? _getSalaryValue(_model.minSalaryValue ?? '25,000以下')
                  : _getHourlyRateValue(_model.hourlyRate),
              salaryMaximum: _model.undisclosedSalary 
                ? null 
                : _model.salaryType == '月薪'
                  ? _getSalaryValue(_model.maxSalaryValue ?? '25,000以下', isMaximum: true)
                  : _getHourlyRateValue(_model.hourlyRate),
              salaryType: _model.salaryType ?? '月薪',
              applicationLink: _model.appLinkTextFieldTextController.text,
              requiresCoverLetter: _model.coverLetterSwitchValue ?? true,
              closingDate: _model.deadlineDate,
              status: 'Active',
              companyName: currentUserDisplayName,
              companyRef: currentUserReference,
              discoverable: true,
              categoryRefs: _model.categoriesDropdownModel?.dropDownValue ?? [],
              startDate: _model.startDate,
              endDate: _model.endDate,
              workingHours: _model.workingHoursStart != null && _model.workingHoursEnd != null 
                ? '${_model.workingHoursStart} - ${_model.workingHoursEnd}'
                : null,
              timeCreated: DateTime.now(),
            );

            await jobRef.set(mapToFirestore({
              ...jobData,
                'created_at': FieldValue.serverTimestamp(),
            }));

            // Show success message and navigate
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('服務崗位已成功發布'),
                backgroundColor: FlutterFlowTheme.of(context).success,
              ),
            );

            context.goNamed('companyJobListings');
          } catch (e) {
            print('Error creating job: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('發布服務崗位時發生錯誤'),
                backgroundColor: FlutterFlowTheme.of(context).error,
              ),
            );
          }
        }
      },
      text: '發布服務崗位',
      options: FFButtonOptions(
        width: double.infinity,
        height: 50,
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: Color(0xFF1A365D),
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
        elevation: 3,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  int _getExperienceYears(String experience) {
    switch (experience) {
      case '無經驗':
        return 0;
      case '1年以下':
        return 1;
      case '1-3年':
        return 2;
      case '3-5年':
        return 4;
      case '5-10年':
        return 7;
      case '10年以上':
        return 10;
      default:
        return 0;
    }
  }

  double _getSalaryValue(String salary, {bool isMaximum = false}) {
    // Handle empty or null values
    if (salary.isEmpty) return 0.0;

    // Remove commas and spaces
    salary = salary.replaceAll(',', '').replaceAll(' ', '');

    // Handle special cases
    if (salary.contains('以下')) {
      final value = double.tryParse(salary.replaceAll('以下', '')) ?? 0.0;
      return isMaximum ? value : 0.0;
    }
    if (salary.contains('以上')) {
      final value = double.tryParse(salary.replaceAll('以上', '')) ?? 0.0;
      return isMaximum ? double.infinity : value;
    }

    // Handle ranges (e.g., "25000-30000")
    final parts = salary.split('-');
    if (parts.length == 2) {
      final minValue = double.tryParse(parts[0]) ?? 0.0;
      final maxValue = double.tryParse(parts[1]) ?? 0.0;
      return isMaximum ? maxValue : minValue;
    }

    // If all else fails, try to parse the string directly
    return double.tryParse(salary) ?? 0.0;
  }

  double _getHourlyRateValue(String? rate) {
    if (rate == null || rate.isEmpty) return 0.0;
    
    // Remove any non-numeric characters except decimal point
    final cleanRate = rate.replaceAll(RegExp(r'[^0-9.]'), '');
    
    // Parse the rate and ensure it's positive
    final parsedRate = double.tryParse(cleanRate) ?? 0.0;
    return parsedRate > 0 ? parsedRate : 0.0;
  }
}
