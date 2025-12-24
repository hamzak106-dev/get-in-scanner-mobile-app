
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_file/open_file.dart';
import '../../custom_code/actions/start_multicast.dart' as FilePicker;
import '../../flutter_flow/flutter_flow_theme.dart';

class DownloadedCsvCard extends StatelessWidget {
 final String fileName;
 final String fileSize;
 final String filePath;
  const DownloadedCsvCard({super.key, required this.fileName, required this.fileSize, required this.filePath});

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return SafeArea(
      top: false,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        decoration: BoxDecoration(
          color: Colors.white,
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
            /// Drag handle
            Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color:theme.secondaryGrey,
                borderRadius: BorderRadius.circular(50),
              ),
            ),

            /// Title
            Padding(
              padding: const EdgeInsets.only(top: 30,bottom: 15),
              child: Text(
                'Hurray!',
                style: theme.titleMedium.override(
                  fontFamily: 'MonaSans',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.16,
                  lineHeight: 1.5
                ),
              ),
            ),


            /// Subtitle
            Text(
              'You’ve just downloaded the file',
              style: theme.bodySmall.override(
                fontFamily: 'MonaSans',
                color: Colors.black,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),


            /// Illustration
            SizedBox(
              height: 142,
              child: SvgPicture.asset(
                'assets/svg/downloaded.svg',
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 16),

            /// File Info
            Text(
              'File Name : ${fileName}',
              style: theme.bodySmall.override(
                fontFamily: 'MonaSans',
                color: theme.secondary200,
                fontSize: 10
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'File Size : ${fileSize}',
              style: theme.bodySmall.override(
                fontFamily: 'MonaSans',
                color: theme.secondary200,
                fontSize: 10
              ),
            ),

            const SizedBox(height: 28),

            /// OPEN NOW
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.all(10),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  await OpenFile.open(filePath);
                  Navigator.pop(context);

                },
                child: Text(
                  'OPEN NOW',
                  style: theme.labelMedium.override(
                    fontFamily: 'MonaSans',
                    color: Colors.white,
                    letterSpacing: 0.8,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// SKIP FOR NOW
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.all(10),
                  side: const BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'SKIP FOR NOW',
                  style: theme.labelMedium.override(
                    fontFamily: 'MonaSans',
                    color: Colors.black,
                    letterSpacing: 0.8,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
