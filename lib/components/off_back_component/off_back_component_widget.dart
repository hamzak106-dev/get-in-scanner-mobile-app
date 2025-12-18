import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'off_back_component_model.dart';
export 'off_back_component_model.dart';

class OffBackComponentWidget extends StatefulWidget {
  const OffBackComponentWidget({
    super.key,
    required this.child,
  });

  final Widget Function()? child;

  @override
  State<OffBackComponentWidget> createState() => _OffBackComponentWidgetState();
}

class _OffBackComponentWidgetState extends State<OffBackComponentWidget> {
  late OffBackComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OffBackComponentModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('OFF_BACK_COMPONENT_OffBackComponent_ON_I');
      await actions.printData(
        FFAppState().user.userId.toString(),
      );
      await action_blocks.syncData(context);
      FFAppState().hasFirstSync = true;
      safeSetState(() {});
      Navigator.pop(context, true);
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return custom_widgets.WillPopScopeWidget(
      width: double.infinity,
      height: double.infinity,
      child: () => widget.child!(),
    );
  }
}
