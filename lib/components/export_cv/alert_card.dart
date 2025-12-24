import 'dart:async';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:g_e_t_i_n_scanner/backend/supabase/database/tables/events.dart';
import 'package:g_e_t_i_n_scanner/components/export_cv/downloaded_csv_card.dart';
import 'package:g_e_t_i_n_scanner/components/screen_component/scanner_summary/scanner_summary_model.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app_state.dart';
import '../../backend/schema/structs/summary_struct.dart';
import '../../custom_code/actions/watch_by_ticket_summary.dart' as actions;
import '../../flutter_flow/custom_functions.dart' as functions;
import '../../flutter_flow/flutter_flow_theme.dart';
import '/custom_code/actions/index.dart' as actions;

class AlertCard extends StatefulWidget {
  final List<EventsRow>? event;

  const AlertCard({super.key, this.event,  });

  @override
  State<AlertCard> createState() => _AlertCardState();
}

class _AlertCardState extends State<AlertCard> with TickerProviderStateMixin{
  final Stopwatch _stopwatch = Stopwatch();

  Timer? _timer;

  int progress = 0; // 0 → 100
  int secondsElapsed = 0;
  int estimatedSecondsLeft = 0;
  int secondsLeft = 0; // ✅ ADD THIS
  bool _isInternetAvailable = false;


  late final AnimationController _exportSheetController;
  final List<String> summaryHeaders = [
    'type',
    'id',
    'name',
    'total_checkins',
    'total_checkouts',
    'total_attendees',
    'total_absent',
    'total_logs',
  ];
  List<SummaryStruct> _ticketSummary = [];
  List<SummaryStruct> _deviceSummary = [];


  @override
  void initState() {
    super.initState();

    _exportSheetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!FFAppState().isOnline) {
        debugPrint('No internet → timer not started');
        return;
      }

      _isInternetAvailable = true;
      _startAggregateTimer();
      await _initExport();
    });
  }
  void _startAggregateTimer() {
    _stopwatch.start();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final elapsed = _stopwatch.elapsed.inSeconds;

      safeSetState(() {
        secondsElapsed = elapsed;

        if (progress > 0) {
          final estimatedTotal =
          (elapsed / progress * 100).round();

          estimatedSecondsLeft =
              (estimatedTotal - elapsed).clamp(0, 9999);
        }
      });
    });
  }
  void _updateProgress(int value) {
    safeSetState(() {
      progress = value;
    });
  }



  Future<void> _waitForSummaryData() async {
    int retries = 0;

    while (_ticketSummary.isEmpty && _deviceSummary.isEmpty && retries < 20) {
      await Future.delayed(const Duration(milliseconds: 200));
      retries++;
    }

    debugPrint(
      'Summary ready → '
          'tickets=${_ticketSummary.length}, '
          'devices=${_deviceSummary.length}',
    );
  }


  Future<void> _initExport() async {
    _updateProgress(5);

    await _loadSummariesFromEvent();
    _updateProgress(40);

    await _waitForSummaryData();
    _updateProgress(70);

    await _startCsvDownload();
    _updateProgress(100);

    _stopwatch.stop();
    _timer?.cancel();
  }


  Future<void> _loadSummariesFromEvent() async {

    /// Ticket Summary
    await actions.watchByTicketSummary(
          (ticketsSummary) async {
        _ticketSummary = ticketsSummary!.toList().cast<SummaryStruct>();
        safeSetState(() {});
      },
      widget.event!.map((e) => e.eventId).toList(),
    );


    /// Device Summary
    await actions.watchByDeviceSummary(
          (devicesSummary) async {
        _deviceSummary = devicesSummary!.toList().cast<SummaryStruct>();
        safeSetState(() {});
      },
      widget.event!.map((e) => e.eventId).toList().toList(),
    );
  }

  // ================= CSV EXPORT =================

  Future<void> _startCsvDownload() async {

    /// 🔹 Load ALL summaries first
    await _loadSummariesFromEvent();

    final allRows = <List<String>>[];

    /// 🎟 Ticket summary rows
    for (final s in _ticketSummary) {
      allRows.add([
        'ticket',
        s.value.toString(),
        s.name,
        s.totalCheckins.toString(),
        s.totalCheckouts.toString(),
        s.totalAttendees.toString(),
        s.totalAbsent.toString(),
        s.totalLogs.toString(),
      ]);
    }

    /// 📱 Device summary rows
    for (final s in _deviceSummary) {
      allRows.add([
        'device',
        s.value.toString(),
        s.name,
        s.totalCheckins.toString(),
        s.totalCheckouts.toString(),
        s.totalAttendees.toString(),
        s.totalAbsent.toString(),
        s.totalLogs.toString(),
      ]);
    }

    // if (allRows.isEmpty) {
    //   Fluttertoast.showToast(
    //     msg: 'No summary data to export',
    //     backgroundColor: Colors.orange,
    //     textColor: Colors.white,
    //   );
    //   return;
    // }

    final rows = [
      summaryHeaders,
      ...allRows,
    ];

    final csv = const ListToCsvConverter().convert(rows);

    late Directory directory;
    if (Platform.isAndroid) {
      directory = Directory('/storage/emulated/0/Download');
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    final fileName =
        'scanner_summary_${DateTime.now().millisecondsSinceEpoch}.csv';

    final file = File('${directory.path}/$fileName');
    await file.writeAsString(csv);

    debugPrint('✅ CSV saved: $fileName');
    // ✅ GET FILE SIZE
    final int bytes = await file.length();
    final String formattedSize = _formatFileSize(bytes);
    final String filePath = file.path;

    Fluttertoast.showToast(
      msg: 'Downloaded: $fileName',
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
    if (!mounted) return;

    await Future.delayed(const Duration(milliseconds: 300));
    Navigator.pop(context);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.4),
      transitionAnimationController: _exportSheetController,
      builder: (_) => DownloadedCsvCard(
        fileName: fileName, fileSize: formattedSize, filePath: filePath,
      ),
    );

  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
    }
  }

  // ================= PROGRESS UI =================



  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return SafeArea(
      top: false,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        decoration: BoxDecoration(
          color: theme.secondary,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, -4),
              blurRadius: 20,
              spreadRadius: 0,
              color: Color(0x33000000), // 20% black
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Drag Handle
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: const Color(0xFF979797), // secondary grey
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            /// Time Left
            Text(
              progress < 100
                  ? '${estimatedSecondsLeft}s Left'
                  : 'Completed',
              style: theme.bodyMedium.override(
                fontFamily: 'MonaSans',
                color: Colors.black,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                fontSize: 16
              ),
            ),


            /// Subtitle
            Padding(
              padding: const EdgeInsets.only(bottom: 27,top: 15),
              child: Text(
                'Exporting',
                style: theme.headlineSmall.override(
                  fontFamily: 'MonaSans',
                  color:Colors.black,
                  lineHeight: 1,
                  fontWeight: FontWeight.w400,
                  fontSize: 16
                ),
              ),
            ),


            /// Progress Circle
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 76,
                  width: 76,
                  child: CircularProgressIndicator(
                    value: progress / 100,
                    strokeWidth: 3.61,
                    backgroundColor: theme.tertiary800,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.alternate, // black
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$progress',
                        style: theme.titleSmall.override(
                          fontFamily: 'MonaSans',
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          fontSize: 22
                        ),
                      ),
                      TextSpan(
                        text: '%',
                        style: theme.titleMedium.override(
                          fontFamily: 'MonaSans',
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
}
