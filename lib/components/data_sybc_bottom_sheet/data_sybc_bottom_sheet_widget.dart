import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'data_sybc_bottom_sheet_model.dart';
export 'data_sybc_bottom_sheet_model.dart';

/// Bottom Sheet to showing the datasync from Get In server to Supabase server
class DataSybcBottomSheetWidget extends StatefulWidget {
  const DataSybcBottomSheetWidget({super.key});

  @override
  State<DataSybcBottomSheetWidget> createState() =>
      _DataSybcBottomSheetWidgetState();
}

class _DataSybcBottomSheetWidgetState extends State<DataSybcBottomSheetWidget> {
  late DataSybcBottomSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DataSybcBottomSheetModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2.0,
          sigmaY: 2.0,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                custom_widgets.Loader(
                  width: 84.0,
                  height: 84.0,
                ),
                Text(
                  'Syncing Data',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'MonaSans',
                        letterSpacing: 0.0,
                      ),
                ),
              ].divide(SizedBox(height: 12.0)),
            ),
          ),
        ),
      ),
    );
  }
}
