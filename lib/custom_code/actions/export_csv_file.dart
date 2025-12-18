// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

Future<ExportFileStruct?> exportCsvFile(
    List<AttendeeRow> attendeeList, bool sample) async {
  try {
    // event_id, purchase_id, transaction_number, ticket_id, ticket_name, ticket_hash, ticket_type, name, email, phone, id
    List tempData = attendeeList.map((e) => e.data).toList();

    List sampleData = [
      000000,
      000000,
      000000,
      "Sample Ticket",
      "000000000000000000",
      0,
      "Attendee Name",
      "Attendee Email",
      "+000000000"
    ];

    // Extract headers from the first map
    List<String> headers = [
      "purchase_id",
      "transaction_number",
      "ticket_id",
      "ticket_name",
      "ticket_hash",
      "ticket_type",
      "name",
      "email",
      "phone"
    ];

    // Create a list of lists for CSV
    List<List<dynamic>> csvData = sample
        ? [headers, sampleData]
        : [
            headers,
            ...tempData
                .map((row) => headers.map((header) => row[header]).toList())
          ];

    // Convert to CSV
    String csv = const ListToCsvConverter().convert(csvData);

    String fileName =
        "${sample ? 'sample' : 'attendees'}_${DateTime.now().microsecondsSinceEpoch}";
    // Get the directory to save the file

    Directory directory = Platform.isAndroid
        ? Directory("/storage/emulated/0/Download/Get-In")
        : await getApplicationDocumentsDirectory();

    String filePath = '${directory.path}/Exports/$fileName.csv';

    // Write to a file
    File file = File(filePath);
    file.createSync(recursive: true);
    print("=====>>>> File Created");
    await file.writeAsString(csv);
    print("=====>>>> Written in File");
    print("=====>>>> $filePath");
    File exportedFile = File(filePath);

    return ExportFileStruct(
        name: fileName,
        nameOnly: fileName,
        path: filePath,
        size: exportedFile.lengthSync());
  } catch (e) {
    print("======== CSV EXPORT EROR ========");
    print(e);
    print("===============================");
    return null;
  }
}
