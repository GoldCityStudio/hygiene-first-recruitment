import '/components/dark_light_switch/dark_light_switch_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'profile_widget.dart' show ProfileWidget;
import 'package:flutter/material.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for darkLightSwitch component.
  late DarkLightSwitchModel darkLightSwitchModel;
  
  // State fields for notification settings
  bool pushNotificationsEnabled = true;
  bool emailNotificationsEnabled = true;

  @override
  void initState(BuildContext context) {
    darkLightSwitchModel = createModel(context, () => DarkLightSwitchModel());
  }

  @override
  void dispose() {
    darkLightSwitchModel.dispose();
  }
}
