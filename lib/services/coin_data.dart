import 'package:bitcoin/services/networking.dart';
import 'package:bitcoin/utilities/constants.dart';

class CoinData{

  Future<dynamic> getCurrencyCryptoCoin(String coin, String crypto) async {
    Uri uri = Uri.https('rest.coinapi.io', '/v1/exchangerate/$crypto/$coin', {
      'apikey': apiKey,
    });
    NetworkHelper networkHelper = NetworkHelper(uri);

    var coinData = await networkHelper.getData();

    return coinData;
  }

}