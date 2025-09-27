import 'dart:async';

import 'serialization_util.dart';
import '/backend/backend.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: Colors.transparent,
          child: Image.asset(
            'assets/images/HYG014---MOBILE---Layout-03d.jpg',
            fit: BoxFit.cover,
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'registration': ParameterData.none(),
  'onboarding': ParameterData.none(),
  'home': ParameterData.none(),
  'forgotPassword': ParameterData.none(),
  'login': ParameterData.none(),
  'createProfile': (data) async => ParameterData(
        allParams: {
          'googleOAuth': getParameter<bool>(data, 'googleOAuth'),
        },
      ),
  'createProfileIndividual': (data) async => ParameterData(
        allParams: {
          'googleOAuth': getParameter<bool>(data, 'googleOAuth'),
        },
      ),
  'createProfileCompany': ParameterData.none(),
  'profile': ParameterData.none(),
  'postJob': ParameterData.none(),
  'search': ParameterData.none(),
  'createApplication': (data) async => ParameterData(
        allParams: {
          'jobPostDetails':
              getParameter<DocumentReference>(data, 'jobPostDetails'),
          'position': getParameter<String>(data, 'position'),
          'compName': getParameter<String>(data, 'compName'),
          'compRefDoc': getParameter<DocumentReference>(data, 'compRefDoc'),
          'requiresCoverLetter':
              getParameter<bool>(data, 'requiresCoverLetter'),
        },
      ),
  'companyProfile': (data) async => ParameterData(
        allParams: {
          'compID': getParameter<DocumentReference>(data, 'compID'),
        },
      ),
  'viewApplication': (data) async => ParameterData(
        allParams: {
          'candidateDetails':
              getParameter<DocumentReference>(data, 'candidateDetails'),
          'applicationRef':
              getParameter<DocumentReference>(data, 'applicationRef'),
          'jobRef': getParameter<DocumentReference>(data, 'jobRef'),
        },
      ),
  'applicantsList': (data) async => ParameterData(
        allParams: {
          'jobPostDetails':
              getParameter<DocumentReference>(data, 'jobPostDetails'),
        },
      ),
  'savedJobs': (data) async => ParameterData(
        allParams: {
          'page': getParameter<int>(data, 'page'),
        },
      ),
  'companyJobListings': ParameterData.none(),
  'jobDetails': (data) async => ParameterData(
        allParams: {
          'jobPostDetails':
              getParameter<DocumentReference>(data, 'jobPostDetails'),
        },
      ),
  'notifications': ParameterData.none(),
  'feedback': ParameterData.none(),
  'editJob': (data) async => ParameterData(
        allParams: {
          'jobRef': getParameter<DocumentReference>(data, 'jobRef'),
        },
      ),
  'jobsByCategory': (data) async => ParameterData(
        allParams: {
          'categoryRef': getParameter<DocumentReference>(data, 'categoryRef'),
          'categoryName': getParameter<String>(data, 'categoryName'),
        },
      ),
  'notificationSettings': ParameterData.none(),
  'settingsList': (data) async => ParameterData(
        allParams: {
          'pageRoute': getParameter<String>(data, 'pageRoute'),
        },
      ),
  'shortlistMembers': (data) async => ParameterData(
        allParams: {
          'jobRef': getParameter<DocumentReference>(data, 'jobRef'),
          'position': getParameter<String>(data, 'position'),
        },
      ),
  'shortlist': ParameterData.none(),
  'forceUpdate': ParameterData.none(),
  'legal': (data) async => ParameterData(
        allParams: {
          'route': getParameter<String>(data, 'route'),
        },
      ),
  'guest': ParameterData.none(),
  'underMaintenance': ParameterData.none(),
  'homeCopy': ParameterData.none(),
  'applicantsListCopy': (data) async => ParameterData(
        allParams: {
          'jobPostDetails':
              getParameter<DocumentReference>(data, 'jobPostDetails'),
        },
      ),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
