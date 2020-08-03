import 'package:pnb_transaction_verifier_for_account_ledger/transactionFromCsvEntity.dart';
import 'package:intl/intl.dart';
import 'csvUtils.dart';

//int calculate() {
//  return 6 * 7;
//}

List<dynamic> getPnbTransactionsWithoutHeaderAndFooter(
    List<dynamic> csvTransactionList, int headerLength, int footerLength) {
  var csvAsListContents = csvTransactionList[0] as List<dynamic>;
  var csvAsListSizeAfterHeaderAndFooterLength =
      csvAsListContents.length - headerLength - footerLength;
  var transactions = csvAsListContents
      .skip(232)
      .take(csvAsListSizeAfterHeaderAndFooterLength)
      .toList();
  return transactions;
}

Future<List> getPnbTransactionsListFromCsv(String csvTransactionsFile) async {
  return await readCsv(csvTransactionsFile);
}

List<TransactionFromCsvEntity> getPnbTransactionBeansList(
    List<dynamic> csvTransactions) {
  var pnbTransactions = <TransactionFromCsvEntity>[];
  for (var i = 0; i < csvTransactions.length; i = i + 11) {
    var transactionDate = csvTransactions[i];
    var withdrawAmount = csvTransactions[i + 4].toString();
    var depositAmount = csvTransactions[i + 6].toString();
    var balanceAmount = csvTransactions[i + 7].toString();
    var narration = csvTransactions[i + 8];

//    print(transactionDate +
//        '\t' +
//        withdrawAmount.toString() +
//        '\t' +
//        depositAmount +
//        '\t' +
//        balanceAmount +
//        '\t' +
//        narration);

    pnbTransactions.add(TransactionFromCsvEntity(
        DateFormat('d/M/yyyy').parse(transactionDate),
        withdrawAmount.isEmpty
            ? 0
            : double.parse(withdrawAmount.replaceAll(',', '')),
        depositAmount.isEmpty
            ? 0
            : double.parse(depositAmount.replaceAll(',', '')),
        double.parse(balanceAmount
            .substring(0, (balanceAmount.length - 4))
            .replaceAll(',', '')),
        narration));
  }
  return pnbTransactions;
}

Future<List<TransactionFromCsvEntity>> getPnbTransactionsFromCsv(
    String csvTransactionsFile, int headerLength, int footerLength) async {
  return getPnbTransactionBeansList(getPnbTransactionsWithoutHeaderAndFooter(
      await getPnbTransactionsListFromCsv(csvTransactionsFile),
      headerLength,
      footerLength));
}
