import 'package:bitcoin/services/coin_data.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency;
  CoinData coinData = CoinData();
  String? currencyValue;
  int currencyIndex = 0;
  String bitCoinValue = '?';
  String ethereumValue = '?';
  String liteCoinValue = '?';


  void upDateUIbitCoin(dynamic coinData){
    setState(() {
      if(coinData == null){
        currencyValue = 'Error';
        return;
      }
      String value = coinData['rate'].toStringAsFixed(3);
      print(value);
      bitCoinValue = value;
    });
  }
  void upDateUIEthereum(dynamic coinData){
    setState(() {
      if(coinData == null){
        currencyValue = 'Error';
        return;
      }
      String value = coinData['rate'].toStringAsFixed(3);
      print(value);
      ethereumValue = value;
    });
  }
  void upDateUIliteCoin(dynamic coinData){
    setState(() {
      if(coinData == null){
        currencyValue = 'Error';
        return;
      }
      String value = coinData['rate'].toStringAsFixed(3);
      print(value);
      liteCoinValue = value;
    });
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      hint: const Text('USD'),
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          //print(value);
          selectedCurrency = value;
          //print(selectedCurrency);
        });
      },
    );
  }

  CupertinoPicker iOSPicker(){
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) async {
        var bitcoin = await coinData.getCurrencyCryptoCoin(currenciesList[selectedIndex], 'BTC');
        var ethereum = await coinData.getCurrencyCryptoCoin(currenciesList[selectedIndex], 'ETH');
        var litecoin = await coinData.getCurrencyCryptoCoin(currenciesList[selectedIndex], 'LTC');
        //print(coin);
        setState(()  {
          currencyIndex = selectedIndex;
          print(selectedIndex);
          upDateUIbitCoin(bitcoin);
          upDateUIEthereum(ethereum);
          upDateUIliteCoin(litecoin);
        });
      },
      children: pickerItems,
    );
  }

  // Widget getPicker(){
  //   if(Platform.isIOS){
  //     return iOSPicker();
  //   } else if(Platform.isAndroid){
  //     return androidDropdown();
  //   } else {
  //     return Container();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin Ticker'),
        backgroundColor: Colors.white24,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.blueGrey,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 28),
                    child: Text(
                      "1 BTC = $bitCoinValue ${currenciesList[currencyIndex]}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.blueGrey,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 28),
                    child: Text(
                      "1 ETH = $ethereumValue ${currenciesList[currencyIndex]}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.blueGrey,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 28),
                    child: Text(
                      "1 LCT = $liteCoinValue ${currenciesList[currencyIndex]}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30),
            color: Colors.white24,
            child: Platform.isIOS? iOSPicker() : androidDropdown(),
          )
        ],
      ),
    );
  }
}
