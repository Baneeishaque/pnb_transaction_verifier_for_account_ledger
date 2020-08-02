import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';

//int calculate() {
//  return 6 * 7;
//}

Future<List<dynamic>> readCsv(String csvTransactionsFile) async {
  final input = File(csvTransactionsFile).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(CsvToListConverter())
      .toList();
//  print(fields);
  return fields;
}

void printTransactions(List<dynamic> csvAsList) {
  var csvAsListContents = csvAsList[0] as List<dynamic>;
  var csvAsListSizeAfterHeaderAndFooterLength =
      csvAsListContents.length - 232 - 209;
  var transactions = csvAsListContents
      .skip(232)
      .take(csvAsListSizeAfterHeaderAndFooterLength)
      .toList();
  printTransactionsInFormat(transactions);
}

void printTransactionsFromCsv(String csvTransactionsFile) async {
  printTransactions(await readCsv(csvTransactionsFile));
}

void printTransactionsInFormat(List<dynamic> csvTransactions) {
  for (var i = 0; i < csvTransactions.length; i = i + 11) {
    print(csvTransactions[i].toString() +
        '\t' +
        csvTransactions[i + 4].toString() +
        '\t' +
        csvTransactions[i + 6].toString() +
        '\t' +
        csvTransactions[i + 7].toString() +
        '\t' +
        csvTransactions[i + 8].toString());
  }
}