import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'producer_card_model.dart';
export 'producer_card_model.dart';

class ProducerCardWidget extends StatefulWidget {
  const ProducerCardWidget({
    super.key,
    required this.producer,
    required this.onChange,
  });

  final CreatorsRow? producer;
  final Function() onChange;

  @override
  State<ProducerCardWidget> createState() => _ProducerCardWidgetState();
}

class _ProducerCardWidgetState extends State<ProducerCardWidget> {
  late ProducerCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProducerCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryText,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.network(
                    widget.producer!.profileImg!,
                  ).image,
                ),
                shape: BoxShape.circle,
              ),
              child: custom_widgets.ProfilePicWidget(
                width: 60.0,
                height: 60.0,
                profileImg: valueOrDefault<String>(
                  widget.producer?.profileImg,
                  '-',
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  valueOrDefault<String>(
                    widget.producer?.name,
                    '-',
                  ),
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'MonaSans',
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                if ((widget.producer?.followerCounter != null) && (widget.producer!.followerCounter! > 0))
                  Text(
                    '${formatNumber(
                      widget.producer?.followerCounter,
                      formatType: FormatType.compact,
                    )} Followers',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'MonaSans',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                        ),
                  ),
              ],
            ),
          ),
          Container(
            width: 24.0,
            height: 24.0,
            child: custom_widgets.AppCheckBox(
              width: 24.0,
              height: 24.0,
              size: 24.0,
              initialValue: FFAppState().selectedProducer.userId == widget.producer?.userId,
              fillColor: FFAppState().selectedProducer.userId == widget.producer?.userId
                  ? FlutterFlowTheme.of(context).primaryText
                  : FlutterFlowTheme.of(context).primaryBackground,
              checkColor: FlutterFlowTheme.of(context).primaryBackground,
              borderColor: FFAppState().selectedProducer.userId == widget.producer?.userId
                  ? FlutterFlowTheme.of(context).primaryText
                  : FlutterFlowTheme.of(context).tertiary,
              onChange: (value) async => widget.onChange.call(),
            ),
          ),
        ].divide(SizedBox(width: 12.0)),
      ),
    );
  }
}
