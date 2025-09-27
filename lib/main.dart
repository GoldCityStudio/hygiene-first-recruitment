import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_view/photo_view.dart';
import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:octo_image/octo_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:csslib/parser.dart' as css;
import 'package:json_path/json_path.dart';
import 'package:mime_type/mime_type.dart';
import 'package:internet_file/internet_file.dart';
import 'package:universal_io/io.dart';
import 'package:xml/xml.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:algolia/algolia.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pdfx/pdfx.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'index.dart';
import '/flutter_flow/nav/nav.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/firebase_remote_config_util.dart';
import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/auth/firebase_auth/firebase_user_provider.dart';
import '/backend/backend.dart';
import '/backend/firebase/firebase_config.dart';
import 'app_state.dart';

import '/pages/calendar/calendar_widget.dart' show CalendarWidget;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with error handling for duplicate apps
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // If Firebase is already initialized, this will throw an error
    // We can safely ignore this error as Firebase is already ready
    print('Firebase already initialized: $e');
  }

  await FlutterFlowTheme.initialize();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }
  await initializeFirebaseRemoteConfig();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();

  late Stream<BaseAuthUser> userStream;

  final authUserSub = authenticatedUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = hygieneFirstRecruitmentFirebaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    Future.delayed(
      Duration(milliseconds: 1500),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();
    super.dispose();
  }

  void setThemeMode(ThemeMode mode) {
    setState(() {
        _themeMode = mode;
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'HygieneFirst Recruitment',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: FlutterFlowTheme.of(context).primary,
        brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          titleTextStyle: FlutterFlowTheme.of(context).headlineMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 8.0,
          selectedItemColor: FlutterFlowTheme.of(context).primary,
          unselectedItemColor: FlutterFlowTheme.of(context).secondaryText,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
      ),
        textTheme: TextTheme(
          displayLarge: FlutterFlowTheme.of(context).displayLarge,
          displayMedium: FlutterFlowTheme.of(context).displayMedium,
          displaySmall: FlutterFlowTheme.of(context).displaySmall,
          headlineLarge: FlutterFlowTheme.of(context).headlineLarge,
          headlineMedium: FlutterFlowTheme.of(context).headlineMedium,
          headlineSmall: FlutterFlowTheme.of(context).headlineSmall,
          titleLarge: FlutterFlowTheme.of(context).titleLarge,
          titleMedium: FlutterFlowTheme.of(context).titleMedium,
          titleSmall: FlutterFlowTheme.of(context).titleSmall,
          labelLarge: FlutterFlowTheme.of(context).labelLarge,
          labelMedium: FlutterFlowTheme.of(context).labelMedium,
          labelSmall: FlutterFlowTheme.of(context).labelSmall,
          bodyLarge: FlutterFlowTheme.of(context).bodyLarge,
          bodyMedium: FlutterFlowTheme.of(context).bodyMedium,
          bodySmall: FlutterFlowTheme.of(context).bodySmall,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: FlutterFlowTheme.of(context).primary,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0.0,
          centerTitle: true,
          titleTextStyle: FlutterFlowTheme.of(context).headlineMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          elevation: 8.0,
          selectedItemColor: FlutterFlowTheme.of(context).primary,
          unselectedItemColor: FlutterFlowTheme.of(context).secondaryText,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
        textTheme: TextTheme(
          displayLarge: FlutterFlowTheme.of(context).displayLarge,
          displayMedium: FlutterFlowTheme.of(context).displayMedium,
          displaySmall: FlutterFlowTheme.of(context).displaySmall,
          headlineLarge: FlutterFlowTheme.of(context).headlineLarge,
          headlineMedium: FlutterFlowTheme.of(context).headlineMedium,
          headlineSmall: FlutterFlowTheme.of(context).headlineSmall,
          titleLarge: FlutterFlowTheme.of(context).titleLarge,
          titleMedium: FlutterFlowTheme.of(context).titleMedium,
          titleSmall: FlutterFlowTheme.of(context).titleSmall,
          labelLarge: FlutterFlowTheme.of(context).labelLarge,
          labelMedium: FlutterFlowTheme.of(context).labelMedium,
          labelSmall: FlutterFlowTheme.of(context).labelSmall,
          bodyLarge: FlutterFlowTheme.of(context).bodyLarge,
          bodyMedium: FlutterFlowTheme.of(context).bodyMedium,
          bodySmall: FlutterFlowTheme.of(context).bodySmall,
        ),
      ),
      themeMode: _themeMode,
      routerConfig: _router,
      builder: (_, child) => child!,
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage, not that there
/// is anything special about it, but DiscoDart needs it so it can generate
/// code for it safely.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'Home';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'Home': HomeWidget(),
      'Search': SearchWidget(),
      'SavedJobs': SavedJobsWidget(),
      'Profile': ProfileWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: tabs.values.toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.home_rounded,
              size: 24,
            ),
            label: 'Home',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_rounded,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.search,
              size: 24,
            ),
            label: 'Search',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.favorite_rounded,
              size: 24,
            ),
            label: 'Saved',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_rounded,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.person_rounded,
              size: 24,
            ),
            label: 'Profile',
            tooltip: '',
          ),
        ],
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        selectedItemColor: FlutterFlowTheme.of(context).primary,
        unselectedItemColor: FlutterFlowTheme.of(context).secondaryText,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        onTap: (i) => setState(() => _currentPageName = tabs.keys.toList()[i]),
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
