import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'modal_edit_profile_widget.dart';

class ModalEditProfileModel extends FlutterFlowModel<ModalEditProfileWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  late BuildContext context;
  // State field(s) for fullName widget.
  TextEditingController? fullNameTextController;
  String? Function(String?)? fullNameTextControllerValidator;
  FocusNode? fullNameFocusNode;
  // State field(s) for chineseName widget.
  TextEditingController? chineseNameTextController;
  String? Function(String?)? chineseNameTextControllerValidator;
  FocusNode? chineseNameFocusNode;
  // State field(s) for gender widget.
  String? genderDropDownValue;
  FormFieldController<String>? genderDropDownController;
  // State field(s) for dateOfBirth widget.
  TextEditingController? dateOfBirthTextController;
  String? Function(String?)? dateOfBirthTextControllerValidator;
  FocusNode? dateOfBirthFocusNode;
  DateTime? dateOfBirth;
  // State field(s) for address widget.
  TextEditingController? addressTextController;
  String? Function(String?)? addressTextControllerValidator;
  FocusNode? addressFocusNode;
  // State field(s) for phoneNumber widget.
  TextEditingController? phoneNumberTextController;
  String? Function(String?)? phoneNumberTextControllerValidator;
  FocusNode? phoneNumberFocusNode;
  // State field(s) for whatsappNumber widget.
  TextEditingController? whatsappNumberTextController;
  String? Function(String?)? whatsappNumberTextControllerValidator;
  FocusNode? whatsappNumberFocusNode;
  // State field(s) for currentPosition widget.
  TextEditingController? currentPositionTextController;
  String? Function(String?)? currentPositionTextControllerValidator;
  FocusNode? currentPositionFocusNode;
  // State field(s) for currentCompany widget.
  TextEditingController? currentCompanyTextController;
  String? Function(String?)? currentCompanyTextControllerValidator;
  FocusNode? currentCompanyFocusNode;
  // State field(s) for expectedSalary widget.
  TextEditingController? expectedSalaryTextController;
  String? Function(String?)? expectedSalaryTextControllerValidator;
  FocusNode? expectedSalaryFocusNode;
  // State field(s) for noticePeriod widget.
  TextEditingController? noticePeriodTextController;
  String? Function(String?)? noticePeriodTextControllerValidator;
  FocusNode? noticePeriodFocusNode;
  // State field(s) for preferredLocations widget.
  TextEditingController? preferredLocationsTextController;
  String? Function(String?)? preferredLocationsTextControllerValidator;
  FocusNode? preferredLocationsFocusNode;
  // State field(s) for preferredIndustries widget.
  TextEditingController? preferredIndustriesTextController;
  String? Function(String?)? preferredIndustriesTextControllerValidator;
  FocusNode? preferredIndustriesFocusNode;
  // State field(s) for preferredJobTypes widget.
  TextEditingController? preferredJobTypesTextController;
  String? Function(String?)? preferredJobTypesTextControllerValidator;
  FocusNode? preferredJobTypesFocusNode;
  // State field(s) for workSchedule widget.
  TextEditingController? workScheduleTextController;
  String? Function(String?)? workScheduleTextControllerValidator;
  FocusNode? workScheduleFocusNode;
  // State field(s) for skills widget.
  TextEditingController? skillsTextController;
  String? Function(BuildContext, String?)? skillsTextControllerValidator;
  FocusNode? skillsFocusNode;
  // State field(s) for languages widget.
  TextEditingController? languagesTextController;
  String? Function(BuildContext, String?)? languagesTextControllerValidator;
  FocusNode? languagesFocusNode;
  // State field(s) for certifications widget.
  TextEditingController? certificationsTextController;
  String? Function(BuildContext, String?)? certificationsTextControllerValidator;
  FocusNode? certificationsFocusNode;
  // State field(s) for education widget.
  TextEditingController? educationTextController;
  String? Function(BuildContext, String?)? educationTextControllerValidator;
  FocusNode? educationFocusNode;
  // State field(s) for websiteEdit widget.
  TextEditingController? websiteEditTextController;
  String? Function(BuildContext, String?)? websiteEditTextControllerValidator;
  FocusNode? websiteEditFocusNode;
  // State field(s) for bio widget.
  TextEditingController? bioTextController;
  String? Function(BuildContext, String?)? bioTextControllerValidator;
  FocusNode? bioFocusNode;
  // State field(s) for uploadedFile1 widget.
  bool isDataUploading = false;
  FFUploadedFile? uploadedLocalFile1;
  String? uploadedFileUrl1;
  // State field(s) for uploadedFile2 widget.
  bool isDataUploading2 = false;
  FFUploadedFile? uploadedLocalFile2;
  String? uploadedFileUrl2;
  // State field(s) for uploadedFile3 widget.
  bool isDataUploading3 = false;
  List<FFUploadedFile> uploadedLocalFiles3 = [];
  List<String> uploadedFileUrls3 = [];
  // State field(s) for exp widget.
  String? expDropDownValue;
  FormFieldController<String>? expDropDownValueController;
  // State field(s) for location widget.
  String? locationDropDownValue;
  FormFieldController<String>? locationDropDownValueController;
  // State field(s) for language widget.
  String? languageDropDownValue;
  FormFieldController<String>? languageDropDownValueController;
  // State field(s) for selected languages
  List<String> selectedLanguages = [];
  // State field(s) for expertise
  String? expertiseDropDownValue;
  FormFieldController<String>? expertiseDropDownController;
  // State field(s) for credentials
  TextEditingController? credentialsTextController;
  String? Function(BuildContext, String?)? credentialsTextControllerValidator;
  String? _credentialsTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入專業資格';
    }
    return null;
  }
  FocusNode? credentialsFocusNode;
  // State field(s) for selectedSkills widget.
  List<String> selectedSkills = [];
  // State field(s) for trimOutput widget.
  String? trimOutput;
  // State field(s) for currentSection widget.
  int currentSection = 1;
  // State field(s) for street widget.
  TextEditingController? streetTextController;
  String? Function(String?)? streetTextControllerValidator;
  FocusNode? streetFocusNode;
  // State field(s) for building widget.
  TextEditingController? buildingTextController;
  String? Function(String?)? buildingTextControllerValidator;
  FocusNode? buildingFocusNode;
  // State field(s) for floor widget.
  TextEditingController? floorTextController;
  String? Function(String?)? floorTextControllerValidator;
  FocusNode? floorFocusNode;
  // State field(s) for room number widget.
  TextEditingController? roomNumberTextController;
  String? Function(String?)? roomNumberTextControllerValidator;
  FocusNode? roomNumberFocusNode;
  // State field(s) for district dropdown.
  String? districtDropDownValue;
  FormFieldController<String>? districtDropDownController;
  // State field(s) for how know dropdown.
  String? howKnowDropDownValue;
  FormFieldController<String>? howKnowDropDownController;
  // State fields
  String? uploadedFileUrlCredentials;
  String? uploadedFileUrlIdCard;
  String? uploadedFileUrlOtherDocs;
  FFUploadedFile? uploadedLocalFileCredentials;
  FFUploadedFile? uploadedLocalFileIdCard;
  FFUploadedFile? uploadedLocalFileOtherDocs;

  // File Upload Variables
  String? uploadedFileUrlPhoto;
  FFUploadedFile? uploadedLocalFilePhoto;

  /// Initialization and disposal methods.

  void initState(BuildContext ctx) {
    context = ctx;
    fullNameTextControllerValidator = _fullNameTextControllerValidator;
    chineseNameTextControllerValidator = _chineseNameTextControllerValidator;
    dateOfBirthTextControllerValidator = _dateOfBirthTextControllerValidator;
    addressTextControllerValidator = _addressTextControllerValidator;
    phoneNumberTextControllerValidator = _phoneNumberTextControllerValidator;
    whatsappNumberTextControllerValidator = _whatsappNumberTextControllerValidator;
    currentPositionTextControllerValidator = _currentPositionTextControllerValidator;
    currentCompanyTextControllerValidator = _currentCompanyTextControllerValidator;
    preferredLocationsTextControllerValidator = _preferredLocationsTextControllerValidator;
    preferredIndustriesTextControllerValidator = _preferredIndustriesTextControllerValidator;
    preferredJobTypesTextControllerValidator = _preferredJobTypesTextControllerValidator;
    workScheduleTextControllerValidator = _workScheduleTextControllerValidator;
    streetTextControllerValidator = _streetTextControllerValidator;
    buildingTextControllerValidator = _buildingTextControllerValidator;
    floorTextControllerValidator = _floorTextControllerValidator;
    roomNumberTextControllerValidator = _roomNumberTextControllerValidator;
    credentialsTextControllerValidator = _credentialsTextControllerValidator;

    // Initialize dropdown controllers
    genderDropDownController = FormFieldController<String>(genderDropDownValue);
    districtDropDownController = FormFieldController<String>(districtDropDownValue);
    expertiseDropDownController = FormFieldController<String>(expertiseDropDownValue);
    howKnowDropDownController = FormFieldController<String>(howKnowDropDownValue);
    expDropDownValueController = FormFieldController<String>(expDropDownValue);
    locationDropDownValueController = FormFieldController<String>(locationDropDownValue);
    languageDropDownValueController = FormFieldController<String>(languageDropDownValue);

    // Initialize text controllers
    fullNameTextController ??= TextEditingController();
    chineseNameTextController ??= TextEditingController();
    dateOfBirthTextController ??= TextEditingController();
    addressTextController ??= TextEditingController();
    phoneNumberTextController ??= TextEditingController();
    whatsappNumberTextController ??= TextEditingController();
    currentPositionTextController ??= TextEditingController();
    currentCompanyTextController ??= TextEditingController();
    expectedSalaryTextController ??= TextEditingController();
    noticePeriodTextController ??= TextEditingController();
    preferredLocationsTextController ??= TextEditingController();
    preferredIndustriesTextController ??= TextEditingController();
    preferredJobTypesTextController ??= TextEditingController();
    workScheduleTextController ??= TextEditingController();
    streetTextController ??= TextEditingController();
    buildingTextController ??= TextEditingController();
    floorTextController ??= TextEditingController();
    roomNumberTextController ??= TextEditingController();
    credentialsTextController ??= TextEditingController();

    // Initialize focus nodes
    fullNameFocusNode ??= FocusNode();
    chineseNameFocusNode ??= FocusNode();
    dateOfBirthFocusNode ??= FocusNode();
    addressFocusNode ??= FocusNode();
    phoneNumberFocusNode ??= FocusNode();
    whatsappNumberFocusNode ??= FocusNode();
    currentPositionFocusNode ??= FocusNode();
    currentCompanyFocusNode ??= FocusNode();
    expectedSalaryFocusNode ??= FocusNode();
    noticePeriodFocusNode ??= FocusNode();
    preferredLocationsFocusNode ??= FocusNode();
    preferredIndustriesFocusNode ??= FocusNode();
    preferredJobTypesFocusNode ??= FocusNode();
    workScheduleFocusNode ??= FocusNode();
    streetFocusNode ??= FocusNode();
    buildingFocusNode ??= FocusNode();
    floorFocusNode ??= FocusNode();
    roomNumberFocusNode ??= FocusNode();
    credentialsFocusNode ??= FocusNode();

    uploadedFileUrlPhoto = widget?.userDoc?.photoUrl;
    uploadedFileUrlIdCard = widget?.userDoc?.idCardUrl;
    uploadedFileUrlCredentials = widget?.userDoc?.credentials;
  }

  void dispose() {
    fullNameTextController?.dispose();
    fullNameFocusNode?.dispose();
    chineseNameTextController?.dispose();
    chineseNameFocusNode?.dispose();
    dateOfBirthTextController?.dispose();
    dateOfBirthFocusNode?.dispose();
    addressTextController?.dispose();
    addressFocusNode?.dispose();
    phoneNumberTextController?.dispose();
    phoneNumberFocusNode?.dispose();
    whatsappNumberTextController?.dispose();
    whatsappNumberFocusNode?.dispose();
    currentPositionTextController?.dispose();
    currentPositionFocusNode?.dispose();
    currentCompanyTextController?.dispose();
    currentCompanyFocusNode?.dispose();
    preferredLocationsTextController?.dispose();
    preferredLocationsFocusNode?.dispose();
    preferredIndustriesTextController?.dispose();
    preferredIndustriesFocusNode?.dispose();
    preferredJobTypesTextController?.dispose();
    preferredJobTypesFocusNode?.dispose();
    workScheduleTextController?.dispose();
    workScheduleFocusNode?.dispose();
    skillsTextController?.dispose();
    skillsFocusNode?.dispose();
    languagesTextController?.dispose();
    languagesFocusNode?.dispose();
    certificationsTextController?.dispose();
    certificationsFocusNode?.dispose();
    educationTextController?.dispose();
    educationFocusNode?.dispose();
    websiteEditTextController?.dispose();
    websiteEditFocusNode?.dispose();
    bioTextController?.dispose();
    bioFocusNode?.dispose();
    credentialsTextController?.dispose();
    credentialsFocusNode?.dispose();
    languageDropDownValueController?.dispose();
    expertiseDropDownController?.dispose();
    streetTextController?.dispose();
    streetFocusNode?.dispose();
    buildingTextController?.dispose();
    buildingFocusNode?.dispose();
    floorTextController?.dispose();
    floorFocusNode?.dispose();
    roomNumberTextController?.dispose();
    roomNumberFocusNode?.dispose();
    districtDropDownController?.dispose();
    howKnowDropDownController?.dispose();
  }

  /// Action blocks are added here.

  Map<String, dynamic> createUsersRecordData() {
    return mapToFirestore(
      {
        'email': currentUserEmail,
        'displayName': currentCompanyTextController?.text,
        'phone_number': phoneNumberTextController?.text,
        'photoUrl': uploadedFileUrl1,
        'uid': currentUserUid,
        'createdTime': FieldValue.serverTimestamp(),
        'bio': bioTextController?.text,
        'title': currentPositionTextController?.text,
        'location': locationDropDownValue,
        'type': genderDropDownValue,
        'companySize': expDropDownValue,
        'industry': preferredIndustriesTextController?.text,
        'website': websiteEditTextController?.text,
        'linkedin': 'linkedinTextController.text',
        'facebook': 'facebookTextController.text',
        'twitter': 'twitterTextController.text',
        'instagram': 'instagramTextController.text',
        'youtube': 'youtubeTextController.text',
        'tiktok': 'tiktokTextController.text',
        'credentials': credentialsTextController?.text,
        'experience': expectedSalaryTextController?.text,
        'education': educationTextController?.text,
        'skills': selectedSkills,
        'languages': selectedLanguages,
        'preferences': preferredLocationsTextController?.text,
        'notifications': noticePeriodTextController?.text,
      },
    );
  }

  Future<void> saveChanges() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      await currentUserReference!.update(createUsersRecordData());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('個人資料已成功更新'),
          duration: Duration(seconds: 2),
        ),
      );

      // Close the modal and let the profile page handle the refresh
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('更新失敗：${e.toString()}'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  /// Additional helper methods are added here.

  String? _fullNameTextControllerValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入姓名';
    }
    return null;
  }

  String? _phoneNumberTextControllerValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入電話號碼';
    }
    if (!RegExp(r'^\d{8}$').hasMatch(val)) {
      return '請輸入有效的8位電話號碼';
    }
    return null;
  }

  String? _whatsappNumberTextControllerValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入WhatsApp號碼';
    }
    if (!RegExp(r'^\d{8}$').hasMatch(val)) {
      return '請輸入有效的8位WhatsApp號碼';
    }
    return null;
  }

  String? _currentPositionTextControllerValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入現職';
    }
    return null;
  }

  String? _currentCompanyTextControllerValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入現職公司';
    }
    return null;
  }

  String? _preferredLocationsTextControllerValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入偏好服務地點';
    }
    return null;
  }

  String? _preferredIndustriesTextControllerValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入偏好行業';
    }
    return null;
  }

  String? _preferredJobTypesTextControllerValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入偏好工作類型';
    }
    return null;
  }

  String? _workScheduleTextControllerValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入工作時間';
    }
    return null;
  }

  String? _streetTextControllerValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入街道';
    }
    return null;
  }

  String? _buildingTextControllerValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入大廈';
    }
    return null;
  }

  String? _floorTextControllerValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入樓層';
    }
    return null;
  }

  String? _roomNumberTextControllerValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入房號';
    }
    return null;
  }

  // Additional validator functions
  String? _chineseNameTextControllerValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入中文姓名';
    }
    return null;
  }

  String? _dateOfBirthTextControllerValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入出生日期';
    }
    return null;
  }

  String? _addressTextControllerValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '請輸入地址';
    }
    return null;
  }
}
