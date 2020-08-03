import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pnb_transaction_verifier_for_account_ledger/pnbTransactionReaderForApi.dart'
    as pnb_transaction_reader_for_api;
import 'package:pnb_transaction_verifier_for_account_ledger/pnbTransactionReaderForCsv.dart'
    as pnb_transaction_reader_for_csv;
import 'package:pnb_transaction_verifier_for_account_ledger/transactionFromApiEntity.dart';
import 'package:pnb_transaction_verifier_for_account_ledger/transactionFromCsvEntity.dart';
import 'package:path/path.dart';

Future<void> main(List<String> arguments) async {
//  print('Hello world: ${pnb_transaction_verifier_for_account_ledger.calculate()}!');

  var fromAccountId = '11';
  var pnbTransactionsFromCsv =
      await pnb_transaction_reader_for_csv.getPnbTransactionsFromCsv(
          join(dirname(Platform.script.toFilePath()),
              '4356XXXXXXXXX854501-08-2020.csv'),
          232,
          209);
//  pnbTransactionsFromCsv.forEach((transaction) {
//    print(transaction);
//  });

  //TODO : Use <Date,TransactionListForThatDate> Key Value Pairs instead of List<Transaction>

  var pnbTransactionFromApi =
      await pnb_transaction_reader_for_api.getPnbTransactionsFromApi(
          'http://account-ledger-server.herokuapp.com/http_API/select_User_Transactions_v2.php?user_id=13&account_id=' +
              fromAccountId);
//  pnbTransactionFromApi.forEach((transaction) {
//    print(transaction);
//  });

  comparePnbTransactionsListFromCsvAndApi(
      pnbTransactionsFromCsv.reversed.skip(551).take(536).toList(),
      pnbTransactionFromApi,
      fromAccountId);
}

void comparePnbTransactionsListFromCsvAndApi(
    List<TransactionFromCsvEntity> pnbTransactionsFromCsv,
    List<TransactionFromApiEntity> pnbTransactionFromApi,
    String fromAccountId) {
  var pnbTransactionsFromCsvSize = pnbTransactionsFromCsv.length;
  if (pnbTransactionsFromCsvSize != pnbTransactionFromApi.length) {
    print(
        'Warning : Unmatched Transaction Lists, please equalize the size of lists...\n');
  }
  var unmatchedEntriesCount = 0;
  for (var i = 0; i < pnbTransactionsFromCsvSize; i++) {
    if (comparePnbTransactionsFromCsvAndApi(pnbTransactionsFromCsv[i],
            pnbTransactionFromApi[i], fromAccountId) ==
        false) {
      unmatchedEntriesCount++;
    }
  }
  print('No. of Unmatched Entries : ' + unmatchedEntriesCount.toString());
}

bool comparePnbTransactionsFromCsvAndApi(
    TransactionFromCsvEntity pnbTransactionFromCsv,
    TransactionFromApiEntity pnbTransactionFromApi,
    String fromAccountId) {
  var result = true;
  var dateOfTransactionFromApi =
      DateFormat('yyyy-M-d').parse(pnbTransactionFromApi.eventDateTime);
  if (pnbTransactionFromCsv.transactionDate != dateOfTransactionFromApi) {
    print('\n' + pnbTransactionFromCsv.toString());
    print(pnbTransactionFromApi.toString());
    print('Error - Unmatched transaction dates...\n');
    result = false;
  } else {
    if (pnbTransactionFromApi.fromAccountId == fromAccountId) {
      if (pnbTransactionFromCsv.withDrawAmount !=
          double.parse(pnbTransactionFromApi.amount)) {
        print('\n' + pnbTransactionFromCsv.toString());
        print(pnbTransactionFromApi.toString());
        print('Error - Unmatched withdraw amount...\n');
        result = false;
      }
    } else {
      if (pnbTransactionFromCsv.depositAmount !=
          double.parse(pnbTransactionFromApi.amount)) {
        print('\n' + pnbTransactionFromCsv.toString());
        print(pnbTransactionFromApi.toString());
        print('Error - Unmatched deposit amount...\n');
        result = false;
      }
    }
  }
  return result;
}
