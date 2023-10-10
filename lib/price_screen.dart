import 'package:flutter/material.dart';
import 'package:bitcoin/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      hint: Text('USD'),
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          print(value);
          selectedCurrency = value;
          print(selectedCurrency);
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
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
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
            child: Card(
              color: Colors.blueGrey,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 28),
                child: Text(
                  "1 BTC = ? USD",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
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
