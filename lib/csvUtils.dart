import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';

Future<List<dynamic>> readCsv(String csvTransactionsFile) async {
  final input = File(csvTransactionsFile).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(CsvToListConverter())
      .toList();
//  print(fields);
  return fields;
}
