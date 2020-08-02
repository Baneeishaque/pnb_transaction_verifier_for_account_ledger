import 'package:pnb_transaction_verifier_for_account_ledger/pnb_transaction_verifier_for_account_ledger.dart'
    as pnb_transaction_verifier_for_account_ledger;

void main(List<String> arguments) {
//  print('Hello world: ${pnb_transaction_verifier_for_account_ledger.calculate()}!');
  pnb_transaction_verifier_for_account_ledger
      .printTransactionsFromCsv(r'bin\4356XXXXXXXXX854501-08-2020.csv');
}
