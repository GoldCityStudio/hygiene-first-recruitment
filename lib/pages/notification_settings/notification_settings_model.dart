import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'notification_settings_widget.dart' show NotificationSettingsWidget;
import 'package:flutter/material.dart';

class NotificationSettingsModel
    extends FlutterFlowModel<NotificationSettingsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for SwitchListTilePushNotif widget.
  bool? switchListTilePushNotifValue;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for SwitchListTileEmailNotif widget.
  bool? switchListTileEmailNotifValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
