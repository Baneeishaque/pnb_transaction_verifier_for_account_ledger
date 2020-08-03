import 'package:pnb_transaction_verifier_for_account_ledger/pnbTransactionReaderForApi.dart'
    as pnb_transaction_reader_for_api;
import 'package:pnb_transaction_verifier_for_account_ledger/pnbTransactionReaderForCsv.dart'
    as pnb_transaction_reader_for_csv;
import 'package:pnb_transaction_verifier_for_account_ledger/transactionFromApiEntity.dart';
import 'package:pnb_transaction_verifier_for_account_ledger/transactionFromCsvEntity.dart';

Future<void> main(List<String> arguments) async {
//  print('Hello world: ${pnb_transaction_verifier_for_account_ledger.calculate()}!');

  var pnbTransactionsFromCsv =
      await pnb_transaction_reader_for_csv.getPnbTransactionsFromCsv(
          r'bin\4356XXXXXXXXX854501-08-2020.csv', 232, 209);
//  pnbTransactionsFromCsv.forEach((transaction) {
//    print(transaction);
//  });

  //TODO : Use <Date,TransactionListForThatDate> Key Value Pairs instead of List<Transaction>

  var pnbTransactionFromApi =
      await pnb_transaction_reader_for_api.getPnbTransactionsFromApi(
          'http://account-ledger-server.herokuapp.com/http_API/select_User_Transactions_v2.php?user_id=13&account_id=11');
//  pnbTransactionFromApi.forEach((transaction) {
//    print(transaction);
//  });

  comparePnbTransactionsFromCsvAndApi(
      pnbTransactionsFromCsv, pnbTransactionFromApi);
}

void comparePnbTransactionsFromCsvAndApi(
    List<TransactionFromCsvEntity> pnbTransactionsFromCsv,
    List<TransactionFromApiEntity> pnbTransactionFromApi) {
  if (pnbTransactionsFromCsv.length != pnbTransactionFromApi.length) {
    print(
        'Error : Unmatched Transaction Lists, please equalize the size of lists...');
  }
}
