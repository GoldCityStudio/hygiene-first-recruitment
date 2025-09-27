import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '/auth/base_auth_user_provider.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/main.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/company_dashboard/company_dashboard_widget.dart';
import '/pages/statistics_dashboard/statistics_dashboard_widget.dart';
import '/pages/check_in_management/check_in_management_widget.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';
export '/backend/firebase_dynamic_links/firebase_dynamic_links.dart'
    show generateCurrentPageLink;

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => _RouteErrorBuilder(
        state: state,
        child: appStateNotifier.loggedIn ? NavBarPage() : OnboardingWidget(),
      ),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? NavBarPage() : OnboardingWidget(),
          routes: [
            FFRoute(
              name: RegistrationWidget.routeName,
              path: RegistrationWidget.routePath,
              builder: (context, params) => RegistrationWidget(),
            ),
            FFRoute(
              name: OnboardingWidget.routeName,
              path: OnboardingWidget.routePath,
              builder: (context, params) => OnboardingWidget(),
            ),
            FFRoute(
              name: HomeWidget.routeName,
              path: HomeWidget.routePath,
              requireAuth: true,
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'home')
                  : HomeWidget(),
            ),
            FFRoute(
              name: ForgotPasswordWidget.routeName,
              path: ForgotPasswordWidget.routePath,
              builder: (context, params) => ForgotPasswordWidget(),
            ),
            FFRoute(
              name: LoginWidget.routeName,
              path: LoginWidget.routePath,
              builder: (context, params) => LoginWidget(),
            ),
            FFRoute(
              name: CreateProfileWidget.routeName,
              path: CreateProfileWidget.routePath,
              requireAuth: true,
              builder: (context, params) => CreateProfileWidget(
                googleOAuth: params.getParam(
                  'googleOAuth',
                  ParamType.bool,
                ),
              ),
            ),
            FFRoute(
              name: CreateProfileIndividualWidget.routeName,
              path: CreateProfileIndividualWidget.routePath,
              requireAuth: true,
              builder: (context, params) => CreateProfileIndividualWidget(
                googleOAuth: params.getParam(
                  'googleOAuth',
                  ParamType.bool,
                ),
              ),
            ),
            FFRoute(
              name: CreateProfileCompanyWidget.routeName,
              path: CreateProfileCompanyWidget.routePath,
              requireAuth: true,
              builder: (context, params) => CreateProfileCompanyWidget(),
            ),
            FFRoute(
              name: ProfileWidget.routeName,
              path: ProfileWidget.routePath,
              requireAuth: true,
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'profile')
                  : ProfileWidget(),
            ),
            FFRoute(
              name: PostJobWidget.routeName,
              path: PostJobWidget.routePath,
              requireAuth: true,
              builder: (context, params) => PostJobWidget(),
            ),
            FFRoute(
              name: SearchWidget.routeName,
              path: SearchWidget.routePath,
              requireAuth: true,
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'search')
                  : SearchWidget(),
            ),
            FFRoute(
              name: CreateApplicationWidget.routeName,
              path: CreateApplicationWidget.routePath,
              requireAuth: true,
              builder: (context, params) => CreateApplicationWidget(
                jobPostDetails: params.getParam(
                  'jobPostDetails',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['jobs'],
                ),
                position: params.getParam(
                  'position',
                  ParamType.String,
                ),
                compName: params.getParam(
                  'compName',
                  ParamType.String,
                ),
                compRefDoc: params.getParam(
                  'compRefDoc',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['users'],
                ),
                requiresCoverLetter: params.getParam(
                  'requiresCoverLetter',
                  ParamType.bool,
                ),
              ),
            ),
            FFRoute(
              name: CompanyProfileWidget.routeName,
              path: CompanyProfileWidget.routePath,
              requireAuth: true,
              builder: (context, params) => CompanyProfileWidget(
                compID: params.getParam(
                  'compID',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['users'],
                ),
              ),
            ),
            FFRoute(
              name: ViewApplicationWidget.routeName,
              path: ViewApplicationWidget.routePath,
              requireAuth: true,
              builder: (context, params) => ViewApplicationWidget(
                candidateDetails: params.getParam(
                  'candidateDetails',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['users'],
                ),
                applicationRef: params.getParam(
                  'applicationRef',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['applications'],
                ),
                jobRef: params.getParam(
                  'jobRef',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['jobs'],
                ),
              ),
            ),
            FFRoute(
              name: ApplicantsListWidget.routeName,
              path: ApplicantsListWidget.routePath,
              requireAuth: true,
              builder: (context, params) => ApplicantsListWidget(
                jobPostDetails: params.getParam(
                  'jobPostDetails',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['jobs'],
                ),
              ),
            ),
            FFRoute(
              name: SavedJobsWidget.routeName,
              path: SavedJobsWidget.routePath,
              requireAuth: true,
              builder: (context, params) => SavedJobsWidget(
                page: params.getParam(
                  'page',
                  ParamType.int,
                ),
              ),
            ),
            FFRoute(
              name: CompanyJobListingsWidget.routeName,
              path: CompanyJobListingsWidget.routePath,
              requireAuth: true,
              builder: (context, params) => CompanyJobListingsWidget(),
            ),
            FFRoute(
              name: JobDetailsWidget.routeName,
              path: JobDetailsWidget.routePath,
              requireAuth: true,
              builder: (context, params) => JobDetailsWidget(
                jobPostDetails: params.getParam(
                  'jobPostDetails',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['jobs'],
                ),
              ),
            ),
            FFRoute(
              name: NotificationsWidget.routeName,
              path: NotificationsWidget.routePath,
              requireAuth: true,
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'notifications')
                  : NotificationsWidget(),
            ),
            FFRoute(
              name: FeedbackWidget.routeName,
              path: FeedbackWidget.routePath,
              builder: (context, params) => FeedbackWidget(),
            ),
            FFRoute(
              name: EditJobWidget.routeName,
              path: EditJobWidget.routePath,
              requireAuth: true,
              builder: (context, params) => EditJobWidget(
                jobRef: params.getParam(
                  'jobRef',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['jobs'],
                ),
              ),
            ),
            FFRoute(
              name: JobsByCategoryWidget.routeName,
              path: JobsByCategoryWidget.routePath,
              requireAuth: true,
              builder: (context, params) => JobsByCategoryWidget(
                categoryRef: params.getParam(
                  'categoryRef',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['categories'],
                ),
                categoryName: params.getParam(
                  'categoryName',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: NotificationSettingsWidget.routeName,
              path: NotificationSettingsWidget.routePath,
              requireAuth: true,
              builder: (context, params) => NotificationSettingsWidget(),
            ),
            FFRoute(
              name: SettingsListWidget.routeName,
              path: SettingsListWidget.routePath,
              requireAuth: true,
              builder: (context, params) => SettingsListWidget(
                pageRoute: params.getParam(
                  'pageRoute',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: ShortlistMembersWidget.routeName,
              path: ShortlistMembersWidget.routePath,
              requireAuth: true,
              builder: (context, params) => ShortlistMembersWidget(
                jobRef: params.getParam(
                  'jobRef',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['jobs'],
                ),
                position: params.getParam(
                  'position',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: ShortlistWidget.routeName,
              path: ShortlistWidget.routePath,
              requireAuth: true,
              builder: (context, params) => ShortlistWidget(),
            ),
            FFRoute(
              name: ForceUpdateWidget.routeName,
              path: ForceUpdateWidget.routePath,
              builder: (context, params) => ForceUpdateWidget(),
            ),
            FFRoute(
              name: LegalWidget.routeName,
              path: LegalWidget.routePath,
              builder: (context, params) => LegalWidget(
                route: params.getParam(
                  'route',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: GuestWidget.routeName,
              path: GuestWidget.routePath,
              builder: (context, params) => GuestWidget(),
            ),
            FFRoute(
              name: UnderMaintenanceWidget.routeName,
              path: UnderMaintenanceWidget.routePath,
              builder: (context, params) => UnderMaintenanceWidget(),
            ),
            FFRoute(
              name: HomeCopyWidget.routeName,
              path: HomeCopyWidget.routePath,
              builder: (context, params) => HomeCopyWidget(),
            ),
            FFRoute(
              name: ApplicantsListCopyWidget.routeName,
              path: ApplicantsListCopyWidget.routePath,
              requireAuth: true,
              builder: (context, params) => ApplicantsListCopyWidget(
                jobPostDetails: params.getParam(
                  'jobPostDetails',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['jobs'],
                ),
              ),
            ),
            FFRoute(
              name: CompanyDashboardWidget.routeName,
              path: CompanyDashboardWidget.routePath,
              requireAuth: true,
              builder: (context, params) => CompanyDashboardWidget(),
            ),
            FFRoute(
              name: 'statistics_dashboard',
              path: 'statistics',
              requireAuth: true,
              builder: (context, params) => StatisticsDashboardWidget(),
            ),
            FFRoute(
              name: CheckInManagementWidget.routeName,
              path: CheckInManagementWidget.routePath,
              requireAuth: true,
              builder: (context, params) => CheckInManagementWidget(),
            )
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/onboarding';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    'assets/images/HYG014---MOBILE---Layout-03d.jpg',
                    fit: BoxFit.cover,
                  ),
                )
              : PushNotificationsHandler(child: page);

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class _RouteErrorBuilder extends StatefulWidget {
  const _RouteErrorBuilder({
    Key? key,
    required this.state,
    required this.child,
  }) : super(key: key);

  final GoRouterState state;
  final Widget child;

  @override
  State<_RouteErrorBuilder> createState() => _RouteErrorBuilderState();
}

class _RouteErrorBuilderState extends State<_RouteErrorBuilder> {
  @override
  void initState() {
    super.initState();

    // Handle erroneous links from Firebase Dynamic Links.

    String? location;

    /*
    Handle `links` routes that have dynamic-link entangled with deep-link 
    */
    if (widget.state.uri.toString().startsWith('/link') &&
        widget.state.uri.queryParameters.containsKey('deep_link_id')) {
      final deepLinkId = widget.state.uri.queryParameters['deep_link_id'];
      if (deepLinkId != null) {
        final deepLinkUri = Uri.parse(deepLinkId);
        final link = deepLinkUri.toString();
        final host = deepLinkUri.host;
        location = link.split(host).last;
      }
    }

    if (widget.state.uri.toString().startsWith('/link') &&
        widget.state.uri.toString().contains('request_ip_version')) {
      location = '/';
    }

    if (location != null) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => context.go(location!));
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
