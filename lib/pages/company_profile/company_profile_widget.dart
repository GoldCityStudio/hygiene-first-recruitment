import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:octo_image/octo_image.dart';
import 'company_profile_model.dart';
export 'company_profile_model.dart';

class CompanyProfileWidget extends StatefulWidget {
  const CompanyProfileWidget({
    super.key,
    required this.compID,
  });

  final DocumentReference? compID;

  static String routeName = 'companyProfile';
  static String routePath = 'companyProfile';

  @override
  State<CompanyProfileWidget> createState() => _CompanyProfileWidgetState();
}

class _CompanyProfileWidgetState extends State<CompanyProfileWidget> {
  late CompanyProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CompanyProfileModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'companyProfile'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UsersRecord>(
      future: UsersRecord.getDocumentOnce(widget.compID!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 28.0,
                height: 28.0,
                child: SpinKitFoldingCube(
                  color: FlutterFlowTheme.of(context).primary,
                  size: 28.0,
                ),
              ),
            ),
          );
        }

        final companyProfileUsersRecord = snapshot.data!;

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary,
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: Image.asset(
                                        'assets/images/vnimc_1.png',
                                      ).image,
                                    ),
                                  ),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'COMPANY_PROFILE_PAGE_companyImage_ON_TAP');
                                      logFirebaseEvent(
                                          'companyImage_expand_image');
                                      await Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          child: FlutterFlowExpandedImageView(
                                            image: OctoImage(
                                              placeholderBuilder: (_) =>
                                                  SizedBox.expand(
                                                child: Image(
                                                  image: BlurHashImage(
                                                      companyProfileUsersRecord
                                                          .coverPhotoBlurhash),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              image: CachedNetworkImageProvider(
                                                companyProfileUsersRecord
                                                    .photoCoverUrl,
                                              ),
                                              fit: BoxFit.contain,
                                            ),
                                            allowRotation: false,
                                            tag: companyProfileUsersRecord
                                                .photoCoverUrl,
                                            useHeroAnimation: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Hero(
                                      tag: companyProfileUsersRecord
                                          .photoCoverUrl,
                                      transitionOnUserGestures: true,
                                      child: OctoImage(
                                        placeholderBuilder: (_) =>
                                            SizedBox.expand(
                                          child: Image(
                                            image: BlurHashImage(
                                                companyProfileUsersRecord
                                                    .coverPhotoBlurhash),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        image: CachedNetworkImageProvider(
                                          companyProfileUsersRecord
                                              .photoCoverUrl,
                                        ),
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-0.8, 1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 150.0, 0.0, 0.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 12.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: Image.asset(
                                              'assets/images/vnimc_1.png',
                                            ).image,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(-0.84, 0.88),
                                          child: Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'COMPANY_PROFILE_Image_agw0huhq_ON_TAP');
                                                logFirebaseEvent(
                                                    'Image_expand_image');
                                                await Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child:
                                                        FlutterFlowExpandedImageView(
                                                      image: OctoImage(
                                                        placeholderBuilder:
                                                            (_) =>
                                                                SizedBox.expand(
                                                          child: Image(
                                                            image: BlurHashImage(
                                                                companyProfileUsersRecord
                                                                    .profilePhotoBlurhash),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        image:
                                                            CachedNetworkImageProvider(
                                                          companyProfileUsersRecord
                                                              .photoUrl,
                                                        ),
                                                        fit: BoxFit.contain,
                                                      ),
                                                      allowRotation: false,
                                                      tag:
                                                          companyProfileUsersRecord
                                                              .photoUrl,
                                                      useHeroAnimation: true,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Hero(
                                                tag: companyProfileUsersRecord
                                                    .photoUrl,
                                                transitionOnUserGestures: true,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: OctoImage(
                                                    placeholderBuilder: (_) =>
                                                        SizedBox.expand(
                                                      child: Image(
                                                        image: BlurHashImage(
                                                            companyProfileUsersRecord
                                                                .profilePhotoBlurhash),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    image:
                                                        CachedNetworkImageProvider(
                                                      companyProfileUsersRecord
                                                          .photoUrl,
                                                    ),
                                                    width: 80.0,
                                                    height: 80.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 32.0, 16.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Material(
                                        color: Colors.transparent,
                                        elevation: 4.0,
                                        shape: const CircleBorder(),
                                        child: Container(
                                          width: 44.0,
                                          height: 44.0,
                                          decoration: BoxDecoration(
                                            color: Color(0x66131313),
                                            shape: BoxShape.circle,
                                          ),
                                          child: FlutterFlowIconButton(
                                            borderRadius: 30.0,
                                            buttonSize: 46.0,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            icon: Icon(
                                              Icons.chevron_left_rounded,
                                              color: Color(0xFFEFF7F5),
                                              size: 25.0,
                                            ),
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'COMPANY_PROFILE_chevron_left_rounded_ICN');
                                              logFirebaseEvent(
                                                  'IconButton_navigate_back');
                                              context.pop();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 16.0, 16.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      companyProfileUsersRecord.displayName,
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                  if (valueOrDefault<bool>(
                                    companyProfileUsersRecord.verifiedAccount,
                                    false,
                                  ))
                                    Icon(
                                      Icons.verified_rounded,
                                      color: Color(0xFF396AFF),
                                      size: 20.0,
                                    ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 8.0,
                              thickness: 2.0,
                              indent: 16.0,
                              endIndent: 16.0,
                              color: FlutterFlowTheme.of(context).lineColor,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 16.0, 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.location_pin,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 16.0,
                                  ),
                                  Text(
                                    companyProfileUsersRecord.location,
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            if (companyProfileUsersRecord.website != '')
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 8.0, 16.0, 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.public,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 16.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 4.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'COMPANY_PROFILE_Text_7iqy7l80_ON_TAP');
                                          logFirebaseEvent('Text_launch_u_r_l');
                                          await launchURL(
                                              companyProfileUsersRecord
                                                  .website);
                                        },
                                        child: Text(
                                          companyProfileUsersRecord.website,
                                          style: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF1189EB),
                                                letterSpacing: 0.0,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 8.0, 16.0, 4.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    '描述',
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        companyProfileUsersRecord.description,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
