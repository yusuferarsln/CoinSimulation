import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_sim/ui/auth/auth_services.dart';
import 'package:flutter/material.dart';

class CoinDetail extends StatefulWidget {
  var coinNumber;
  var coinName;
  var boughtPrice;
  var boughtDate;

  CoinDetail(
      {Key? key,
      @required coinNumber,
      @required coinName,
      @required boughtPrice,
      @required boughtDate})
      : super(key: key);

  @override
  State<CoinDetail> createState() => _CoinDetailState();
}

class _CoinDetailState extends State<CoinDetail> {
  int? coinNumber;
  String? coinName;
  var boughtPrice;
  Timestamp? boughtDate;


  @override
  Widget build(BuildContext context) {
    


    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('CoinSim'),
        actions: [
          InkWell(
            child: Icon(Icons.logout),
            onTap: () {
              AuthController.instance.logOut();
            },
          )
        ],
      ),
      body: Column(children: [
        Text(coinName.toString()),
      ]),
    );
  }
}
