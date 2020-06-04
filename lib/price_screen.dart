import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String val = 'EUR';
  CoinData coinData = CoinData();
  var btcRate, ethRate, ltcRate;

  @override
  void initState() {
    super.initState();
    getRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buttons('BTC', val, btcRate),
          buttons('ETH', val, ethRate),
          buttons('LTC', val, ltcRate),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              items: buildLoop(),
              onChanged: (value) async {

                setState(() {
                  val = value;
                });

                getRate();

              },
              value: val,
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem> buildLoop() {
    List<DropdownMenuItem<String>> values = [];
    for (int i = 0; i < currenciesList.length; i++) {
      var newItem = DropdownMenuItem(
          child: Text(currenciesList[i]), value: currenciesList[i]);
      values.add(newItem);
    }

    return values;
  }

  void getRate() async {
    btcRate = await coinData.getBitData('BTC', val);
    ethRate = await coinData.getBitData('ETH', val);
    ltcRate = await coinData.getBitData('LTC', val);

    setState(() {
      btcRate = btcRate.round();
      ethRate = ethRate.round();
      ltcRate = ltcRate.round();
    });

  }

  Widget buttons(String coinType, String currency, int rate){
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $coinType = $rate $currency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
