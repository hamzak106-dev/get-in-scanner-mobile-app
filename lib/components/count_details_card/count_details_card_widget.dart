import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'count_details_card_model.dart';
export 'count_details_card_model.dart';

class CountDetailsCardWidget extends StatefulWidget {
  const CountDetailsCardWidget({
    super.key,
    this.icon,
    this.img,
    required this.count,
    required this.lable,
  });

  final Widget? icon;
  final Widget? img;
  final int? count;
  final String? lable;


  @override
  State<CountDetailsCardWidget> createState() => _CountDetailsCardWidgetState();
}

class _CountDetailsCardWidgetState extends State<CountDetailsCardWidget> {
  late CountDetailsCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CountDetailsCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10.0, 18.0, 10.0, 18.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon != null ? widget.icon! : widget.img!,
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        widget.lable!,
                        textAlign: TextAlign.left,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'MonaSans',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ),
                  Text(
                    widget.count!.toString(),
                    style: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'MonaSans',
                          letterSpacing: 0.0,
                      fontSize: 24.0,
                        ),
                  ),
                ].divide(SizedBox(height: 2.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
