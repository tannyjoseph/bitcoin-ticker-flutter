import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String apikey = '34B498FD-3E68-4E26-B967-A38F939D5941';

  Future getBitData(String coinType, String currency) async {
    var url =
        'https://rest.coinapi.io/v1/exchangerate/$coinType/$currency?apikey=$apikey';

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data)['rate'];
    } else {
      print(response.statusCode);
    }
  }
}
