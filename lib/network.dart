import 'dart:convert';

import 'package:bitcoin_ticker/constants.dart';
import 'package:http/http.dart';

class NetworkHelper {
  final String Crypto;
  final String Currency;
  NetworkHelper({required this.Crypto, required this.Currency});

  Future getData() async {
    Response response =
        await get(Uri.parse('$apiURL/$Crypto/$Currency?apikey=$apiKey'));
    print('Body:\n');
    print(response.body);

    var decodeData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return decodeData;
    } else {
      return response.statusCode;
    }
  }
  // void getExchangeRate() async {

  //   var exchangerateData = await networkHelper.getData();
  //   setState(() {
  //     exchangeRate = exchangerateData['rate'];
  //   });
  // }
}
