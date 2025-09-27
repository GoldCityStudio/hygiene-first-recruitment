import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'empty_notifs_model.dart';
export 'empty_notifs_model.dart';

class EmptyNotifsWidget extends StatefulWidget {
  const EmptyNotifsWidget({super.key});

  @override
  State<EmptyNotifsWidget> createState() => _EmptyNotifsWidgetState();
}

class _EmptyNotifsWidgetState extends State<EmptyNotifsWidget> {
  late EmptyNotifsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyNotifsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.notifications_none,
            color: FlutterFlowTheme.of(context).secondaryText,
            size: 72.0,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
            child: Text(
              '沒有活動',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Montserrat',
                    color: FlutterFlowTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
