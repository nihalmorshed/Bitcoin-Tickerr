import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;

class PriceScreen extends StatefulWidget {
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String selectedCrypto = 'ETH';
  double exchangeRate = 0.0;
  Map<String, double> exchangeRates = {};

  @override
  void initState() {
    super.initState();
    getExchangeRate(selectedCrypto, selectedCurrency);
  }

  Future<void> getExchangeRates() async {
    for (String crypto in cryptoList.map((e) => e['id']!).toList()) {
      // At the moment , dont understand
      NetworkHelper networkHelper =
          NetworkHelper(Crypto: crypto, Currency: selectedCurrency);
      var exchangerateData = await networkHelper.getData();
      setState(() {
        exchangeRates[crypto] = exchangerateData['rate'];
      });
    }
  }

  Future getExchangeRate(String cr, String cur) async {
    NetworkHelper networkHelper = NetworkHelper(
      Crypto: cr,
      Currency: cur,
    );
    var exchangerateData = await networkHelper.getData();
    setState(() {
      exchangeRate = exchangerateData['rate'];
    });
    return exchangerateData;
  }

  Widget getCryptoList() {
    return ListView.builder(
      itemCount: cryptoList.length,
      itemBuilder: (BuildContext context, int index) {
        String id = cryptoList[index]['id']!;
        String name = cryptoList[index]['name']!;
        FadeInImage img = FadeInImage.assetNetwork(
          placeholder: 'assets/loading.gif',
          image: cryptoList[index]['icon']!,
        );
        double rate = exchangeRates[id] ?? 0.0;
        return Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              color: Colors.purple[300],
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.purple[400],
                  backgroundImage: img.image,
                ),
                title: Text("$name"),
                subtitle: Text("$id"),
                trailing: Text(
                  "${rate.toStringAsFixed(2)} $selectedCurrency",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }

  Widget getDropDownButton() {
    List<DropdownMenuItem> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(
          currency,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton(
        value: selectedCurrency,
        dropdownColor: Colors.lightBlue,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value.toString();
            getExchangeRate(selectedCrypto, selectedCurrency);
          });
          print(value);
        });
  }

  Widget getCupertinoPicker() {
    List<Widget> pickerItems = [];
    for (var i in currenciesList) {
      var newItem = Text(i);
      pickerItems.add(newItem);
    }
    return CupertinoPicker(
      itemExtent: 31,
      scrollController: FixedExtentScrollController(
        initialItem: currenciesList.indexOf(selectedCurrency),
      ),
      onSelectedItemChanged: (index) {
        print(currenciesList[index]);
        setState(() {
          selectedCurrency = currenciesList[index];
          getExchangeRate(selectedCrypto, selectedCurrency);
        });
      },
      children: pickerItems,
    );
  }

  // Widget selectWidget() {
  //   if (kIsWeb) {
  //     return getCupertinoPicker();
  //   } else if (defaultTargetPlatform == TargetPlatform.iOS) {
  //     return getCupertinoPicker();
  //   } else if (defaultTargetPlatform == TargetPlatform.linux ||
  //       defaultTargetPlatform == TargetPlatform.macOS ||
  //       defaultTargetPlatform == TargetPlatform.windows ||
  //       defaultTargetPlatform == TargetPlatform.android) {
  //     return getDropDownButton();
  //   }
  //   return getCupertinoPicker();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('🤑 Coin Ticker'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          //   child:
          //   Card(
          //     color: Colors.lightBlueAccent,
          //     elevation: 6,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(
          //         vertical: 15,
          //         horizontal: 28,
          //       ),
          //       child:
          //       Text(
          //         '1 $selectedCrypto = ${exchangeRate.toStringAsFixed(2)} $selectedCurrency',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 20,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            flex: 4,
            child: getCryptoList(),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Colors.lightBlue,
                border: Border.all(
                  color: Colors.blueGrey,
                  width: 3,
                ),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                bottom: 15,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Select your currency',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // TargetPlatform.android == defaultTargetPlatform
                    //     ? getDropDownButton()
                    //     : getCupertinoPicker(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
