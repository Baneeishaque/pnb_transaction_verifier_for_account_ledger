import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:pnb_transaction_verifier_for_account_ledger/transactionModal.dart';
import 'package:intl/intl.dart';

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

void printTransactions(
    List<dynamic> csvAsList, int headerLength, int footerLength) {
  var csvAsListContents = csvAsList[0] as List<dynamic>;
  var csvAsListSizeAfterHeaderAndFooterLength =
      csvAsListContents.length - headerLength - footerLength;
  var transactions = csvAsListContents
      .skip(232)
      .take(csvAsListSizeAfterHeaderAndFooterLength)
      .toList();
  printTransactionsInFormat(transactions);
}

void printTransactionsFromCsv(
    String csvTransactionsFile, int headerLength, int footerLength) async {
  printTransactions(
      await readCsv(csvTransactionsFile), headerLength, footerLength);
}

void printTransactionsInFormat(List<dynamic> csvTransactions) {
  var transactions = <TransactionModal>[];
  for (var i = 0; i < csvTransactions.length; i = i + 11) {
    var transactionDate = csvTransactions[i];
    var withdrawAmount = csvTransactions[i + 4].toString();
    var depositAmount = csvTransactions[i + 6].toString();
    var balanceAmount = csvTransactions[i + 7].toString();
    var narration = csvTransactions[i + 8];

    print(transactionDate +
        '\t' +
        withdrawAmount.toString() +
        '\t' +
        depositAmount +
        '\t' +
        balanceAmount +
        '\t' +
        narration);

    transactions.add(TransactionModal(
        DateFormat('d/M/yyyy').parse(transactionDate),
        withdrawAmount.isEmpty ? 0 : double.parse(withdrawAmount.replaceAll(',', '')),
        depositAmount.isEmpty ? 0 : double.parse(depositAmount.replaceAll(',', '')),
        double.parse(
            balanceAmount.substring(0, (balanceAmount.length - 4)).replaceAll(',', '')),
        narration));
  }
}
