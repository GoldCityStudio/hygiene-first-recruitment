import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/modal_guest_profile/modal_guest_profile_widget.dart';
import '/components/search_results/search_results_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'search_model.dart';
export 'search_model.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  static String routeName = 'search';
  static String routePath = 'search';

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late SearchModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'search'});
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          '搜尋',
          style: FlutterFlowTheme.of(context).headlineSmall.override(
                fontFamily: 'Montserrat',
                fontSize: 22.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 24.0),
            child: FFButtonWidget(
              onPressed: () async {
                logFirebaseEvent('SEARCH_PAGE__BTN_ON_TAP');
                logFirebaseEvent('Button_bottom_sheet');
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  enableDrag: false,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: SearchResultsWidget(),
                    );
                  },
                ).then((value) => safeSetState(() {}));
              },
              text: '搜尋職位...',
              icon: Icon(
                Icons.search,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 16.0,
              ),
              options: FFButtonOptions(
                width: double.infinity,
                height: 56.0,
                padding: EdgeInsets.all(0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
                color: FlutterFlowTheme.of(context).secondaryBackground,
                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                    ),
                elevation: 2.0,
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).alternate,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  '職位類別',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: 'Montserrat',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: FutureBuilder<List<CategoriesRecord>>(
                future: FFAppState().categories(
                  requestFn: () => queryCategoriesRecordOnce(
                    queryBuilder: (categoriesRecord) =>
                        categoriesRecord.orderBy('name'),
                  ),
                ),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 32.0,
                        height: 32.0,
                        child: SpinKitFoldingCube(
                          color: FlutterFlowTheme.of(context).primary,
                          size: 32.0,
                        ),
                      ),
                    );
                  }
                  List<CategoriesRecord> listViewCategoriesRecordList =
                      snapshot.data!;
                  if (listViewCategoriesRecordList.isEmpty) {
                    return Center(
                      child: Image.asset(
                        'assets/images/noJobPosts@2x.png',
                        width: 200.0,
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewCategoriesRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewCategoriesRecord =
                          listViewCategoriesRecordList[listViewIndex];
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x33000000),
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                                            child: Text(
                                              listViewCategoriesRecord.name,
                                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (valueOrDefault(currentUserDocument?.type, '') != 'Company')
                                        Align(
                                          alignment: AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                                            child: AuthUserStreamWidget(
                                              builder: (context) => Container(
                                                width: 40.0,
                                                height: 40.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 4.0,
                                                      color: Color(0x33000000),
                                                      offset: Offset(0.0, 2.0),
                                                    )
                                                  ],
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(context).alternate,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: StreamBuilder<UsersRecord>(
                                                  stream: FFAppState().heart(
                                                    requestFn: () => UsersRecord.getDocument(currentUserReference!),
                                                  ),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 28.0,
                                                          height: 28.0,
                                                          child: SpinKitFoldingCube(
                                                            color: FlutterFlowTheme.of(context).primary,
                                                            size: 28.0,
                                                          ),
                                                        ),
                                                      );
                                                    }

                                                    final toggleIconUsersRecord = snapshot.data!;
                                                    return ToggleIcon(
                                                      onPressed: () async {
                                                        final categoryInterestsElement = listViewCategoriesRecord.reference;
                                                        final categoryInterestsUpdate = toggleIconUsersRecord.categoryInterests.contains(categoryInterestsElement)
                                                            ? FieldValue.arrayRemove([categoryInterestsElement])
                                                            : FieldValue.arrayUnion([categoryInterestsElement]);
                                                        await toggleIconUsersRecord.reference.update({
                                                          ...mapToFirestore(
                                                            {
                                                              'category_interests': categoryInterestsUpdate,
                                                            },
                                                          ),
                                                        });
                                                        logFirebaseEvent('SEARCH_ToggleIcon_dzdblk8j_ON_TOGGLE');
                                                        if (loggedIn == true) {
                                                          if (valueOrDefault(currentUserDocument?.type, '') == 'Guest') {
                                                            await showModalBottomSheet(
                                                              isScrollControlled: true,
                                                              backgroundColor: Color(0x66222222),
                                                              isDismissible: false,
                                                              enableDrag: false,
                                                              context: context,
                                                              builder: (context) {
                                                                return Padding(
                                                                  padding: MediaQuery.viewInsetsOf(context),
                                                                  child: ModalGuestProfileWidget(),
                                                                );
                                                              },
                                                            ).then((value) => safeSetState(() {}));
                                                          } else {
                                                            if (toggleIconUsersRecord.categoryInterests.contains(listViewCategoriesRecord.reference)) {
                                                              HapticFeedback.selectionClick();
                                                              ScaffoldMessenger.of(context).clearSnackBars();
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Removed from your interests.',
                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                          fontFamily: 'Montserrat',
                                                                          color: FlutterFlowTheme.of(context).primaryBtnText,
                                                                          letterSpacing: 0.0,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(milliseconds: 4000),
                                                                  backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                ),
                                                              );
                                                            } else {
                                                              HapticFeedback.selectionClick();
                                                              ScaffoldMessenger.of(context).clearSnackBars();
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Added to your interests.',
                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                          fontFamily: 'Montserrat',
                                                                          color: FlutterFlowTheme.of(context).primaryBtnText,
                                                                          letterSpacing: 0.0,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(milliseconds: 4000),
                                                                  backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                ),
                                                              );
                                                            }
                                                          }
                                                        } else {
                                                          await showModalBottomSheet(
                                                            isScrollControlled: true,
                                                            backgroundColor: Color(0x66222222),
                                                            isDismissible: false,
                                                            enableDrag: false,
                                                            context: context,
                                                            builder: (context) {
                                                              return Padding(
                                                                padding: MediaQuery.viewInsetsOf(context),
                                                                child: ModalGuestProfileWidget(),
                                                              );
                                                            },
                                                          ).then((value) => safeSetState(() {}));
                                                        }
                                                      },
                                                      value: toggleIconUsersRecord.categoryInterests.contains(listViewCategoriesRecord.reference),
                                                      onIcon: Icon(
                                                        Icons.favorite_rounded,
                                                        color: FlutterFlowTheme.of(context).error,
                                                        size: 20.0,
                                                      ),
                                                      offIcon: Icon(
                                                        Icons.favorite_border_rounded,
                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                        size: 20.0,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (listViewIndex < listViewCategoriesRecordList.length - 1)
                              Divider(
                                height: 1.0,
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context).alternate,
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
