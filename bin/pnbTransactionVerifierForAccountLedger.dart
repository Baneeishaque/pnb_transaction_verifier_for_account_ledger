import 'package:pnb_transaction_verifier_for_account_ledger/pnbTransactionReaderForCsv.dart'
    as pnb_transaction_reader_for_csv;

Future<void> main(List<String> arguments) async {
//  print('Hello world: ${pnb_transaction_verifier_for_account_ledger.calculate()}!');

  var pnbTransactionsFromCsv =
      await pnb_transaction_reader_for_csv.getPnbTransactionsListWrapper(
          r'bin\4356XXXXXXXXX854501-08-2020.csv', 232, 209);
  pnbTransactionsFromCsv.forEach((transaction) {
    print(transaction);
  });
}
