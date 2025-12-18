import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'top_sync_banner_model.dart';
export 'top_sync_banner_model.dart';

/// Top Sync Banner
class TopSyncBannerWidget extends StatefulWidget {
  const TopSyncBannerWidget({
    super.key,
    String? message,
    Color? bannerColor,
  })  : this.message = message ?? '',
        this.bannerColor = bannerColor ?? const Color(0xFF8780D1);

  final String message;
  final Color bannerColor;

  @override
  State<TopSyncBannerWidget> createState() => _TopSyncBannerWidgetState();
}

class _TopSyncBannerWidgetState extends State<TopSyncBannerWidget> {
  late TopSyncBannerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TopSyncBannerModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      width: double.infinity,
      height: 56.0,
      decoration: BoxDecoration(
        color: widget.bannerColor,
      ),
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Text(
        widget.message,
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'MonaSans',
              letterSpacing: 0.0,
            ),
      ),
    );
  }
}
