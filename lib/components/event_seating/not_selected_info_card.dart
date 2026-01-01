import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class NotSelectedInfoCard extends StatelessWidget {
  final String section;
  final String row;
  final String seat;
  final String price;
  final VoidCallback onSelect;
  final VoidCallback onDismiss;
  final bool status;

  const NotSelectedInfoCard({
    super.key,
    required this.section,
    required this.row,
    required this.seat,
    required this.price,
    required this.onSelect,
    required this.onDismiss, required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 12,bottom: 24),
              child: Container(
                width: 110,
                height: 5,
                decoration: BoxDecoration(
                  color:theme.tertiary800,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),

            // Top Info Row
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _infoColumn("Section", section,context),
                  _divider(),
                  _infoColumn("Row", row,context),
                  _divider(),
                  _infoColumn("Seat", seat,context),
                ],
              ),
            ),

            // Red Price Bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all( 16),
              decoration:  BoxDecoration(
                color: theme.errorRed,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    "A",
                    style: theme.titleLarge.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                        fontFamily: 'MonaSans',

                        letterSpacing: 0.14,
                      fontWeight: FontWeight.w500
                    )
                  ),
                  Text(
                    price,
                      style: theme.titleLarge.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'MonaSans',
                          letterSpacing: 0.14,
                          fontWeight: FontWeight.w600
                      )
                  ),
                ],
              ),
            ),

            // Unassigned Text
            status? Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "Unassigned",
                style: theme.bodySmall.copyWith(
                  fontFamily: 'MonaSans',
                  color: theme.errorRed,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: 0.14,
                ),

              ),
            ):SizedBox.shrink(),

            status?  Divider(height: 1,
               color:Colors.grey.shade300,
            ):SizedBox.shrink(),

            // Action Buttons
           status? Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: onSelect,
                    child: Text(
                      "Select",
                      style: theme.bodySmall.copyWith(
                        fontFamily: 'MonaSans',
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        letterSpacing: 0.14,
                        height: 1.2857,
                      ),
                    ),
                  ),
                ),

                // Vertical Divider
                SizedBox(
                  height: 48, // important for visibility
                  child: VerticalDivider(
                    width: 1,
                    thickness: 1.4,
                    color:Colors.grey.shade300,
                  ),
                ),

                Expanded(
                  child: TextButton(
                    onPressed: onDismiss,
                    child: Text(
                      "Dismiss",
                      style: theme.bodySmall.copyWith(
                        fontFamily: 'MonaSans',
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        letterSpacing: 0.14,
                        height: 1.2857,
                      ),
                    ),
                  ),
                ),
              ],
            ):Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(Icons.cancel_outlined,
                 color: FlutterFlowTheme.of(context).errorRed,),
                 Padding(
                   padding: const EdgeInsets.only(left: 8),
                   child: Text("You can't use any more places",
                   style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                       fontFamily: 'MonaSans',
                     color: FlutterFlowTheme.of(context).errorRed,
                     fontSize: 16,
                     fontWeight: FontWeight.w600
                   )
                     ,),
                 )
               ],
                         ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoColumn(String title, String value,BuildContext context) {
   final theme= FlutterFlowTheme.of(context);
    return Column(
      children: [
        Text(
          title,
          style: theme.bodySmall.copyWith(
            color: theme.secondary200

          )
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.titleLarge.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,

          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(
      height: 52,
      width: 1,
      color: Colors.grey.shade300,
    );
  }
}
