import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'submit_animation_model.dart';
export 'submit_animation_model.dart';

class SubmitAnimationWidget extends StatefulWidget {
  const SubmitAnimationWidget({super.key});

  @override
  State<SubmitAnimationWidget> createState() => _SubmitAnimationWidgetState();
}

class _SubmitAnimationWidgetState extends State<SubmitAnimationWidget> {
  late SubmitAnimationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubmitAnimationModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SUBMIT_ANIMATION_submitAnimation_ON_INIT');
      logFirebaseEvent('submitAnimation_wait__delay');
      await Future.delayed(const Duration(milliseconds: 1500));
      logFirebaseEvent('submitAnimation_bottom_sheet');
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/jsons/Submit.json',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
      repeat: false,
      animate: true,
    );
  }
}
