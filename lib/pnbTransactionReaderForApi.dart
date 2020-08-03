import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:pnb_transaction_verifier_for_account_ledger/transactionFromApiEntity.dart';

//int calculate() {
//  return 6 * 7;
//}

Future<String> getPnbTransactionsResponse(String url) async {
  var apiResponse;
  try {
    // sends the request
    var response = await http.get(url);
    var responseStatusCode = response.statusCode;

    if (responseStatusCode == 200) {
      apiResponse = response.body;
      // prints the response
//      print(apiResponse);
    } else {
      print('Error - From Server, Status Code : ' +
          responseStatusCode.toString());
    }
  } on Error catch (exception) {
    print('Error - Exception : ' + exception.toString());
  }
  return apiResponse;
}

List<TransactionFromApiEntity> getPnbTransactionsFromResponse(
    String apiResponse) {
  var pnbTransactions;
  List<dynamic> apiResponseJson = convert.jsonDecode(apiResponse);
  if (apiResponseJson[0]['status'] == '0') {
    var transactionsJson = apiResponseJson.skip(1).toList();
    pnbTransactions = transactionsJson
        .map((dynamic transaction) =>
            TransactionFromApiEntity.fromJson(transaction))
        .toList();
  } else {
    print('Error - From Server Execution : ' + apiResponseJson[0]['error']);
  }
  return pnbTransactions;
}

Future<List<TransactionFromApiEntity>> getPnbTransactionsFromApi(
    String url) async {
  return getPnbTransactionsFromResponse(await getPnbTransactionsResponse(url));
}
