// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!





import 'package:file_picker/file_picker.dart';

Future<FFUploadedFile?> csvReader(
  BuildContext context,
  int eventId,
) async {
  // List csvData = [];

  // CsvUploadResponseStruct response = CsvUploadResponseStruct(
  //     error: true,
  //     errorRecord: 0,
  //     uploadedRecord: 0,
  //     availableRecord: 0,
  //     totalRecord: 0);

  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowedExtensions: ['csv'],
    type: FileType.custom,
    withData: true,
  );

  if (result != null && result.files.isNotEmpty) {
    print(result.files.first.path);

    final size = result.files.first.size;
    double _sizeMbs = size / (1024 * 1024);

    print(_sizeMbs);

    if (_sizeMbs > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Size should be less than 5 MB",
            style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).primary,
        ),
      );
      print('size should be less than 5 MB');

      return null;
    } else {
      print("File Name ===>> ${result.files.first.name}");
      return FFUploadedFile(
        bytes: result.files.first.bytes,
        name: result.files.first.name,
      );
    }

    //   final input = new File(result.files.firstOrNull?.path ?? "").openRead();
    //   final fields = await input
    //       .transform(utf8.decoder)
    //       .transform(new CsvToListConverter(shouldParseNumbers: false))
    //       .toList();

    //   // Extracting the keys from the first list
    //   List<String> keys = List<String>.from(fields[0]);

    //   // Converting each row into a map using the keys
    //   csvData = fields
    //       .skip(1)
    //       .map((values) => Map<String, dynamic>.fromIterables(keys, values))
    //       .toList();

    //   response.totalRecord = csvData.length;

    //   for (Map<String, dynamic> ele in csvData) {
    //     if (checkValidRecord(ele, attendeeList)) {
    //       if (attendeeList
    //           .where((e) => e.ticketHash == ele["ticket_hash"])
    //           .isNotEmpty) {
    //         response.availableRecord += 1;
    //       } else {
    //         try {
    //           const query =
    //               'INSERT INTO attendee (event_id, purchase_id, transaction_number, ticket_id, ticket_name, ticket_hash, ticket_type, name, email, phone, id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';

    //           await db.execute(query, [
    //             eventId,
    //             ele["purchase_id"],
    //             ele["transaction_number"],
    //             ele["ticket_id"],
    //             ele["ticket_name"],
    //             ele["ticket_hash"],
    //             ele["ticket_type"],
    //             ele["name"],
    //             ele.containsKey("email") ? ele["email"] : "",
    //             ele.containsKey("phone") ? ele["phone"] : "",
    //             (Random().nextInt(9999999) + 10000000).toString(),
    //           ]);
    //           response.uploadedRecord += 1;
    //         } catch (e) {
    //           response.errorRecord += 1;
    //           print("========== ADD ATTENDEE ERROR ==========");
    //           print(e);
    //           print("========================================");
    //         }
    //       }
    //     } else {
    //       response.errorRecord += 1;
    //     }
    //   }

    //   if (response.uploadedRecord != 0) {
    //     response.error = false;
    //     try {
    //       await db.execute(
    //           "UPDATE events SET total_attendees = total_attendees + ${response.uploadedRecord} WHERE event_id = '$eventId'");
    //     } catch (e) {
    //       debugPrint("============= Update EVENT Status ERROR ============");
    //       debugPrint(e.toString());
    //       debugPrint("===============================");
    //     }
    //   }

    //   print("========= CSV DATA =========");
    //   print(response.error);
    //   print(response.errorRecord);
    //   print(response.uploadedRecord);
    //   print("===========================");

    //   return response;
  } else {
    return null;
  }
}

// bool checkValidRecord(
//     Map<String, dynamic> data, List<AttendeeRow> attendeeList) {
//   return data.containsKey("purchase_id") &&
//       data.containsKey("transaction_number") &&
//       data.containsKey("ticket_id") &&
//       data.containsKey("ticket_name") &&
//       data.containsKey("ticket_hash") &&
//       data.containsKey("name") &&
//       (data.containsKey("email") || data.containsKey("phone"));
// }
